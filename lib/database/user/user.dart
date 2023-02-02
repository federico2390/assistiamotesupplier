import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class UserDatabase {
  @HiveField(0)
  String? userId;
  @HiveField(1)
  String? palaceId;
  @HiveField(2)
  String? palaceName;
  @HiveField(3)
  String? palaceCf;
  @HiveField(4)
  String? palaceAddress;
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
  String? generalNotification;
  @HiveField(13)
  String? firstTimeLogged;

  UserDatabase({
    this.userId,
    this.palaceId,
    this.palaceName,
    this.palaceCf,
    this.palaceAddress,
    this.userEmail,
    this.userName,
    this.userCf,
    this.userUsername,
    this.userPassword,
    this.userToken,
    this.notification,
    this.generalNotification,
    this.firstTimeLogged,
  });

  factory UserDatabase.fromJson(Map<String, dynamic> map) {
    return UserDatabase(
      userId: map['user_id'] ?? '',
      palaceId: map['palace_id'] ?? '',
      palaceName: map['palace_name'] ?? '',
      palaceCf: map['palace_cf'] ?? '',
      palaceAddress: map['palace_address'] ?? '',
      userEmail: map['user_email'] ?? '',
      userName: map['user_name'] ?? '',
      userCf: map['user_cf'] ?? '',
      userUsername: map['user_username'] ?? '',
      userPassword: map['user_password'] ?? '',
      userToken: map['user_token'] ?? '',
      notification: map['notification'] ?? '',
      generalNotification: map['general_notification'] ?? '',
      firstTimeLogged: map['first_time_logged'] ?? '',
    );
  }
}
