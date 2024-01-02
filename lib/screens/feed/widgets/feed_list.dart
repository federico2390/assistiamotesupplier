import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/state.dart';
import 'package:adminpanel/screens/feed/widgets/operation.dart';
import 'package:adminpanel/utils/loader.dart';
import 'package:adminpanel/utils/size.dart';

class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OperationProvider>(
      builder: (context, operationProvider, child) {
        return Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 48,
                  width: ScreenSize.width(context),
                  child: CupertinoSegmentedControl(
                    selectedColor: AppColors.primaryColor,
                    unselectedColor: AppColors.backgroundColor,
                    borderColor: AppColors.primaryColor,
                    pressedColor: AppColors.tertiaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConst.padding),
                    children: const {
                      1: Text(
                        'Da accettare',
                        style: TextStyle(fontSize: 12),
                      ),
                      2: Text(
                        'Accettate',
                        style: TextStyle(fontSize: 12),
                      ),
                      3: Text(
                        'Chiuse',
                        style: TextStyle(fontSize: 12),
                      ),
                    },
                    groupValue:
                        context.watch<OperationProvider>().selectedSegment,
                    onValueChanged: (value) {
                      context
                          .read<OperationProvider>()
                          .setSelectedSegment(value);
                    },
                  ),
                ),

                /// FIRST CIRCLE
                Positioned(
                  top: 0,
                  left: ScreenSize.width(context) / 3 - AppConst.padding,
                  child: Container(
                    height: 19,
                    width: 19,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: AppColors.primaryColor),
                      color:
                          context.read<OperationProvider>().selectedSegment != 1
                              ? AppColors.primaryColor
                              : AppColors.backgroundColor,
                      borderRadius:
                          BorderRadius.circular(AppConst.borderRadius * 2),
                    ),
                    child: Center(
                      child: Text(
                        operationProvider.idle.length.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context
                                      .read<OperationProvider>()
                                      .selectedSegment !=
                                  1
                              ? AppColors.backgroundColor
                              : AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),

                /// SECOND CIRCLE
                Positioned(
                  top: 0,
                  left: (ScreenSize.width(context) / 2) +
                      (ScreenSize.width(context) / 6) -
                      AppConst.padding * 1.7,
                  child: Container(
                    height: 19,
                    width: 19,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: AppColors.primaryColor),
                      color:
                          context.read<OperationProvider>().selectedSegment != 2
                              ? AppColors.primaryColor
                              : AppColors.backgroundColor,
                      borderRadius:
                          BorderRadius.circular(AppConst.borderRadius * 2),
                    ),
                    child: Center(
                      child: Text(
                        operationProvider.accept.length.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context
                                      .read<OperationProvider>()
                                      .selectedSegment !=
                                  2
                              ? AppColors.backgroundColor
                              : AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () =>
                    context.read<StateProvider>().buildFuture(context),
                child: operationProvider.selectedSegment == 1
                    ? operationProvider.idle.isNotEmpty
                        ? const OperationSegmentedPage()
                        : const Loader()
                    : operationProvider.selectedSegment == 2
                        ? operationProvider.accept.isNotEmpty
                            ? const OperationSegmentedPage()
                            : const Loader()
                        : operationProvider.closed.isNotEmpty
                            ? const OperationSegmentedPage()
                            : const Loader(),
              ),
            ),
          ],
        );
      },
    );
  }
}
