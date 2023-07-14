import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/notifications.dart';
import 'package:adminpanel/providers/user.dart';

class NotificationApi {
  Future<List<Notifications>> getNotifications(BuildContext context) async {
    List<Notifications> notification = [];

    try {
      final user = await context.read<UserProvider>().getLocalUser();

      var response = await AppConst().client.post(
        Uri.parse(AppConst.notification).replace(host: AppConst.domain),
        body: {
          'get_notifications': 'get_notifications',
          'supplier_id': user.supplierId!.trim()
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        notification = notificationsFromJson(response.body);
      } else {
        print('Can\'t get Notifications');
      }
    } catch (error) {
      print('ERROR_getNotifications: $error');
    } finally {
      AppConst().client.close();
    }
    return notification;
  }
}
