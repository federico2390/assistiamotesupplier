import 'package:flutter/material.dart';

class BottomBarProvider extends ChangeNotifier {
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  void currentPage(int pageIndex) {
    _currentPageIndex = pageIndex;
    notifyListeners();
  }
}
