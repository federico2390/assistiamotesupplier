import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

BottomNavigationBar bottomnBar(BuildContext context) {
  return BottomNavigationBar(
    currentIndex: context.watch<BottomBarProvider>().currentPageIndex,
    selectedItemColor: AppColors.primaryColor,
    selectedFontSize: 13,
    unselectedFontSize: 13,
    items: const [
      BottomNavigationBarItem(
        label: 'Interventi',
        icon: Icon(Icons.engineering_rounded),
        tooltip: '',
      ),
      BottomNavigationBarItem(
        label: 'Bacheca',
        icon: Icon(Icons.list_rounded),
        tooltip: '',
      ),
      BottomNavigationBarItem(
        label: 'Letture',
        icon: Icon(Icons.search_rounded),
        tooltip: '',
      ),
    ],
    onTap: (index) {
      context.read<BottomBarProvider>().currentPage(index);
    },
  );
}
