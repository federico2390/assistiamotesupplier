import 'package:adminpanel/api/notification.dart';
import 'package:adminpanel/models/token.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

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
          kIsWeb
              ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
              : Uri.parse(AppConst.operation),
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
              supplierOpened: operation.supplierOpened,
              operationLastUpdate: operation.operationLastUpdate,
              supplierIsLogged: operation.supplierIsLogged,
              requestBy: operation.requestBy,
              yearId: operation.yearId,
              yearValue: operation.yearValue,
              supplierToken: operation.supplierToken,
              supplierEmail: operation.supplierEmail,
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

  Future editOperation(
    BuildContext context,
    Operation operation,
    String description,
  ) async {
    try {
      await Alerts.loadingAlert(context,
          title: 'Attendi...', subtitle: 'Invio la richiesta');

      var datetimeFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

      final imageList = context.read<OperationProvider>().images;

      List<MultipartFile> multipartImageList = await Future.wait(imageList.map(
        (image) async => MultipartFile.fromBytes(
          await image.readAsBytes(),
          contentType: MediaType('image', extension(image.path)),
          filename: basename(image.path),
        ),
      ));

      Future<MultipartFile> getMultipartFileFromUrl(String url) async {
        final response = await http.get(kIsWeb
            ? Uri.parse(url).replace(host: AppConst.domain)
            : Uri.parse(url));
        final bytes = response.bodyBytes;
        final contentType = MediaType('image', extension(url));
        final filename = basename(url);

        return MultipartFile.fromBytes(
          bytes,
          contentType: contentType,
          filename: filename,
        );
      }

      FormData formData = FormData.fromMap({
        'edit_operation': 'edit_operation',
        'operation_id': operation.operationId!.trim(),
        'supplier_description': operation.supplierDescription!.isNotEmpty
            ? operation.supplierDescription!
            : description.trim(),
        'supplier_media_1': operation.supplierMedia![0].isNotEmpty
            ? await getMultipartFileFromUrl(operation.supplierMedia![0])
            : multipartImageList.isNotEmpty &&
                    operation.supplierMedia![0].isEmpty
                ? multipartImageList[0]
                : '',
        'supplier_media_2': operation.supplierMedia![1].isNotEmpty
            ? await getMultipartFileFromUrl(operation.supplierMedia![1])
            : multipartImageList.length == 2
                ? multipartImageList[1]
                : multipartImageList.length == 1 &&
                        operation.supplierMedia![0].isNotEmpty
                    ? multipartImageList[0]
                    : '',
        'operation_last_update': datetimeFormat.format(DateTime.now()),
      });

      var response = await Dio().post(
        AppConst.operation,
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Token> tokens = [];

        try {
          var response = await http.post(
            kIsWeb
                ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
                : Uri.parse(AppConst.operation),
            body: {
              'get_tokens': 'get_tokens',
              'operation_id': operation.operationId!.trim(),
            },
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            tokens = tokenFromJson(response.body);
            if (operation.operation == 'Condominiale') {
              await NotificationApi().sendToPalace(
                context: context,
                title: 'Richiesta d\'intervento aggiornata',
                message:
                    'Il fornitore ha inserito delle informazioni riguardanti il tuo intervento',
                operation: operation,
                tokens: tokens,
                popupTitle: 'Aggiornato',
                popupMessage: 'Intervento aggiornato',
              );
            } else {
              await NotificationApi().sendToUser(
                context: context,
                title: 'Richiesta d\'intervento aggiornata',
                message:
                    'Il fornitore ha inserito delle informazioni riguardanti il tuo intervento',
                operation: operation,
                tokens: tokens,
                popupTitle: 'Aggiornato',
                popupMessage: 'Intervento aggiornato',
              );
            }
          }
        } catch (error) {
          print('ERROR_getTokens: $error');
        }
      } else {
        print('Can\'t edit Operation');
      }
    } catch (error) {
      print('ERROR_editOperation: $error');
    }
  }

  Future markOperationAsOpened(
      BuildContext context, Operation operation) async {
    try {
      var response = await http.post(
        kIsWeb
            ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
            : Uri.parse(AppConst.operation),
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

  Future markOperationAsWorking(
    BuildContext context,
    Operation operation,
    String operationWorking,
  ) async {
    try {
      var response = await http.post(
        kIsWeb
            ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
            : Uri.parse(AppConst.operation),
        body: {
          'mark_as_working': 'mark_as_working',
          'operation_id': operation.operationId,
          'operation_working': operationWorking,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Token> tokens = [];

        try {
          var response = await http.post(
            kIsWeb
                ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
                : Uri.parse(AppConst.operation),
            body: {
              'get_tokens': 'get_tokens',
              'operation_id': operation.operationId!.trim(),
            },
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            tokens = tokenFromJson(response.body);
            if (operation.operation == 'Condominiale') {
              await NotificationApi().sendToPalace(
                context: context,
                title: 'Intervento in corso',
                message:
                    'Il fornitore ha cambiato lo stato dell\'intervento a "In corso"',
                operation: operation,
                tokens: tokens,
                popupTitle: 'In corso',
                popupMessage: 'Intervento In corso',
              );
            } else {
              await NotificationApi().sendToUser(
                context: context,
                title: 'Intervento in corso',
                message:
                    'Il fornitore ha cambiato lo stato dell\'intervento a "In corso"',
                operation: operation,
                tokens: tokens,
                popupTitle: 'In corso',
                popupMessage: 'Intervento In corso',
              );
            }
          }
        } catch (error) {
          print('ERROR_getTokens: $error');
        }
      } else {
        print('Can\'t mark as working Operation');
      }
    } catch (error) {
      print('ERROR_markOperationAsWorking: $error');
    }
  }

  Future markOperationAsClosed(
    BuildContext context,
    Operation operation,
    String operationState,
  ) async {
    try {
      var response = await http.post(
        kIsWeb
            ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
            : Uri.parse(AppConst.operation),
        body: {
          'mark_as_closed': 'mark_as_closed',
          'operation_id': operation.operationId,
          'operation_state': operationState,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Token> tokens = [];

        try {
          var response = await http.post(
            kIsWeb
                ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
                : Uri.parse(AppConst.operation),
            body: {
              'get_tokens': 'get_tokens',
              'operation_id': operation.operationId!.trim(),
            },
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            tokens = tokenFromJson(response.body);
            if (operation.operation == 'Condominiale') {
              await NotificationApi().sendToPalace(
                context: context,
                title: 'Intervento chiuso',
                message:
                    'Il fornitore ha cambiato lo stato dell\'intervento a "Chiuso"',
                operation: operation,
                tokens: tokens,
                popupTitle: 'Chiuso',
                popupMessage: 'Intervento Chiuso',
              );
            } else {
              await NotificationApi().sendToUser(
                context: context,
                title: 'Intervento chiuso',
                message:
                    'Il fornitore ha cambiato lo stato dell\'intervento a "Chiuso"',
                operation: operation,
                tokens: tokens,
                popupTitle: 'Chiuso',
                popupMessage: 'Intervento Chiuso',
              );
            }
          }
        } catch (error) {
          print('ERROR_getTokens: $error');
        }
      } else {
        print('Can\'t close Operation');
      }
    } catch (error) {
      print('ERROR_markOperationAsClosed: $error');
    }
  }
}
