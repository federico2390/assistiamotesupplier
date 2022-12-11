import 'dart:io';

import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/main.dart';
import 'package:adminpanel/repository/user.dart';
import 'package:adminpanel/utils/secure_storage.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

buildLogoutActionSheet(BuildContext context) {
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
                  UserRepository()
                      .logout(context, SharedPrefs.getString('id')!)
                      .then((value) async {
                    if (value == true) {
                      logged = null;

                      int? rememberData = SharedPrefs.getInt('rememberData');
                      if (rememberData == 0 || rememberData == null) {
                        SharedPrefs.instance.clear();
                        SecureStorage.deleteAll();
                        print('DON\'T SAVE');
                      } else {
                        SharedPrefs.instance.remove('id');
                        SharedPrefs.instance.remove('email');
                        SharedPrefs.instance.remove('name');
                        SharedPrefs.instance.remove('surname');
                        SharedPrefs.instance.remove('cf');
                        SharedPrefs.instance.remove('token');
                        SharedPrefs.instance.remove('logged');
                        print('SAVE');
                      }

                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', ModalRoute.withName('/'));
                    }
                  });
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
                    UserRepository()
                        .logout(context, SharedPrefs.getString('id')!)
                        .then((value) async {
                      if (value == true) {
                        logged = null;

                        int? rememberData = SharedPrefs.getInt('rememberData');
                        if (rememberData == 0 || rememberData == null) {
                          SharedPrefs.instance.clear();
                          SecureStorage.deleteAll();
                        } else {
                          SharedPrefs.instance.remove('id');
                          SharedPrefs.instance.remove('email');
                          SharedPrefs.instance.remove('name');
                          SharedPrefs.instance.remove('surname');
                          SharedPrefs.instance.remove('cf');
                          SharedPrefs.instance.remove('token');
                          SharedPrefs.instance.remove('logged');
                        }

                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', ModalRoute.withName('/'));
                      }
                    });
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
