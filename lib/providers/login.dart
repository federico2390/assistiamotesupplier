import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool hiddenPassword = true;

  void hidePassword() {
    hiddenPassword = !hiddenPassword;
    notifyListeners();
  }
}
