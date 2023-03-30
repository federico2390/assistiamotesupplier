import 'dart:convert';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
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
        var response = await http.post(
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
                  supplierEmail: user.supplierEmail!.trim(),
                  supplierName: user.supplierName!.trim(),
                  supplierType: user.supplierType!.trim(),
                  supplierCf: user.supplierCf!.trim(),
                  supplierToken: user.supplierToken!.trim(),
                  notification: user.notification!.trim(),
                  supplierIsLogged: user.supplierIsLogged!.trim(),
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
      print('PlatformException_login: $error');
    } catch (error) {
      print('ERROR_login: $error');
      await Alerts.hideAlert();
      await Alerts.errorAlert(context,
          title: 'Errore', subtitle: 'Email o C.F./P.IVA errati');
    }
  }
}
