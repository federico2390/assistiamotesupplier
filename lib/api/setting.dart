import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SettingApi {
  static Future notificationSwitch(
      BuildContext context, bool? notification) async {
    final user = await context.read<UserProvider>().getUser();

    await http.post(
      Uri.parse(AppConst.setting),
      body: {
        "notification_switch": "notification_switch",
        "user_id": user.userId,
        "notification": notification.toString(),
      },
    );
  }

  static Future token(BuildContext context, String token) async {
    final user = await context.read<UserProvider>().getUser();

    await http.post(
      Uri.parse(AppConst.setting),
      body: {
        "save_token": "save_token",
        "user_id": user.userId,
        "user_token": token,
      },
    );
  }
}
