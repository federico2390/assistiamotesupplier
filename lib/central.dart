import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/api/setting.dart';
import 'package:adminpanel/globals/app_bar.dart';
import 'package:adminpanel/globals/body.dart';
import 'package:adminpanel/providers/setting.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/notification_manager.dart';

class Central extends StatefulWidget {
  const Central({super.key});

  @override
  State<Central> createState() => _CentralState();
}

class _CentralState extends State<Central> with WidgetsBindingObserver {
  @override
  void initState() {
    NotificationManager.requestPermisison(context);
    NotificationManager.getToken(context);
    NotificationManager.initInfo();
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    context.read<UserProvider>().getUser();
    // context.read<UserProvider>().getLocalUser();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkNotificationPermission(context);
    }
  }

  checkNotificationPermission(BuildContext context) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted OS permission');
      await SettingApi().editNotificationSetting(context, true);
      context.read<SettingProvider>().setNotificationStatus(true);
    } else {
      print('User has not granted OS permission');
      await SettingApi().editNotificationSetting(context, false);
      context.read<SettingProvider>().setNotificationStatus(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(context),
      // bottomNavigationBar: bottomBar(context),
    );
  }
}
