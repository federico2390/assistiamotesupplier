import 'dart:convert';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/signature.dart';
import 'package:adminpanel/providers/state.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SignApi {
  Future uploadSign(
    BuildContext context,
    Operation operation,
    Uint8List byteImage,
  ) async {
    var dateTime = DateFormat('dd/MM/yyyy HH:mm:ss');

    try {
      var requestBody = {
        'upload_sign': 'upload_sign',
        'operation_id': operation.operationId,
        'signed_url': base64Encode(byteImage),
        'signed_dateTime': dateTime.format(DateTime.now()),
      };

      var response = await AppConst().client.post(
            kIsWeb
                ? Uri.parse(AppConst.sign).replace(host: AppConst.domain)
                : Uri.parse(AppConst.sign),
            body: requestBody,
          );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await Alerts.hideAlert();
        await Alerts.successAlert(
          context,
          title: 'Salvata',
          subtitle: 'Firma salvata',
        );
      } else {
        debugPrint('Can\'t Upload Sign');
      }
    } catch (error) {
      debugPrint('ERROR_muploadSign: $error');
    } finally {
      AppConst().client.close();
      context.read<SignatureProvider>().clearCanvas();
      await context.read<StateProvider>().buildFuture(context);
      Navigator.of(context).pop();
    }
  }
}
