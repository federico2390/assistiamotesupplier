import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:adminpanel/providers/central.dart';
import 'package:adminpanel/utils/alerts.dart';
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
        label: 'Interventi',
        icon: Icon(Icons.build_rounded),
        tooltip: '',
      ),
      BottomNavigationBarItem(
        label: 'Bacheca',
        icon: Icon(Icons.dashboard_rounded),
        tooltip: '',
      ),
      BottomNavigationBarItem(
        label: 'Letture',
        icon: Icon(Icons.event_note_rounded),
        tooltip: '',
      ),
      BottomNavigationBarItem(
        label: 'Contabilità',
        icon: Icon(Icons.assignment_rounded),
        tooltip: '',
      ),
    ],
    onTap: (index) {
      if (Alerts.isVisible == true) {
        context.read<CentralProvider>().isLoading(false);
        Alerts.hide;
      }
      context.read<BottomBarProvider>().currentPage(index);
    },
  );
}
