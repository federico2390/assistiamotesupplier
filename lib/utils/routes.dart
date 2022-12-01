import 'package:adminpanel/central.dart';
import 'package:adminpanel/screens/feed.dart';
import 'package:adminpanel/screens/login.dart';
import 'package:adminpanel/screens/operation.dart';
import 'package:adminpanel/screens/reading.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> buildRoutes() {
    return {
      '/': (context) => const Central(),
      '/operation': (context) => const Operation(),
      '/feed': (context) => const Feed(),
      '/reading': (context) => const Reading(),
      '/login': (context) => const Login(),
    };
  }
}
