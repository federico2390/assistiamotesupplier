import 'dart:io';

import 'package:adminpanel/api/logout.dart';
import 'package:adminpanel/configs/colors.dart';
import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/main.dart';
import 'package:adminpanel/providers/setting.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

buildLogoutActionSheet(BuildContext context) async {
  final user = await context.read<UserProvider>().getUser();
  if (user.userId != null) {
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
                    Logout()
                        .logout(
                            context, user.userId != null ? user.userId! : '')
                        .then((value) {
                      if (value == true) {
                        logged = null;

                        int? rememberData = SharedPrefs.getInt('rememberData');
                        if (rememberData == 0 || rememberData == null) {
                          SharedPrefs.instance.clear();
                          context.read<UserProvider>().deleteUser();
                          context.read<SettingProvider>().deleteNotification();
                        } else {
                          context.read<UserProvider>().updateUser(
                                UserDatabase(
                                  userId: null,
                                  palaceId: null,
                                  palaceName: null,
                                  palaceCf: null,
                                  palaceAddress: null,
                                  userEmail: null,
                                  userName: null,
                                  userSurname: null,
                                  userCf: null,
                                  userUsername: user.userUsername!,
                                  userPassword: user.userPassword!,
                                  userToken: null,
                                ),
                              );

                          SharedPrefs.instance.remove('logged');
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
                      Logout()
                          .logout(
                              context, user.userId != null ? user.userId! : '')
                          .then((value) {
                        if (value == true) {
                          logged = null;

                          int? rememberData =
                              SharedPrefs.getInt('rememberData');
                          if (rememberData == 0 || rememberData == null) {
                            SharedPrefs.instance.clear();
                            context.read<UserProvider>().deleteUser();
                            context
                                .read<SettingProvider>()
                                .deleteNotification();
                          } else {
                            context.read<UserProvider>().updateUser(
                                  UserDatabase(
                                    userId: null,
                                    palaceId: null,
                                    palaceName: null,
                                    palaceCf: null,
                                    palaceAddress: null,
                                    userEmail: null,
                                    userName: null,
                                    userSurname: null,
                                    userCf: null,
                                    userUsername: user.userUsername!,
                                    userPassword: user.userPassword!,
                                    userToken: null,
                                  ),
                                );

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
                      style:
                          TextStyle(fontSize: 17, color: AppColors.errorColor),
                    )),
              ],
              cancelButton: CupertinoActionSheetAction(
                isDestructiveAction: true,
                child: Text(
                  'Annulla',
                  style:
                      TextStyle(fontSize: 17, color: AppColors.labelDarkColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
  } else {
    Alerts.errorAlert(context,
        title: 'Errore', subtitle: 'Per favore contatta l\'amministratore.');
  }
}
