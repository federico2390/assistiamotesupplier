import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/setting.dart';
import 'package:adminpanel/providers/user.dart';

class SettingApi {
  Future<Setting> getSettings() async {
    Setting setting = Setting();

    try {
      var response = await AppConst().client.post(
        kIsWeb
            ? Uri.parse(AppConst.setting).replace(host: AppConst.domain)
            : Uri.parse(AppConst.setting),
        body: {
          'get_settings': 'get_settings',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        setting = Setting.fromJson(json.decode(response.body)[0]);
      } else {
        debugPrint('Can\'t get Settings');
      }
    } catch (error) {
      debugPrint('ERROR_getSettings: $error');
    } finally {
      AppConst().client.close();
    }
    return setting;
  }

  Future<NotificationSetting> getNotificationSetting(
      BuildContext context) async {
    NotificationSetting setting = NotificationSetting();

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
        setting = NotificationSetting.fromJson(jsonData[0]);
      } else {
        debugPrint('Can\'t get Setting');
      }
    } catch (error) {
      debugPrint('ERROR_getNotification: $error');
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
      debugPrint('ERROR_editNotification: $error');
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
      debugPrint('ERROR_saveToken: $error');
    } finally {
      AppConst().client.close();
    }
  }
}
