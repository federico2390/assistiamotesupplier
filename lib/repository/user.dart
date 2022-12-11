import 'dart:convert';

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/user.dart';
import 'package:adminpanel/utils/alerts.dart';
import 'package:adminpanel/utils/secure_storage.dart';
import 'package:adminpanel/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  bool get isLogged => SharedPrefs.getInt('logged') != null ? true : false;

  Future login(BuildContext context, String username, String password) async {
    try {
      Alerts.loadingAlert(
        context,
        title: 'Un momento...',
        subtitle: 'Effettuo l\'accesso',
      );

      var response = await http.post(
        Uri.parse(AppConst.base + AppConst.login),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        Alerts.hide;

        final jsonData = json.decode(response.body);
        final user = User.fromJson(jsonData[0]);

        await SharedPrefs.setString('id', user.id!);
        await SharedPrefs.setString('email', user.email!);
        await SharedPrefs.setString('name', user.name!);
        await SharedPrefs.setString('surname', user.surname!);
        await SharedPrefs.setString('cf', user.cf!);
        await SharedPrefs.setString('token', user.token!);
        await SharedPrefs.setInt('logged', 1);

        await SecureStorage.write('username', user.username!);
        await SecureStorage.write('password', user.password!);

        Alerts.successAlert(context,
                title: 'Accesso riuscito!',
                subtitle: 'Benvenuta/o ${user.name}')
            .whenComplete(() {
          Navigator.pushNamedAndRemoveUntil(
              context, '/', (Route<dynamic> route) => false);
        });
      }
    } on PlatformException catch (error) {
      print('PlatformException_login: $error');
    } catch (error) {
      print('ERROR_login: $error');
    }
  }

  Future<bool> logout(BuildContext context, String userId) async {
    try {
      Alerts.errorAlert(context,
          title: 'Un momento...', subtitle: 'Esco dall\'account');

      var response = await http.post(
        Uri.parse(AppConst.base + AppConst.logout),
        body: {"id": userId},
      );
      if (response.body == 'Success') {
        Alerts.hide;
        return true;
      }
    } catch (error) {
      print('ERROR_logout: ${error.toString()}');
    }
    return false;
  }
}
