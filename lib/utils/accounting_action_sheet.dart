import 'dart:io';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/utils/navigator_arguments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

buildAccountingActionSheet(BuildContext context) {
  Platform.isAndroid
      ? showMaterialModalBottomSheet(
          context: context,
          builder: (BuildContext context) => Wrap(
            children: AppConst.accountingItems.entries
                .map(
                  (item) => ListTile(
                    title: Text(item.key),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        '/accounting',
                        arguments: AccountingArguments(item.key, item.value),
                      );
                    },
                  ),
                )
                .toList(),
            // ListTile(
            //   title: Text(
            //     'Annulla',
            //     style: TextStyle(color: AppColors.errorColor),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
          ),
        )
      : showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            title: const Text('Seleziona un opzione'),
            actions: AppConst.accountingItems.entries
                .map((item) => CupertinoActionSheetAction(
                      child: Text(
                        item.key,
                        style: TextStyle(
                            fontSize: 17, color: AppColors.labelDarkColor),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          '/accounting',
                          arguments: AccountingArguments(item.key, item.value),
                        );
                      },
                    ))
                .toList(),
            cancelButton: CupertinoActionSheetAction(
              isDestructiveAction: true,
              child: Text(
                'Annulla',
                style: TextStyle(fontSize: 17, color: AppColors.errorColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
}
