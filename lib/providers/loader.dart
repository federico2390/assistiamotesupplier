import 'package:flutter/material.dart';

class LoaderProvider extends ChangeNotifier {
  bool _showLabel = false;
  bool get showLabel => _showLabel;

  void setShowLabel(bool show) {
    _showLabel = show;
    notifyListeners();
  }
}
