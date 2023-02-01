import 'package:flutter/material.dart';

class GalleryProvider extends ChangeNotifier {
  int _mediaIndex = 0;
  int get mediaIndex => _mediaIndex;

  void currentMediaIndex(int currentMediaIndex) {
    _mediaIndex = currentMediaIndex;
    notifyListeners();
  }
}
