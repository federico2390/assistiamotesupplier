import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:adminpanel/providers/loader.dart';
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
        label: 'Bacheca',
        icon: Icon(Icons.dashboard_rounded),
        tooltip: '',
      ),
      BottomNavigationBarItem(
        label: 'Interventi',
        icon: Icon(Icons.build_rounded),
        tooltip: '',
      ),
      BottomNavigationBarItem(
        label: 'Letture',
        icon: Icon(Icons.water_drop_rounded),
        tooltip: '',
      ),
      BottomNavigationBarItem(
        label: 'Contabilità',
        icon: Icon(Icons.assignment_rounded),
        tooltip: '',
      ),
      BottomNavigationBarItem(
        label: 'Info',
        icon: Icon(Icons.info_rounded),
        tooltip: '',
      ),
    ],
    onTap: (index) async {
      await Alerts.hideAlert();
      context.read<BottomBarProvider>().currentPage(index);
      context.read<LoaderProvider>().setShowLabel(false);
    },
  );
}
