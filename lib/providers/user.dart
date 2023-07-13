import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:adminpanel/api/user.dart';
import 'package:adminpanel/database/user/user.dart';

class UserProvider extends ChangeNotifier {
  Timer? timer;

  UserDatabase _localUser = UserDatabase();
  UserDatabase get localuser => _localUser;

  Future<UserDatabase> getUser() async {
    if (_localUser.supplierId != null) {
      UserDatabase user = await UserApi().getUser(_localUser.supplierId!);
      await updateLocalUser(user);

      notifyListeners();
      return _localUser;
    }
    return _localUser;
  }

  Future<UserDatabase> getLocalUser() async {
    try {
      final box = await Hive.openBox<UserDatabase>('user');
      _localUser = box.values.isNotEmpty ? box.values.first : UserDatabase();
    } catch (error) {
      print('ERROR_getLocalUser');
    }
    notifyListeners();
    return _localUser;
  }

  addLocalUser(UserDatabase user) async {
    try {
      var box = await Hive.openBox<UserDatabase>('user');
      await box.add(user);
      await getLocalUser();
    } catch (error) {
      print('ERROR_addLocalUser');
    }
    notifyListeners();
  }

  updateLocalUser(UserDatabase user) async {
    try {
      final box = Hive.box<UserDatabase>('user');
      await box.clear().whenComplete(() async {
        await box.putAll({'user': user});
        await getLocalUser();
      });
    } catch (error) {
      print('ERROR_updateLocalUser');
    }
    notifyListeners();
  }

  Future deleteLocalUser() async {
    try {
      final box = Hive.box<UserDatabase>('user');
      await box.deleteFromDisk().then((value) async {
        _localUser = UserDatabase();
        await getLocalUser();
      });
    } catch (error) {
      print('ERROR_updateLocalUser');
    }
    notifyListeners();
  }
}
