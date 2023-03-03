import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/api/setting.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/setting.dart';

class NotificationManager {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static Future requestPermisison(BuildContext context) async {
    NotificationSettings settings = await firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted permission');
      await SettingApi()
          .editNotificationSetting(context, true, isChangeScreen: false);
      context.read<SettingProvider>().setNotificationStatus(true);
    } else {
      print('User declined or hat not accepted permission');
      await SettingApi()
          .editNotificationSetting(context, false, isChangeScreen: false);
      context.read<SettingProvider>().setNotificationStatus(false);
    }
  }

  static void getToken(BuildContext context, {bool? isChangeScreen}) async {
    await firebaseMessaging.getToken().then((token) async {
      await SettingApi()
          .saveToken(context, token!, isChangeScreen: isChangeScreen);
      await firebaseMessaging.getInitialMessage();
    });
  }

  static void initInfo() {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    const androidInitialize =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const iOSInitialize = DarwinInitializationSettings();
    const initializeSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    FlutterLocalNotificationsPlugin().initialize(initializeSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );

      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        AppConst.firebaseChannelId,
        AppConst.firebaseChannelName,
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );

      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      try {
        await FlutterLocalNotificationsPlugin().show(
          id,
          message.notification!.title,
          message.notification!.body,
          platformChannelSpecifics,
          // payload: message.data['title'],
        );
      } catch (error) {
        print('ERROR_initInfo: $error');
      }
    });
  }
}
