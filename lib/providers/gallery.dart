import 'package:flutter/material.dart';

class GalleryProvider extends ChangeNotifier {
  int _userMediaIndex = 0;
  int get userMediaIndex => _userMediaIndex;

  void userCurrentMediaIndex(int currentMediaIndex) {
    _userMediaIndex = currentMediaIndex;
    notifyListeners();
  }

  int _supplierMediaIndex = 0;
  int get supplierMediaIndex => _supplierMediaIndex;

  void supplierCurrentMediaIndex(int currentMediaIndex) {
    _supplierMediaIndex = currentMediaIndex;
    notifyListeners();
  }
}
