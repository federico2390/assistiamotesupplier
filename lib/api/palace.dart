import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/models/palace.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PalaceApi {
  Future<List<Palace>> getPalaces(BuildContext context) async {
    List<Palace> palaces = [];

    try {
      final user = context.read<UserProvider>().localuser;

      var response = await http.post(
        Uri.parse(AppConst.palace),
        body: {
          "get_palace": 'get_palace',
          "user_username": user.userUsername,
          "user_password": user.userPassword,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        palaces = palaceFromJson(response.body);
      } else {
        print('Can\'t get Palaces');
      }
    } catch (error) {
      print('ERROR_getPalaces: $error');
    }
    return palaces;
  }
}
