import 'package:adminpanel/utils/shared_preference.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool hiddenPassword = true;

  void hidePassword() {
    hiddenPassword = !hiddenPassword;
    notifyListeners();
  }

  bool rememberData = false;

  void loadRememberData() {
    var remember = SharedPrefs.getInt('rememberData');
    rememberData = remember == 0 || remember == null ? false : true;
    notifyListeners();
  }

  void rememberMyData() {
    rememberData = !rememberData;
    var remember = rememberData == true ? 1 : 0;
    SharedPrefs.setInt('rememberData', remember);
    notifyListeners();
  }
}
