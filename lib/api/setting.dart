import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/setting.dart';
import 'package:adminpanel/providers/user.dart';

class SettingApi {
  Future<Setting> getNotificationSetting(BuildContext context) async {
    Setting setting = Setting();

    try {
      final user = await context.read<UserProvider>().getLocalUser();

      var response = await AppConst().client.post(
        kIsWeb
            ? Uri.parse(AppConst.setting).replace(host: AppConst.domain)
            : Uri.parse(AppConst.setting),
        body: {
          "get_notification": "get_notification",
          "supplier_id": user.supplierId,
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
    } finally {
      AppConst().client.close();
    }
    return setting;
  }

  Future editNotificationSetting(
    BuildContext context,
    bool? notification,
  ) async {
    try {
      final user = await context.read<UserProvider>().getLocalUser();

      await AppConst().client.post(
        kIsWeb
            ? Uri.parse(AppConst.setting).replace(host: AppConst.domain)
            : Uri.parse(AppConst.setting),
        body: {
          "edit_notification": "edit_notification",
          "supplier_id": user.supplierId,
          "supplier_notification_permission": notification.toString(),
        },
      );
    } catch (error) {
      print('ERROR_editNotification: $error');
    } finally {
      AppConst().client.close();
    }
  }

  Future saveToken(BuildContext context, String token) async {
    try {
      final user = await context.read<UserProvider>().getLocalUser();

      await AppConst().client.post(
        kIsWeb
            ? Uri.parse(AppConst.setting).replace(host: AppConst.domain)
            : Uri.parse(AppConst.setting),
        body: {
          "save_token": "save_token",
          "supplier_id": user.supplierId,
          "supplier_device_token": token,
        },
      );
    } catch (error) {
      print('ERROR_saveToken: $error');
    } finally {
      AppConst().client.close();
    }
  }
}
