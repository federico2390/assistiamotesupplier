import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/main.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/shared_preference.dart';

class LogoutApi {
  Future logout(BuildContext context) async {
    final user = await context.read<UserProvider>().getLocalUser();
    if (user.supplierId != null) {
      try {
        await Alerts.errorAlert(context,
            title: 'Un momento...', subtitle: 'Esco dall\'account');

        logged = null;

        int? rememberData = SharedPrefs.getInt('rememberData');
        if (rememberData == 0 || rememberData == null) {
          await SharedPrefs.instance.clear();
          await context.read<UserProvider>().deleteLocalUser();
        } else {
          await context.read<UserProvider>().updateLocalUser(
                UserDatabase(
                  supplierId: user.supplierId!.trim(),
                  supplierEmail: user.supplierEmail!,
                  supplierName: user.supplierName!.trim(),
                  supplierPhone: user.supplierPhone!.trim(),
                  supplierType: user.supplierType!.trim(),
                  supplierCf: user.supplierCf!,
                  supplierCountry: user.supplierCountry!.trim(),
                  supplierRegion: user.supplierRegion!.trim(),
                  supplierProvince: user.supplierProvince!.trim(),
                  supplierCity: user.supplierCity!.trim(),
                  supplierAddress: user.supplierAddress!.trim(),
                  supplierProfilePicture: user.supplierProfilePicture!.trim(),
                  supplierDeviceToken: user.supplierDeviceToken!.trim(),
                  supplierNotificationPermission:
                      user.supplierNotificationPermission!.trim(),
                  supplierIsLogged: user.supplierIsLogged!.trim(),
                  verified: user.verified!.trim(),
                  curriculum: user.curriculum!.trim(),
                  createdDateTime: user.createdDateTime!.trim(),
                  coverageArea: user.coverageArea!.trim(),
                ),
              );
          await SharedPrefs.instance.remove('logged');
        }

        await Future.delayed(const Duration(seconds: 2), () async {
          Navigator.pop(context);
          await Alerts.hideAlert();
          await Navigator.pushNamedAndRemoveUntil(
              context, '/login', (Route<dynamic> route) => false);
        });
      } catch (error) {
        print('ERROR_logout: ${error.toString()}');
      }
    } else {
      print('ERROR User not found');

      await Alerts.errorAlert(context,
          title: 'Errore', subtitle: 'Per favore riprova');
    }
  }
}
