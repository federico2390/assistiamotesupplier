import 'package:flutter/material.dart';

class LoaderProvider extends ChangeNotifier {
  bool _showLabel = false;
  bool get showLabel => _showLabel;
  void setShowLabel(bool show) {
    _showLabel = show;
    notifyListeners();
  }

  bool _settingShowLabel = false;
  bool get settingShowLabel => _settingShowLabel;
  void settingSetShowLabel(bool show) {
    _settingShowLabel = show;
    notifyListeners();
  }

  bool _isSaving = false;
  bool get isSaving => _isSaving;
  void setIsSaving(bool saving) {
    _isSaving = saving;
    notifyListeners();
  }
}
