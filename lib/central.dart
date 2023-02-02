import 'package:adminpanel/api/user.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:adminpanel/screens/accounting/accounting_page.dart';
import 'package:adminpanel/screens/feed/feed_page.dart';
import 'package:adminpanel/screens/operation/operation_page.dart';
import 'package:adminpanel/screens/reading/reading_page.dart';
import 'package:adminpanel/globals/app_bar.dart';
import 'package:adminpanel/globals/bottom_bar.dart';
import 'package:adminpanel/utils/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adminpanel/api/setting.dart';

class Central extends StatefulWidget {
  const Central({super.key});

  @override
  State<Central> createState() => _CentralState();
}

class _CentralState extends State<Central> with TickerProviderStateMixin {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    initializeNotifications();
    super.initState();
  }

  Future<void> initializeNotifications() async {
    NotificationService.initialize();

    if (UserApi().isLogged == true) {
      firebaseMessaging.getToken().then((token) async {
        if (token != null) {
          await SettingApi.token(context, token);

          /// Subscribe to topic for receiving push notification if admin send it to all his users
          await firebaseMessaging.subscribeToTopic(AppConst.firebaseTopic);
        }
      });
    }

    /// The app is killed
    firebaseMessaging.getInitialMessage();

    /// The app is open
    FirebaseMessaging.onMessage.listen((message) async {
      print('The app is open');
      NotificationService.display(message);
    });

    /// The notification is clicked
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print('The notification is clicked');

      /// THIS CAUSE DOUBLE NOTIFICATION DISPLAYED
      // if (!mounted) return;
      // NotificationService.display(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    body() {
      return context.read<BottomBarProvider>().currentPageIndex == 0
          ? const FeedPage()
          : context.read<BottomBarProvider>().currentPageIndex == 1
              ? const OperationPage()
              : context.read<BottomBarProvider>().currentPageIndex == 2
                  ? const ReadingPage()
                  : const AccountingPage();
    }

    return Scaffold(
      appBar: appBar(context),
      body: body(),
      bottomNavigationBar: bottomBar(context),
    );
  }
}
