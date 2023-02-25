import 'package:adminpanel/api/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:adminpanel/database/user/user.dart';

class UserProvider extends ChangeNotifier {
  UserDatabase _localUser = UserDatabase();
  UserDatabase get localuser => _localUser;

  Future<UserDatabase> getUser() async {
    if (_localUser.userId != null) {
      UserDatabase user = await UserApi().getUser(_localUser.userId!);
      await updateLocalUser(user);
      notifyListeners();
    }
    return _localUser;
  }

  Future<UserDatabase> getLocalUser() async {
    final box = await Hive.openBox<UserDatabase>('user');
    _localUser = box.values.isNotEmpty ? box.values.first : UserDatabase();

    notifyListeners();
    return _localUser;
  }

  addLocalUser(UserDatabase user) async {
    var box = await Hive.openBox<UserDatabase>('user');
    await box.add(user);

    getLocalUser();
    notifyListeners();
  }

  updateLocalUser(UserDatabase user) async {
    final box = Hive.box<UserDatabase>('user');
    await box.clear().whenComplete(() async {
      await box.putAll({'user': user});

      getLocalUser();
      notifyListeners();
    });
  }

  Future deleteLocalUser() async {
    final box = Hive.box<UserDatabase>('user');
    await box.deleteFromDisk().then((value) async {
      _localUser = UserDatabase();

      getLocalUser();
      notifyListeners();
      return _localUser;
    });
  }
}
