import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

Future postOperation(
  BuildContext context,
  String operationType,
  String operation,
  String description,
) async {
  try {
    var uuid = const Uuid();
    final user = await context.read<UserProvider>().getUser();
    final imageList = context.read<OperationProvider>().images;

    Alerts.loadingAlert(context,
        title: 'Attendi...', subtitle: 'Invio la richiesta');

    for (var image in imageList) {
      MultipartFile multipartFile = MultipartFile.fromFileSync(
        image.path,
        contentType: MediaType('image', image.path.split('.').last),
        filename: '${uuid.v1()}.${image.path.split('.').last}',
      );

      FormData formData = FormData.fromMap({
        'user_id': user.userId!,
        'palace_id': user.palaceId!,
        'operation_type': operationType,
        'operation': operation,
        'description': description,
        "media": multipartFile,
      });

      var response = await Dio().post(
        AppConst.operation,
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Operation uploaded - server response: ${response.statusCode}');
      } else {
        print(
            'Operation not uploaded - server response: ${response.statusCode}');
      }
    }
  } catch (error) {
    print(error);
  }
  Alerts.hide;
}
