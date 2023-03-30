import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/utils/launcher.dart';

buildPrivacyPolicyActionSheet(BuildContext context) async {
  kIsWeb
      ? showDialog(
          context: context,
          useRootNavigator: true,
          builder: (BuildContext context) => AlertDialog(
            content: Wrap(
              children: [
                ListTile(
                  title: Text(
                    'studiopedico.it',
                    style: TextStyle(color: AppColors.labelDarkColor),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    launchUrls(AppConst.servicePrivacyPolicy);
                  },
                ),
                ListTile(
                  title: Text(
                    'edhousesuite.com',
                    style: TextStyle(color: AppColors.labelDarkColor),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    launchUrls(AppConst.serviceHostPrivacyPolicy);
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
          ? showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              builder: (BuildContext context) => Wrap(
                children: [
                  ListTile(
                    title: Text(
                      'studiopedico.it',
                      style: TextStyle(color: AppColors.labelDarkColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      launchUrls(AppConst.servicePrivacyPolicy);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'edhousesuite.com',
                      style: TextStyle(color: AppColors.labelDarkColor),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      launchUrls(AppConst.serviceHostPrivacyPolicy);
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
                      Navigator.pop(context);
                      launchUrls(AppConst.servicePrivacyPolicy);
                    },
                    child: Text(
                      'studiopedico.it',
                      style: TextStyle(
                          fontSize: 17, color: AppColors.labelDarkColor),
                    ),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      launchUrls(AppConst.serviceHostPrivacyPolicy);
                    },
                    child: Text(
                      'cedhousesuite.com',
                      style: TextStyle(
                          fontSize: 17, color: AppColors.labelDarkColor),
                    ),
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  child: Text(
                    'Annulla',
                    style: TextStyle(
                        fontSize: 17, color: AppColors.secondaryColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
}
