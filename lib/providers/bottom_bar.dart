import 'package:flutter/foundation.dart';

class BottomBarProvider extends ChangeNotifier {
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  void currentPage(int pageIndex) {
    _currentPageIndex = pageIndex;
    notifyListeners();
  }
}
