import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/screens/feed/widgets/operation.dart';
import 'package:adminpanel/utils/size.dart';

class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: AppConst.padding),
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
                groupValue: context.watch<OperationProvider>().selectedSegment,
                onValueChanged: (value) {
                  context.read<OperationProvider>().setSelectedSegment(value);
                },
              ),
            ),

            /// FIRST CIRCLE
            Positioned(
              top: 0,
              right: (ScreenSize.width(context) / 3 + AppConst.padding * 2) -
                  AppConst.padding * 1.5,
              child: FutureBuilder<List<Operation>>(
                future:
                    context.read<OperationProvider>().getOperations(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<Operation> feeds = snapshot.data!;
                    if (feeds
                        .where((e) => e.operationOpened == 'false')
                        .toList()
                        .isNotEmpty) {
                      return Container(
                        height: 19,
                        width: 19,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: AppColors.primaryColor),
                          color: context
                                      .read<OperationProvider>()
                                      .selectedSegment !=
                                  2
                              ? AppColors.primaryColor
                              : AppColors.backgroundColor,
                          borderRadius:
                              BorderRadius.circular(AppConst.borderRadius * 2),
                        ),
                        child: Center(
                          child: Text(
                            feeds
                                .where((e) => e.operationOpened == 'false')
                                .toList()
                                .length
                                .toString(),
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
                      );
                    } else {
                      return const SizedBox();
                    }
                  } else if (snapshot.hasError) {
                    return const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),

            /// SECOND CIRCLE
            Positioned(
              top: 0,
              left: ScreenSize.width(context) - AppConst.padding * 2.5,
              child: FutureBuilder<List<Operation>>(
                future:
                    context.read<OperationProvider>().getOperations(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<Operation> operations = snapshot.data!;
                    if (operations
                        .where((e) => e.operationOpened == 'false')
                        .toList()
                        .isNotEmpty) {
                      return Container(
                        height: 19,
                        width: 19,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: AppColors.primaryColor),
                          color: context
                                      .read<OperationProvider>()
                                      .selectedSegment !=
                                  3
                              ? AppColors.primaryColor
                              : AppColors.backgroundColor,
                          borderRadius:
                              BorderRadius.circular(AppConst.borderRadius * 2),
                        ),
                        child: Center(
                          child: Text(
                            operations
                                .where((e) => e.operationOpened == 'false')
                                .toList()
                                .length
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: context
                                          .read<OperationProvider>()
                                          .selectedSegment !=
                                      3
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
                  } else if (snapshot.hasError) {
                    return const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
        const Expanded(
          child: OperationSegmentedPage(),
        ),
      ],
    );
  }
}
