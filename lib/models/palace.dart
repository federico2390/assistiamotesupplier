import 'dart:convert';

List<Palace> palaceFromJson(String str) =>
    List<Palace>.from(json.decode(str).map((x) => Palace.fromJson(x)));

String palaceToJson(List<Palace> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Palace {
  Palace({
    this.userId,
    this.palaceId,
    this.userEmail,
    this.userUsername,
    this.userName,
    this.userCf,
    this.userPassword,
    this.userToken,
    this.notification,
    this.firstTimeLogged,
    this.palaceName,
    this.palaceCf,
    this.palaceAddress,
    this.palaceDescription,
  });

  String? userId;
  String? palaceId;
  dynamic userEmail;
  String? userUsername;
  String? userName;
  dynamic userCf;
  String? userPassword;
  String? userToken;
  String? notification;
  String? firstTimeLogged;
  String? palaceName;
  dynamic palaceCf;
  String? palaceAddress;
  String? palaceDescription;

  factory Palace.fromJson(Map<String, dynamic> json) => Palace(
        userId: json["user_id"],
        palaceId: json["palace_id"],
        userEmail: json["user_email"],
        userUsername: json["user_username"],
        userName: json["user_name"],
        userCf: json["user_cf"],
        userPassword: json["user_password"],
        userToken: json["user_token"],
        notification: json["notification"],
        firstTimeLogged: json["first_time_logged"],
        palaceName: json["palace_name"],
        palaceCf: json["palace_cf"],
        palaceAddress: json["palace_address"],
        palaceDescription: json["palace_description"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "palace_id": palaceId,
        "user_email": userEmail,
        "user_username": userUsername,
        "user_name": userName,
        "user_cf": userCf,
        "user_password": userPassword,
        "user_token": userToken,
        "notification": notification,
        "first_time_logged": firstTimeLogged,
        "palace_name": palaceName,
        "palace_cf": palaceCf,
        "palace_address": palaceAddress,
        "palace_description": palaceDescription,
      };
}
