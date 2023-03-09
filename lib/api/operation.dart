import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/palace.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';

class OperationApi {
  Future<List<Operation>> getOperations(BuildContext context) async {
    List<Operation> operations = [];

    try {
      final user = await context.read<UserProvider>().getLocalUser();

      if (user.userId != null && user.userId!.isNotEmpty) {
        final palace = context
            .read<PalaceProvider>()
            .palaces[context.read<PalaceProvider>().selectedPalace];

        var response = await http.post(
          Uri.parse(AppConst.operation),
          body: {
            'get_operation': 'get_operation',
            'user_id': user.userId,
            'palace_id': palace.palaceId,
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          List<Operation> operationsList = [];
          for (var operation in operationFromJson(response.body)) {
            Operation media = Operation(
              operationId: operation.operationId,
              palaceId: operation.palaceId,
              userId: operation.userId,
              operationType: operation.operationType,
              operation: operation.operation,
              description: operation.description,
              supplierId: operation.supplierId,
              supplierDescription: operation.supplierDescription,
              operationDatetime: operation.operationDatetime,
              palaceName: operation.palaceName,
              palaceCf: operation.palaceCf,
              palaceAddress: operation.palaceAddress,
              palaceUtilsName: operation.palaceUtilsName,
              palaceUtilsNumber: operation.palaceUtilsNumber,
              palaceDescription: operation.palaceDescription,
              userEmail: operation.userEmail,
              userUsername: operation.userUsername,
              userName: operation.userName,
              userCf: operation.userCf,
              userPassword: operation.userPassword,
              userToken: operation.userToken,
              notification: operation.notification,
              firstTimeLogged: operation.firstTimeLogged,
              supplierName: operation.supplierName,
              supplierType: operation.supplierType,
              supplierCf: operation.supplierCf,
              operationState: operation.operationState,
              operationViewed: operation.operationViewed,
              operationWorking: operation.operationWorking,
              operationOpened: operation.operationOpened,
              operationLastUpdate: operation.operationLastUpdate,
              media: [
                operation.media1!,
                operation.media2!,
                operation.media3!,
              ],
              supplierMedia: [
                operation.supplierMedia1!,
                operation.supplierMedia2!,
              ],
            );
            operationsList.add(media);
          }

          for (var element in operationsList) {
            for (var i = 0; i < element.media!.length; i++) {
              element.media!.removeWhere((item) => item.isEmpty);
            }
          }

          operations = operationsList;
        } else {
          print('Can\'t get Operations');
        }
      }
    } catch (error) {
      print('ERROR_getOperations: $error');
    }
    return operations;
  }

  Future addOperation(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController operationTypeController,
    TextEditingController operationController,
    TextEditingController descriptionController,
  ) async {
    try {
      var uuid = const Uuid();
      var datetimeFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
      final user = await context.read<UserProvider>().getLocalUser();
      final palace = context
          .read<PalaceProvider>()
          .palaces[context.read<PalaceProvider>().selectedPalace];

      final imageList = context.read<OperationProvider>().images;

      await Alerts.loadingAlert(context,
          title: 'Attendi...', subtitle: 'Invio l\'intervento');

      List<MultipartFile> multipartImageList = imageList
          .map((image) => MultipartFile.fromFileSync(
                image.path,
                contentType: MediaType('image', image.path.split('.').last),
                filename: '${uuid.v1()}.${image.path.split('.').last}',
              ))
          .toList();

      FormData formData = FormData.fromMap({
        'add_operation': 'add_operation',
        'user_id': user.userId!.isNotEmpty ? user.userId!.trim() : '',
        'palace_id': palace.palaceId!.isNotEmpty ? palace.palaceId : '',
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
        'operation_datetime': datetimeFormat.format(DateTime.now()),
      });

      var response = await Dio().post(
        AppConst.operation,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        formKey.currentState!.reset();
        operationTypeController.clear();
        operationController.clear();
        descriptionController.clear();
        context.read<OperationProvider>().removeAllImage();
        await Alerts.hideAlert();
        await Alerts.successAlert(
          context,
          title: 'Inviato',
          subtitle: 'Inviato correttamente',
        );
      } else {
        print(
            'Operation not uploaded - server response: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future markOperationAsOpened(Operation operation) async {
    try {
      var response = await http.post(
        Uri.parse(AppConst.operation),
        body: {
          'mark_as_opened': 'mark_as_opened',
          'operation_id': operation.operationId,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        print('Can\'t mark as opened Operation');
      }
    } catch (error) {
      print('ERROR_markOperationAsOpened: $error');
    }
  }
}
