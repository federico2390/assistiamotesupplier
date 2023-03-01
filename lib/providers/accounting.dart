import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AccountingProvider extends ChangeNotifier {
  int? selected;

  InAppWebViewController? _inAppWebViewController;
  InAppWebViewController? get inAppWebViewController => _inAppWebViewController;

  void currentController(InAppWebViewController controller) {
    _inAppWebViewController = controller;
    notifyListeners();
  }

  void selectedPage(int selectedPage) {
    selected = selectedPage;
    notifyListeners();
  }
}
