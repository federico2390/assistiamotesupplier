// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AccountingProvider extends ChangeNotifier {
  InAppWebViewController? _inAppWebViewController;
  InAppWebViewController? get inAppWebViewController => _inAppWebViewController;

  void currentController(InAppWebViewController controller) {
    _inAppWebViewController = controller;
    notifyListeners();
  }
}
