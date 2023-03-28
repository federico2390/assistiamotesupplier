import 'dart:convert';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/models/token.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationApi {
  Future sendToUser({
    required BuildContext context,
    required String title,
    required String message,
    required Operation operation,
    required List<Token> tokens,
  }) async {
    try {
      var response = await http.post(
        Uri.parse(AppConst.firebaseBaseurl),
        headers: {
          "Authorization": "key=${AppConst.firebaseAuthKey}",
          "Content-Type": "application/json"
        },
        body: json.encode(
          {
            "registration_ids": tokens.map((e) => e.userToken).toList(),
            "notification": {
              "title": title.trim(),
              "body":
                  'Condominio ${operation.palaceAddress}: ${message.trim()}',
              "badge": 1,
              "sound": "default",
              "content-available": 1,
              "apns-priority": 10,
              "apns-topic": AppConst.appId,
              "apns-push-type": "alert",
              "thread-id": AppConst.appId,
              "time_to_live": "2419200"
            }
          },
        ),
      );

      await Alerts.hideAlert();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Push notification sended');

        await Alerts.successAlert(
          context,
          title: 'Successo',
          subtitle: 'Intervento salvato',
        );
      } else {
        await Alerts.hideAlert();
        print('Can\'t send push notification');
      }
    } catch (error) {
      await Alerts.hideAlert();
      print('ERROR_sendToUser: $error');
    }
  }

  Future sendToPalace({
    required BuildContext context,
    required String title,
    required String message,
    required Operation operation,
    required List<Token> tokens,
  }) async {
    try {
      var response = await http.post(
        Uri.parse(AppConst.firebaseBaseurl),
        headers: {
          "Authorization": "key=${AppConst.firebaseAuthKey}",
          "Content-Type": "application/json"
        },
        body: json.encode(
          {
            "registration_ids": tokens.map((e) => e.userToken).toList(),
            "notification": {
              "title": title.trim(),
              "body":
                  'Condominio ${operation.palaceAddress}: ${message.trim()}',
              "badge": 1,
              "sound": "default",
              "content-available": 1,
              "apns-priority": 10,
              "apns-topic": AppConst.appId,
              "apns-push-type": "alert",
              "thread-id": AppConst.appId,
              "time_to_live": "2419200"
            }
          },
        ),
      );

      await Alerts.hideAlert();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Push notification sended');
        await Alerts.successAlert(
          context,
          title: 'Successo',
          subtitle: 'Intervento salvato',
        );
      } else {
        await Alerts.hideAlert();
        print('Can\'t send push notification');
      }
    } catch (error) {
      await Alerts.hideAlert();
      print('ERROR_sendToPalace: $error');
    }
  }
}
