import 'dart:io';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/utils/launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

buildPrivacyPolicyActionSheet(BuildContext context) async {
  Platform.isAndroid
      ? showMaterialModalBottomSheet(
          context: context,
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
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  launchUrls(AppConst.servicePrivacyPolicy);
                },
                child: Text(
                  'studiopedico.it',
                  style:
                      TextStyle(fontSize: 17, color: AppColors.labelDarkColor),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  launchUrls(AppConst.serviceHostPrivacyPolicy);
                },
                child: Text(
                  'cedhousesuite.com',
                  style:
                      TextStyle(fontSize: 17, color: AppColors.labelDarkColor),
                ),
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
