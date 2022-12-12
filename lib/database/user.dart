import 'dart:convert';

import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class UserDatabase {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String? palaceId;
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
  String? userSurname;
  @HiveField(8)
  String? userCf;
  @HiveField(9)
  String? userUsername;
  @HiveField(10)
  String? userPassword;
  @HiveField(11)
  String? userToken;

  UserDatabase({
    this.userId,
    this.palaceId,
    this.palaceName,
    this.palaceCf,
    this.palaceAddress,
    this.userEmail,
    this.userName,
    this.userSurname,
    this.userCf,
    this.userUsername,
    this.userPassword,
    this.userToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'palaceId': palaceId,
      'palaceName': palaceName,
      'palaceCf': palaceCf,
      'palaceAddress': palaceAddress,
      'userEmail': userEmail,
      'userName': userName,
      'userSurname': userSurname,
      'userCf': userCf,
      'userUsername': userUsername,
      'userPassword': userPassword,
      'userToken': userToken,
    };
  }

  factory UserDatabase.fromMap(Map<String, dynamic> map) {
    return UserDatabase(
      userId: map['userId'] != null ? map['userId'] as String : null,
      palaceId: map['palaceId'] != null ? map['palaceId'] as String : null,
      palaceName:
          map['palaceName'] != null ? map['palaceName'] as String : null,
      palaceCf: map['palaceCf'] != null ? map['palaceCf'] as String : null,
      palaceAddress:
          map['palaceAddress'] != null ? map['palaceAddress'] as String : null,
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      userSurname:
          map['userSurname'] != null ? map['userSurname'] as String : null,
      userCf: map['userCf'] != null ? map['userCf'] as String : null,
      userUsername:
          map['userUsername'] != null ? map['userUsername'] as String : null,
      userPassword:
          map['userPassword'] != null ? map['userPassword'] as String : null,
      userToken: map['userToken'] != null ? map['userToken'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDatabase.fromJson(String source) =>
      UserDatabase.fromMap(json.decode(source) as Map<String, dynamic>);
}
