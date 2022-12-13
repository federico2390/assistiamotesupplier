import 'package:adminpanel/database/user/user.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserProvider extends ChangeNotifier {
  UserDatabase _user = UserDatabase();
  UserDatabase get user => _user;

  Future<UserDatabase> getUser() async {
    final box = await Hive.openBox<UserDatabase>('user');
    _user = box.values.isNotEmpty ? box.values.first : UserDatabase();
    notifyListeners();
    return _user;
  }

  addUser(UserDatabase user) async {
    var box = await Hive.openBox<UserDatabase>('user');
    box.add(user);
    getUser();
    notifyListeners();
  }

  updateUser(UserDatabase user) {
    final box = Hive.box<UserDatabase>('user');
    box.putAll({'user': user});
    getUser();
    notifyListeners();
  }

  Future deleteUser() async {
    final box = Hive.box<UserDatabase>('user');
    box.deleteFromDisk().then((value) {
      _user = UserDatabase();
      getUser();
      notifyListeners();
      return _user;
    });
  }
}
