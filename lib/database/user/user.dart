import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class UserDatabase {
  @HiveField(0)
  String? userId;
  @HiveField(1)
  @HiveField(5)
  String? userEmail;
  @HiveField(6)
  String? userName;
  @HiveField(7)
  String? userCf;
  @HiveField(8)
  String? userUsername;
  @HiveField(9)
  String? userPassword;
  @HiveField(10)
  String? userToken;
  @HiveField(11)
  String? notification;
  @HiveField(12)
  String? firstTimeLogged;

  UserDatabase({
    this.userId,
    this.userEmail,
    this.userName,
    this.userCf,
    this.userUsername,
    this.userPassword,
    this.userToken,
    this.notification,
    this.firstTimeLogged,
  });

  factory UserDatabase.fromJson(Map<String, dynamic> map) {
    return UserDatabase(
      userId: map['user_id'] ?? '',
      userEmail: map['user_email'] ?? '',
      userName: map['user_name'] ?? '',
      userCf: map['user_cf'] ?? '',
      userUsername: map['user_username'] ?? '',
      userPassword: map['user_password'] ?? '',
      userToken: map['user_token'] ?? '',
      notification: map['notification'] ?? '',
      firstTimeLogged: map['first_time_logged'] ?? '',
    );
  }
}
