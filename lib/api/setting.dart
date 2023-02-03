import 'dart:convert';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/setting.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SettingApi {
  Future<Setting> getNotificationSetting(BuildContext context) async {
    Setting setting = Setting();

    try {
      final user = await context.read<UserProvider>().getUser();

      var response = await http.post(
        Uri.parse(AppConst.setting),
        body: {
          "get_notification": "get_notification",
          "user_id": user.userId,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        setting = Setting.fromJson(jsonData[0]);
      } else {
        print('Can\'t get Setting');
      }
    } catch (error) {
      print('ERROR_getNotification: $error');
    }
    return setting;
  }

  Future editNotificationSetting(
      BuildContext context, bool? notification) async {
    try {
      final user = await context.read<UserProvider>().getUser();

      if (notification == true) {
        FirebaseMessaging.instance.subscribeToTopic(AppConst.firebaseTopic);
      } else {
        FirebaseMessaging.instance.unsubscribeFromTopic(AppConst.firebaseTopic);
      }

      await http.post(
        Uri.parse(AppConst.setting),
        body: {
          "edit_notification": "edit_notification",
          "user_id": user.userId,
          "notification": notification.toString(),
        },
      );
    } catch (error) {
      print('ERROR_editNotification: $error');
    }
  }

  Future saveToken(BuildContext context, String token) async {
    try {
      final user = await context.read<UserProvider>().getUser();

      await http.post(
        Uri.parse(AppConst.setting),
        body: {
          "save_token": "save_token",
          "user_id": user.userId,
          "user_token": token,
        },
      );
    } catch (error) {
      print('ERROR_saveToken: $error');
    }
  }
}
