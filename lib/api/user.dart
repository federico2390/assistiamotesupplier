import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/database/user/user.dart';
import 'package:adminpanel/utils/shared_preference.dart';

class UserApi {
  bool get isLogged =>
      SharedPrefs.getInt('logged') != null && SharedPrefs.getInt('logged') == 1
          ? true
          : false;

  Future<UserDatabase> getUser(String supplierId) async {
    UserDatabase user = UserDatabase();

    try {
      var response = await http.post(
        kIsWeb
            ? Uri.parse(AppConst.supplier).replace(host: AppConst.domain)
            : Uri.parse(AppConst.supplier),
        body: {
          "get_supplier": 'get_supplier',
          'supplier_id': supplierId,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        user = UserDatabase.fromJson(jsonData[0]);
      }
    } catch (error) {
      print('ERROR_getFeed: $error');
    }
    return user;
  }
}
