import 'package:adminpanel/api/operation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/operation.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/utils/loader.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class OperationSegmentedPage extends StatelessWidget {
  const OperationSegmentedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<OperationProvider>(
            builder: (context, operationProvider, child) {
              if (operationProvider.operations.isNotEmpty) {
                List<Operation> operations = operationProvider.operations;
                return ListView.separated(
                  shrinkWrap: true,
                  clipBehavior: Clip.none,
                  padding: const EdgeInsets.fromLTRB(
                    AppConst.padding - 5,
                    AppConst.padding,
                    AppConst.padding - 5,
                    AppConst.padding * 2,
                  ),
                  itemCount: operations.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: AppConst.padding),
                  itemBuilder: (context, index) {
                    Operation operation = operations[index];

                    return TapDebouncer(
                      onTap: () async {
                        await OperationApi()
                            .markOperationAsOpened(operation)
                            .whenComplete(() {
                          Navigator.pushNamed(
                            context,
                            '/operation_detail',
                            arguments: OperationArguments(
                              operation,
                            ),
                          );
                        });
                      },
                      builder: (BuildContext context, TapDebouncerFunc? onTap) {
                        return GestureDetector(
                          onTap: onTap,
                          child: Card(
                            elevation: 7,
                            shadowColor:
                                AppColors.secondaryColor.withOpacity(.15),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppConst.borderRadius),
                            ),
                            color: operation.operationOpened == 'false'
                                ? AppColors.primaryColor
                                : AppColors.backgroundColor,
                            child: ListTile(
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
                              title: Row(
                                children: [
                                  Text(
                                    operation.operation!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          operation.operationOpened == 'false'
                                              ? AppColors.labelLightColor
                                              : AppColors.labelDarkColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    alignment: Alignment.topRight,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppConst.padding / 1.5,
                                      vertical: AppConst.padding / 7,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppConst.padding / 3),
                                      color:
                                          operation.operationOpened == 'false'
                                              ? AppColors.labelLightColor
                                              : AppColors.primaryColor,
                                    ),
                                    child: Text(
                                      operation.operationLastUpdate!.isNotEmpty
                                          ? 'Aggiornato'
                                          : operation.operationState == 'false'
                                              ? 'Aperto'
                                              : 'Chiuso',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color:
                                            operation.operationOpened == 'false'
                                                ? AppColors.primaryColor
                                                : AppColors.backgroundColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              subtitle: Text(
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
          ),
        ),
      ],
    );
  }
}