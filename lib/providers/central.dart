// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class CentralProvider extends ChangeNotifier {
  bool? _loading = false;
  bool get loading => _loading!;

  void isLoading(bool isLoading) {
    _loading = isLoading;
    notifyListeners();
  }
}
