import 'package:adminpanel/central.dart';
import 'package:adminpanel/screens/accounting.dart';
import 'package:adminpanel/screens/feed/feed.dart';
import 'package:adminpanel/screens/login/login.dart';
import 'package:adminpanel/screens/operation/operation.dart';
import 'package:adminpanel/screens/reading/reading.dart';
import 'package:adminpanel/screens/gallery/gallery.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> buildRoutes() {
    return {
      '/': (context) => const Central(),
      '/login': (context) => const Login(),
      '/operation': (context) => const Operation(),
      '/feed': (context) => const Feed(),
      '/reading': (context) => const Reading(),
      '/accounting': (context) => const Accounting(),
      '/viewer': (context) => const Gallery(),
    };
  }
}
