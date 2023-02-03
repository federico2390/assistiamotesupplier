import 'dart:io';

import 'package:adminpanel/api/logout.dart';
import 'package:adminpanel/configs/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

buildLogoutActionSheet(BuildContext context) async {
  Platform.isAndroid
      ? showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          builder: (BuildContext context) => Wrap(
            children: [
              ListTile(
                title: Text(
                  'Esci',
                  style: TextStyle(color: AppColors.errorColor),
                ),
                onTap: () {
                  LogoutApi().logout(context);
                },
              ),
              ListTile(
                title: Text(
                  'Annulla',
                  style: TextStyle(color: AppColors.secondaryColor),
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
          useRootNavigator: true,
          builder: (BuildContext context) => CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    LogoutApi().logout(context);
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
                style: TextStyle(fontSize: 17, color: AppColors.secondaryColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
}
