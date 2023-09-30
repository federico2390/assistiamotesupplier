import 'package:flutter/material.dart';

import 'package:adminpanel/central.dart';
import 'package:adminpanel/screens/feed/feed_page.dart';
import 'package:adminpanel/screens/feed/widgets/operation_detail.dart';
import 'package:adminpanel/screens/feed/widgets/visit_detail.dart';
import 'package:adminpanel/screens/login/login_page.dart';
import 'package:adminpanel/screens/notification/notification_page.dart';
import 'package:adminpanel/screens/setting/setting_page.dart';
import 'package:adminpanel/screens/welcome/welcome_page.dart';

class Routes {
  static Map<String, WidgetBuilder> buildRoutes() {
    return {
      '/': (context) => const Central(),
      '/login': (context) => const LoginPage(),
      '/welcome': (context) => const Welcome(),
      '/feed': (context) => const FeedPage(),
      '/operation_detail': (context) => const OperationDetail(),
      '/setting': (context) => const SettingPage(),
      '/visit': (context) => const VisitDetail(),
      '/notification': (context) => const NotificationPage(),
    };
  }
}
