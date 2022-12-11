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
            children: [
              ListTile(
                title: const Text('Fatture'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/accounting',
                    arguments: AccountingArguments('Fatture', AppConst.fatture),
                  );
                },
              ),
              ListTile(
                title: const Text('Consuntivo'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/accounting',
                    arguments:
                        AccountingArguments('Consuntivo', AppConst.consuntivo),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Annulla',
                  style: TextStyle(color: AppColors.errorColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )
      : showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            title: const Text('Seleziona un opzione'),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: Text(
                  'Fatture',
                  style:
                      TextStyle(fontSize: 17, color: AppColors.labelDarkColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/accounting',
                    arguments: AccountingArguments('Fatture', AppConst.fatture),
                  );
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Consuntivo',
                  style:
                      TextStyle(fontSize: 17, color: AppColors.labelDarkColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/accounting',
                    arguments:
                        AccountingArguments('Consuntivo', AppConst.consuntivo),
                  );
                },
              ),
            ],
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
