import 'package:adminpanel/screens/error/error.dart';
import 'package:flutter/material.dart';

import 'package:adminpanel/central.dart';
import 'package:adminpanel/screens/feed/feed_page.dart';
import 'package:adminpanel/screens/feed/widgets/operation_detail.dart';
import 'package:adminpanel/screens/gallery/gallery_page.dart';
import 'package:adminpanel/screens/login/login_page.dart';
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
      '/gallery': (context) => const GalleryPage(),
      '/setting': (context) => const SettingPage(),
      '/error': (context) => const ErrorPage(),
    };
  }
}
