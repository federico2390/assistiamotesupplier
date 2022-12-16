import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/accounting.dart';
import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

BottomNavigationBar bottomBar(BuildContext context) {
  return BottomNavigationBar(
    currentIndex: context.watch<BottomBarProvider>().currentPageIndex,
    selectedItemColor: AppColors.primaryColor,
    type: BottomNavigationBarType.fixed,
    selectedFontSize: 13,
    unselectedFontSize: 13,
    items: const [
      BottomNavigationBarItem(
        label: 'Fatture',
        icon: Icon(Icons.engineering_rounded),
        tooltip: '',
      ),
      BottomNavigationBarItem(
        label: 'Consuntivo',
        icon: Icon(Icons.list_rounded),
        tooltip: '',
      ),
      BottomNavigationBarItem(
        label: 'Rate Personali',
        icon: Icon(Icons.search_rounded),
        tooltip: '',
      ),
      BottomNavigationBarItem(
        label: 'Rate Inquilini',
        icon: Icon(Icons.payments_rounded),
        tooltip: '',
      ),
    ],
    onTap: (index) {
      switch (index) {
        case 0:
          context
              .read<AccountingProvider>()
              .currentPage(AppConst.accountingItems.keys.first);
          break;
        case 1:
          context.read<AccountingProvider>().currentPage('index');

          break;
        case 2:
          context.read<AccountingProvider>().currentPage('index');

          break;
        case 3:
          context.read<AccountingProvider>().currentPage('index');

          break;
      }
    },
  );
}
