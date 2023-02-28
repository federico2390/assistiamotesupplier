import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:adminpanel/providers/feed.dart';
import 'package:adminpanel/providers/loader.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/utils/alerts.dart';

BottomNavigationBar bottomBar(BuildContext context) {
  return BottomNavigationBar(
    currentIndex: context.watch<BottomBarProvider>().currentPageIndex,
    selectedItemColor: AppColors.primaryColor,
    type: BottomNavigationBarType.fixed,
    selectedFontSize: 13,
    unselectedFontSize: 13,
    items: [
      BottomNavigationBarItem(
        label: 'Bacheca',
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.dashboard_rounded),
            Positioned(
              bottom: 15,
              left: AppConst.padding * 1.75,
              child: Consumer2<FeedProvider, OperationProvider>(
                builder: (context, feedProvider, operationProvider, child) {
                  if (feedProvider.feeds.isNotEmpty ||
                      operationProvider.operations.isNotEmpty) {
                    if (feedProvider.feeds
                            .where((e) => e.notificationOpened == 'false')
                            .toList()
                            .isNotEmpty ||
                        operationProvider.operations
                            .where((e) => e.operationOpened == 'false')
                            .toList()
                            .isNotEmpty) {
                      return Container(
                        height: 20,
                        width: const BoxConstraints(minWidth: 20).minWidth,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: AppColors.primaryColor),
                          color:
                              context.read<FeedProvider>().selectedSegment != 2
                                  ? AppColors.primaryColor
                                  : AppColors.backgroundColor,
                          borderRadius:
                              BorderRadius.circular(AppConst.borderRadius * 2),
                        ),
                        child: Center(
                          child: Text(
                            ((feedProvider.feeds
                                            .where((e) =>
                                                e.notificationOpened == 'false')
                                            .toList()
                                            .length +
                                        operationProvider.operations
                                            .where((e) =>
                                                e.operationOpened == 'false')
                                            .toList()
                                            .length) >
                                    9)
                                ? '9+'
                                : (feedProvider.feeds
                                            .where((e) =>
                                                e.notificationOpened == 'false')
                                            .toList()
                                            .length +
                                        operationProvider.operations
                                            .where((e) =>
                                                e.operationOpened == 'false')
                                            .toList()
                                            .length)
                                    .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: context
                                          .read<FeedProvider>()
                                          .selectedSegment !=
                                      2
                                  ? AppColors.backgroundColor
                                  : AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
        tooltip: '',
      ),
      const BottomNavigationBarItem(
        label: 'Interventi',
        icon: Icon(Icons.build_rounded),
        tooltip: '',
      ),
      const BottomNavigationBarItem(
        label: 'Letture',
        icon: Icon(Icons.water_drop_rounded),
        tooltip: '',
      ),
      const BottomNavigationBarItem(
        label: 'Contabilità',
        icon: Icon(Icons.assignment_rounded),
        tooltip: '',
      ),
      const BottomNavigationBarItem(
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
