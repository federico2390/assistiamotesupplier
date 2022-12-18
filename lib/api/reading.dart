import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/central.dart';
import 'package:adminpanel/providers/reading.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Reading {
  Future postReading(
    BuildContext context,
    TextEditingController valueController,
  ) async {
    try {
      var uuid = const Uuid();
      final user = await context.read<UserProvider>().getUser();
      final imageList = context.read<ReadingProvider>().images;

      Alerts.loadingAlert(context,
          title: 'Attendi...', subtitle: 'Invio la richiesta');

      List<MultipartFile> multipartImageList = imageList
          .map((image) => MultipartFile.fromFileSync(
                image.path,
                contentType: MediaType('image', image.path.split('.').last),
                filename: '${uuid.v1()}.${image.path.split('.').last}',
              ))
          .toList();

      FormData formData = FormData.fromMap({
        'user_id': user.userId!.trim(),
        'palace_id': user.palaceId!.trim(),
        'value': valueController.text.trim(),
        'media_1': multipartImageList[0],
        'media_2': multipartImageList[1],
        'media_3': multipartImageList[2]
      });

      var response = await Dio().post(
        AppConst.reading,
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Operation uploaded - server response: ${response.statusCode}');
        valueController.clear();
        context.read<ReadingProvider>().removeAllImage();
      } else {
        print(
            'Operation not uploaded - server response: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
    Alerts.hide;
    context.read<CentralProvider>().isLoading(false);
  }
}
