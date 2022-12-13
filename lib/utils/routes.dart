import 'package:adminpanel/central.dart';
import 'package:adminpanel/screens/accounting/accounting_page.dart';
import 'package:adminpanel/screens/feed/feed_page.dart';
import 'package:adminpanel/screens/login/login_page.dart';
import 'package:adminpanel/screens/operation/operation_page.dart';
import 'package:adminpanel/screens/reading/reading_page.dart';
import 'package:adminpanel/screens/gallery/gallery_page.dart';
import 'package:adminpanel/screens/setting/setting_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> buildRoutes() {
    return {
      '/': (context) => const Central(),
      '/login': (context) => const LoginPage(),
      '/operation': (context) => const OperationPage(),
      '/feed': (context) => const FeedPage(),
      '/reading': (context) => const ReadingPage(),
      '/accounting': (context) => const AccountingPage(),
      '/gallery': (context) => const GalleryPage(),
      '/setting': (context) => const SettingPage(),
    };
  }
}
