import 'package:adminpanel/utils/accounting_action_sheet.dart';
import 'package:flutter/material.dart';

class BottomBarProvider extends ChangeNotifier {
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  void currentPage(BuildContext context, int pageIndex) {
    if (pageIndex == 3) {
      buildAccountingActionSheet(context);
      return;
    }

    _currentPageIndex = pageIndex;
    notifyListeners();
  }
}
