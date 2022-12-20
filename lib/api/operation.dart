import 'dart:developer';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/central.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Operation {
  Future postOperation(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController operationTypeController,
    TextEditingController operationController,
    TextEditingController descriptionController,
  ) async {
    try {
      var uuid = const Uuid();
      final user = await context.read<UserProvider>().getUser();
      final imageList = context.read<OperationProvider>().images;

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
        'user_id': user.userId!.isNotEmpty ? user.userId!.trim() : '',
        'palace_id': user.palaceId!.isNotEmpty ? user.palaceId!.trim() : '',
        'operation_type': operationTypeController.text.isNotEmpty
            ? operationTypeController.text.trim()
            : '',
        'operation': operationController.text.isNotEmpty
            ? operationController.text.trim()
            : '',
        'description': descriptionController.text.isNotEmpty
            ? descriptionController.text.trim()
            : '',
        'media_1': multipartImageList.isNotEmpty ? multipartImageList[0] : '',
        'media_2': multipartImageList.length == 2
            ? multipartImageList[1]
            : multipartImageList.length == 3
                ? multipartImageList[1]
                : '',
        'media_3': multipartImageList.length == 3 ? multipartImageList[2] : '',
      });

      var response = await Dio().post(
        AppConst.operation,
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Operation uploaded - server response: ${response.statusCode}');
        formKey.currentState!.reset();
        operationTypeController.clear();
        operationController.clear();
        descriptionController.clear();
        context.read<OperationProvider>().removeAllImage();
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
