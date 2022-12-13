import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Notification {
  Future notification(BuildContext context, bool notification) async {
    final user = await context.read<UserProvider>().getUser();

    await http.post(
      Uri.parse(AppConst.notification),
      body: {
        "user_id": user.userId,
        "notification": notification.toString(),
      },
    );
  }

  Future token(BuildContext context, String token) async {
    final user = await context.read<UserProvider>().getUser();

    await http.post(
      Uri.parse(AppConst.notification),
      body: {
        "user_id": user.userId,
        "user_token": token,
      },
    );
  }
}
