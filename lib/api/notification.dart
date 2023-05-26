import 'dart:convert';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/number.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/state.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationApi {
  Future sendToUser({
    required BuildContext context,
    required String title,
    required String message,
    required Operation operation,
    required Number number,
    required String popupTitle,
    required String popupMessage,
  }) async {
    try {
      var whatsappBody = {
        'send_whatsapp_message': 'send_whatsapp_message',
        'from': AppConst.clientPhone,
        'to': number.userNumber,
        'body':
            'Condominio *${operation.palaceAddress!.toUpperCase().trim()}*\n\n*${title.toUpperCase().trim()}*\n\n${message.trim()}',
      };

      var whatsappResponse = await AppConst().client.post(
            kIsWeb
                ? Uri.parse(AppConst.sender).replace(host: AppConst.domain)
                : Uri.parse(AppConst.sender),
            body: whatsappBody,
          );
      if (whatsappResponse.statusCode == 200 ||
          whatsappResponse.statusCode == 201) {
        await Alerts.successAlert(
          context,
          title: popupTitle,
          subtitle: popupMessage,
        );
      } else {
        print('Can\'t send whatsapp message');
        await Alerts.errorAlert(context,
            title: 'Non inviato',
            subtitle: 'Qualcosa è andato storto!\nRiprova tra poco');
      }
    } catch (error) {
      print('ERROR_sendToUser: $error');
    } finally {
      AppConst().client.close();
      await context.read<StateProvider>().buildFuture(context);
      await Alerts.hideAlert();
    }
  }

  Future sendToPalace({
    required BuildContext context,
    required String title,
    required String message,
    required Operation operation,
    required List<Number> numbers,
    required String popupTitle,
    required String popupMessage,
  }) async {
    try {
      List<String> numbersList = numbers
          .where((e) => e.userNumber!.isNotEmpty)
          .map((e) => e.userNumber!)
          .toList();

      var whatsappBody = {
        'send_whatsapp_messages': 'send_whatsapp_messages',
        'from': AppConst.clientPhone,
        'numbers': json.encode(numbersList),
        'body':
            'Condominio *${operation.palaceAddress!.toUpperCase().trim()}*\n\n*${title.toUpperCase().trim()}*\n\n${message.trim()}',
      };

      var whatsappResponse = await AppConst().client.post(
            Uri.parse(AppConst.sender).replace(host: AppConst.domain),
            body: whatsappBody,
          );
      if (whatsappResponse.statusCode == 200 ||
          whatsappResponse.statusCode == 201) {
        await Alerts.successAlert(
          context,
          title: popupTitle,
          subtitle: popupMessage,
        );
      } else {
        print('Can\'t send WhatsApp message');
        await Alerts.errorAlert(context,
            title: 'Non inviato',
            subtitle: 'Qualcosa è andato storto!\nRiprova tra poco');
      }
    } catch (error) {
      print('ERROR_sendToPalace: $error');
    } finally {
      AppConst().client.close();
      await context.read<StateProvider>().buildFuture(context);
      await Alerts.hideAlert();
    }
  }
}
