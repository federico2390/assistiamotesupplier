import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import 'package:adminpanel/api/operation.dart';
import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/utils/loader.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';

class OperationSegmentedPage extends StatelessWidget {
  const OperationSegmentedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OperationProvider>(
      builder: (context, operationProvider, child) {
        if (operationProvider.operations.isNotEmpty) {
          List<Operation> operations = operationProvider.selectedSegment == 1
              ? operationProvider.opened
              : operationProvider.selectedSegment == 2
                  ? operationProvider.working
                  : operationProvider.closed;

          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(
              AppConst.padding - 5,
              AppConst.padding,
              AppConst.padding - 5,
              AppConst.padding * 2,
            ),
            itemCount: operations.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: AppConst.padding / 2),
            itemBuilder: (context, index) {
              Operation operation = operations[index];

              String labelState = '';
              if (operation.operationLastUpdate!.isNotEmpty) {
                if (operation.operationState == 'false') {
                  labelState = 'Aggiornato';
                } else {
                  labelState = 'Chiuso';
                }
                if (operation.operationViewed == 'true' &&
                    operation.operationWorking == 'true' &&
                    operation.operationState == 'false') {
                  labelState = 'In corso';
                }
              } else if (operation.operationLastUpdate!.isEmpty) {
                if (operation.operationState == 'false') {
                  labelState = 'Aperto';
                } else {
                  labelState = 'Chiuso';
                }
                if (operation.operationViewed == 'true' &&
                    operation.operationWorking == 'true' &&
                    operation.operationState == 'false') {
                  labelState = 'In corso';
                }
              }

              return TapDebouncer(
                onTap: () async {
                  await OperationApi()
                      .markOperationAsOpened(context, operation)
                      .whenComplete(() {
                    Navigator.pushNamed(
                      context,
                      '/operation_detail',
                      arguments: OperationArguments(
                        operation.operationId!,
                      ),
                    );
                  });
                },
                builder: (BuildContext context, TapDebouncerFunc? onTap) {
                  return Card(
                    elevation: 7,
                    shadowColor: AppColors.secondaryColor.withOpacity(.15),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConst.borderRadius),
                    ),
                    color: operation.operationOpened == 'false'
                        ? AppColors.primaryColor
                        : AppColors.backgroundColor,
                    child: ListTile(
                      isThreeLine: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppConst.padding, vertical: 0),
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.build_rounded,
                            color: operation.operationOpened == 'false'
                                ? AppColors.labelLightColor
                                : AppColors.primaryColor,
                          ),
                        ],
                      ),
                      minLeadingWidth: 0,
                      title: Text(
                        operation.palaceAddress!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: operation.operationOpened == 'false'
                              ? AppColors.labelLightColor
                              : AppColors.labelDarkColor,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppConst.padding / 4),
                          Text(
                            operation.operation!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: operation.operationOpened == 'false'
                                  ? AppColors.labelLightColor
                                  : AppColors.secondaryColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: AppConst.padding / 4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  operation.description!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: operation.operationOpened == 'false'
                                        ? AppColors.labelLightColor
                                        : AppColors.secondaryColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              const SizedBox(width: AppConst.padding),
                              Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppConst.padding / 1.5,
                                  vertical: AppConst.padding / 7,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppConst.padding / 3),
                                  color: operation.operationOpened == 'false'
                                      ? AppColors.labelLightColor
                                      : AppColors.primaryColor,
                                ),
                                child: Text(
                                  labelState,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: operation.operationOpened == 'false'
                                        ? AppColors.primaryColor
                                        : AppColors.backgroundColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: onTap,
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const Loader();
        }
      },
    );
  }
}
