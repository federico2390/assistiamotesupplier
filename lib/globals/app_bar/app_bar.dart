import 'package:adminpanel/api/user.dart';
import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/models/feed.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/feed.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/providers/bottom_bar.dart';
import 'package:adminpanel/screens/accounting/widgets/top_bar.dart';

appBar(BuildContext context) {
  return context.read<BottomBarProvider>().currentPageIndex == 3
      ? PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: topBar(context),
        )
      : UserApi().isLogged == true
          ? AppBar(
              leading: context.read<BottomBarProvider>().currentPageIndex != 3
                  ? Ink(
                      child: InkWell(
                        child: const Icon(Icons.settings_rounded),
                        onTap: () {
                          Navigator.pushNamed(context, '/setting');
                        },
                      ),
                    )
                  : const SizedBox(),
              title: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return FutureBuilder(
                    future: userProvider.getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data!.palaceAddress!.isNotEmpty) {
                        UserDatabase user = snapshot.data!;
                        return // palaceDropdownButton(context, user);
                            Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.apartment_rounded, size: 20),
                            const SizedBox(width: AppConst.padding / 2),
                            Text(
                              user.palaceAddress!,
                              style: TextStyle(
                                color: AppColors.labelDarkColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                },
              ),
              actions: [
                context.read<BottomBarProvider>().currentPageIndex != 3
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppConst.padding),
                        child: Ink(
                          child: InkWell(
                            child: Icon(
                              Icons.settings_rounded,
                              color: AppColors.backgroundColor,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
              bottom: context.read<BottomBarProvider>().currentPageIndex == 0
                  ? PreferredSize(
                      preferredSize: const Size(double.infinity, 48),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                            height: 48,
                            width: ScreenSize.width(context),
                            child: CupertinoSegmentedControl(
                              selectedColor: AppColors.primaryColor,
                              borderColor: AppColors.primaryColor,
                              pressedColor: AppColors.tertiaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppConst.padding),
                              children: const {
                                1: Text(
                                  'Tutti',
                                  style: TextStyle(fontSize: 12),
                                ),
                                2: Text(
                                  'Comunicazioni',
                                  style: TextStyle(fontSize: 12),
                                ),
                                3: Text(
                                  'Interventi',
                                  style: TextStyle(fontSize: 12),
                                ),
                              },
                              groupValue:
                                  context.watch<FeedProvider>().selectedSegment,
                              onValueChanged: (value) {
                                context
                                    .read<FeedProvider>()
                                    .setSelectedSegment(value);
                              },
                            ),
                          ),

                          /// FIRST CIRCLE
                          Positioned(
                            top: -5,
                            right: ScreenSize.width(context) / 3 +
                                ScreenSize.width(context) / 9 -
                                AppConst.padding * 2,
                            child: Consumer<FeedProvider>(
                              builder: (context, feedProvider, child) {
                                return FutureBuilder(
                                  future: feedProvider.getFeeds(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        feedProvider.feeds.isNotEmpty) {
                                      List<Feed> feeds = feedProvider.feeds;
                                      if (feeds
                                          .where((e) =>
                                              e.notificationOpened == 'false')
                                          .toList()
                                          .isNotEmpty) {
                                        return Container(
                                          height: 23,
                                          width: 23,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: AppColors.primaryColor),
                                            color: context
                                                        .read<FeedProvider>()
                                                        .selectedSegment !=
                                                    2
                                                ? AppColors.primaryColor
                                                : AppColors.backgroundColor,
                                            borderRadius: BorderRadius.circular(
                                                AppConst.borderRadius * 2),
                                          ),
                                          child: Center(
                                            child: Text(
                                              feeds
                                                  .where((e) =>
                                                      e.notificationOpened ==
                                                      'false')
                                                  .toList()
                                                  .length
                                                  .toString(),
                                              style: TextStyle(
                                                color: context
                                                            .read<
                                                                FeedProvider>()
                                                            .selectedSegment !=
                                                        2
                                                    ? AppColors.backgroundColor
                                                    : AppColors.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
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
                                );
                              },
                            ),
                          ),

                          /// SECOND CIRCLE
                          Positioned(
                            top: -5,
                            right: ScreenSize.width(context) / 3 -
                                ScreenSize.width(context) / 3 +
                                AppConst.padding * 1.5,
                            child: Consumer<OperationProvider>(
                              builder: (context, operationProvider, child) {
                                return FutureBuilder(
                                  future: operationProvider.getOperations(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data!.isNotEmpty) {
                                      List<Operation> operations =
                                          operationProvider.operations;
                                      if (operations
                                          .where((e) =>
                                              e.operationOpened == 'false')
                                          .toList()
                                          .isNotEmpty) {
                                        return Container(
                                          height: 23,
                                          width: 23,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: AppColors.primaryColor),
                                            color: context
                                                        .read<FeedProvider>()
                                                        .selectedSegment !=
                                                    3
                                                ? AppColors.primaryColor
                                                : AppColors.backgroundColor,
                                            borderRadius: BorderRadius.circular(
                                                AppConst.borderRadius * 2),
                                          ),
                                          child: Center(
                                            child: Text(
                                              operations
                                                  .where((e) =>
                                                      e.operationOpened ==
                                                      'false')
                                                  .toList()
                                                  .length
                                                  .toString(),
                                              style: TextStyle(
                                                color: context
                                                            .read<
                                                                FeedProvider>()
                                                            .selectedSegment !=
                                                        3
                                                    ? AppColors.backgroundColor
                                                    : AppColors.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
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
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : null,
            )
          : const PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: SizedBox(),
            );
}
