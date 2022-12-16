import 'package:flutter/material.dart';

class AccountingProvider extends ChangeNotifier {
  String _url = '';
  String get url => _url;

  void currentPage(String selectedUrl) {
    _url = selectedUrl;
    notifyListeners();
  }
}
 