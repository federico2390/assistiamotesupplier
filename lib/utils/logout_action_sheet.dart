import 'dart:io';

import 'package:adminpanel/api/logout.dart';
import 'package:adminpanel/configs/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

buildLogoutActionSheet(BuildContext context) async {
  Platform.isAndroid
      ? showMaterialModalBottomSheet(
          context: context,
          builder: (BuildContext context) => Wrap(
            children: [
              ListTile(
                title: Text(
                  'Esci',
                  style: TextStyle(color: AppColors.errorColor),
                ),
                onTap: () {
                  Logout().logout(context);
                },
              ),
              ListTile(
                title: const Text('Annulla'),
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
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    Logout().logout(context);
                  },
                  child: Text(
                    'Esci',
                    style: TextStyle(fontSize: 17, color: AppColors.errorColor),
                  )),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDestructiveAction: true,
              child: Text(
                'Annulla',
                style: TextStyle(fontSize: 17, color: AppColors.labelDarkColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
}
