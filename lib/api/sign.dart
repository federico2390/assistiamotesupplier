import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/operation.dart';
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
    Uint8List sign,
  ) async {
    var dateTime = DateFormat('dd/MM/yyyy HH:mm:ss');

    try {
      var response = await AppConst().client.post(
        kIsWeb
            ? Uri.parse(AppConst.operation).replace(host: AppConst.domain)
            : Uri.parse(AppConst.operation),
        body: {
          'upload_sign': 'upload_sign',
          'operation_id': operation.operationId,
          'signedUrl': sign,
          'signedDateTime': dateTime.format(DateTime.now()),
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await Alerts.successAlert(
          context,
          title: 'Salvata',
          subtitle: 'Firma salvata',
        );
      } else {
        print('Can\'t Upload Sign');
      }
    } catch (error) {
      print('ERROR_muploadSign: $error');
    } finally {
      AppConst().client.close();
      await context.read<StateProvider>().buildFuture(context);
    }
  }
}
