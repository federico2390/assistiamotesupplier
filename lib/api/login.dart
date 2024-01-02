import 'dart:convert';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginApi {
  Future login(
      BuildContext context, String supplierEmail, String supplierCf) async {
    try {
      await Alerts.loadingAlert(
        context,
        title: 'Un momento...',
        subtitle: 'Effettuo l\'accesso',
      );

      await Future.delayed(const Duration(seconds: 3), () async {
        var response = await AppConst().client.post(
          kIsWeb
              ? Uri.parse(AppConst.login).replace(host: AppConst.domain)
              : Uri.parse(AppConst.login),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: {
            'login': 'login',
            'supplier_email': supplierEmail.trim(),
            'supplier_cf': supplierCf.trim(),
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final jsonData = json.decode(response.body);
          final UserDatabase user = UserDatabase.fromJson(jsonData[0]);

          await context.read<UserProvider>().addLocalUser(
                UserDatabase(
                  supplierId: user.supplierId!.trim(),
                  supplierEmail: supplierEmail.trim(),
                  supplierName: user.supplierName!.trim(),
                  supplierPhone: user.supplierPhone!.trim(),
                  supplierType: user.supplierType!.trim(),
                  supplierCf: supplierCf.trim(),
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

          await SharedPrefs.setInt('logged', 1);

          await Future.delayed(const Duration(seconds: 2), () async {
            await Alerts.hideAlert();
            await Navigator.pushNamedAndRemoveUntil(
                context, '/welcome', (Route<dynamic> route) => false);
          });
        }
      });
    } on PlatformException catch (error) {
      debugPrint('PlatformException_login: $error');
    } catch (error) {
      debugPrint('ERROR_login: $error');
      await Alerts.hideAlert();
      await Alerts.errorAlert(context,
          title: 'Errore', subtitle: 'Email o C.F./P.IVA errati');
    } finally {
      AppConst().client.close();
    }
  }
}
