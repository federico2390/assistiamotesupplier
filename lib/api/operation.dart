import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/user.dart';

class OperationApi {
  Future<List<Operation>> getOperations(BuildContext context) async {
    List<Operation> operations = [];

    try {
      final user = await context.read<UserProvider>().getLocalUser();

      if (user.supplierId != null && user.supplierId!.isNotEmpty) {
        var response = await http.post(
          Uri.parse(AppConst.operation),
          body: {
            'get_operation': 'get_operation',
            'supplier_email': user.supplierEmail,
            'supplier_cf': user.supplierCf,
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
              supplierName: operation.supplierName,
              supplierType: operation.supplierType,
              supplierCf: operation.supplierCf,
              notification: operation.notification,
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
