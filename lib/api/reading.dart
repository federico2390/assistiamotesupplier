import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/palace.dart';
import 'package:adminpanel/providers/palace.dart';
import 'package:adminpanel/providers/reading.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ReadingApi {
  Future postReading(
    BuildContext context,
    TextEditingController valueController,
  ) async {
    try {
      var uuid = const Uuid();
      var datetimeFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
      final user = await context.read<UserProvider>().getLocalUser();
      Palace palace = context
          .read<PalaceProvider>()
          .palaces[context.read<PalaceProvider>().selectedPalace];

      final imageList = context.read<ReadingProvider>().images;

      await Alerts.loadingAlert(context,
          title: 'Attendi...', subtitle: 'Invio la lettura');

      List<MultipartFile> multipartImageList = imageList
          .map((image) => MultipartFile.fromFileSync(
                image.path,
                contentType: MediaType('image', image.path.split('.').last),
                filename: '${uuid.v1()}.${image.path.split('.').last}',
              ))
          .toList();

      FormData formData = FormData.fromMap({
        'user_id': user.userId!.isNotEmpty ? user.userId!.trim() : '',
        'palace_id': palace.palaceId!.isNotEmpty ? palace.palaceId : '',
        'value':
            valueController.text.isNotEmpty ? valueController.text.trim() : '',
        'media_1': multipartImageList.isNotEmpty ? multipartImageList[0] : '',
        'media_2': multipartImageList.length == 2
            ? multipartImageList[1]
            : multipartImageList.length == 3
                ? multipartImageList[1]
                : '',
        'media_3': multipartImageList.length == 3 ? multipartImageList[2] : '',
        'reading_datetime': datetimeFormat.format(DateTime.now()),
      });

      var response = await Dio().post(
        AppConst.reading,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        valueController.clear();
        context.read<ReadingProvider>().removeAllImage();
        await Alerts.hideAlert();
        await Alerts.successAlert(
          context,
          title: 'Inviata',
          subtitle: 'Inviata correttamente',
        );
      } else {
        print(
            'Operation not uploaded - server response: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
  }
}
