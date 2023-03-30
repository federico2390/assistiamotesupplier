import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:adminpanel/configs/colors.dart';

buildModalPopup(
    BuildContext context, String title, String subtitle, String action) async {
  kIsWeb
      ? showDialog(
          context: context,
          useRootNavigator: true,
          builder: (BuildContext context) => AlertDialog(
            content: Wrap(
              children: [
                Text(title),
                Text(subtitle),
                ListTile(
                  title: Text(
                    action,
                    style: TextStyle(color: AppColors.secondaryColor),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await AppSettings.openNotificationSettings();
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
          ),
        )
      : Platform.isAndroid
          ? showDialog(
              context: context,
              useRootNavigator: true,
              builder: (BuildContext context) => Wrap(
                children: [
                  Text(title),
                  Text(subtitle),
                  ListTile(
                    title: Text(
                      action,
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                      await AppSettings.openNotificationSettings();
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
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text(title),
                content: Text(subtitle),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Annulla',
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () async {
                      Navigator.pop(context);
                      await AppSettings.openNotificationSettings();
                    },
                    child: Text(
                      action,
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.labelDarkColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
}
