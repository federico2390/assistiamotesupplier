import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/utils/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/screens/feed/widgets/operation.dart';
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
                        'Aperti',
                        style: TextStyle(fontSize: 12),
                      ),
                      2: Text(
                        'In corso',
                        style: TextStyle(fontSize: 12),
                      ),
                      3: Text(
                        'Chiusi',
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
                        operationProvider.opened.length.toString(),
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
                  right:
                      (ScreenSize.width(context) / 3 + AppConst.padding * 2) -
                          AppConst.padding * 1.5,
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
                        operationProvider.working.length.toString(),
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
            StreamBuilder(
              stream: operationProvider.getOperations(context).asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: operationProvider.selectedSegment == 1
                        ? operationProvider.opened.isNotEmpty
                            ? const OperationSegmentedPage()
                            : const Loader()
                        : operationProvider.selectedSegment == 2
                            ? operationProvider.working.isNotEmpty
                                ? const OperationSegmentedPage()
                                : const Loader()
                            : operationProvider.closed.isNotEmpty
                                ? const OperationSegmentedPage()
                                : const Loader(),
                  );
                } else {
                  return const Loader();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
