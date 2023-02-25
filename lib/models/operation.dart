// To parse this JSON data, do
//
//     final operation = operationFromJson(jsonString);

import 'dart:convert';

List<Operation> operationFromJson(String str) =>
    List<Operation>.from(json.decode(str).map((x) => Operation.fromJson(x)));

String operationToJson(List<Operation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Operation {
  Operation({
    this.operationId,
    this.palaceId,
    this.userId,
    this.operationType,
    this.operation,
    this.description,
    this.media1,
    this.media2,
    this.media3,
    this.supplierId,
    this.supplierDescription,
    this.supplierMedia1,
    this.supplierMedia2,
    this.operationDatetime,
    this.palaceName,
    this.palaceCf,
    this.palaceAddress,
    this.palaceDescription,
    this.userEmail,
    this.userUsername,
    this.userName,
    this.userCf,
    this.userPassword,
    this.userToken,
    this.notification,
    this.firstTimeLogged,
    this.media,
    this.supplierMedia,
    this.supplierName,
    this.supplierType,
    this.supplierCf,
    this.operationState,
    this.operationViewed,
    this.operationWorking,
    this.operationOpened,
    this.operationLastUpdate,
  });

  String? operationId;
  String? palaceId;
  String? userId;
  String? operationType;
  String? operation;
  String? description;
  String? media1;
  String? media2;
  String? media3;
  String? supplierId;
  String? supplierDescription;
  String? supplierMedia1;
  String? supplierMedia2;
  String? operationDatetime;
  String? palaceName;
  String? palaceCf;
  String? palaceAddress;
  String? palaceDescription;
  String? userEmail;
  String? userUsername;
  String? userName;
  String? userCf;
  String? userPassword;
  String? userToken;
  String? notification;
  String? firstTimeLogged;
  String? supplierName;
  String? supplierType;
  String? supplierCf;
  String? operationState;
  String? operationViewed;
  String? operationWorking;
  String? operationOpened;
  String? operationLastUpdate;

  List<String>? media;
  List<String>? supplierMedia;

  factory Operation.fromJson(Map<String, dynamic> json) => Operation(
        operationId: json["operation_id"] ?? '',
        palaceId: json["palace_id"] ?? '',
        userId: json["user_id"] ?? '',
        operationType: json["operation_type"] ?? '',
        operation: json["operation"] ?? '',
        description: json["description"] ?? '',
        media1: json["media_1"] ?? '',
        media2: json["media_2"] ?? '',
        media3: json["media_3"] ?? '',
        supplierId: json["supplier_id"] ?? '',
        supplierDescription: json["supplier_description"] ?? '',
        supplierMedia1: json["supplier_media_1"] ?? '',
        supplierMedia2: json["supplier_media_2"] ?? '',
        operationDatetime: json["operation_datetime"] ?? '',
        palaceName: json["palace_name"] ?? '',
        palaceCf: json["palace_cf"] ?? '',
        palaceAddress: json["palace_address"] ?? '',
        palaceDescription: json["palace_description"] ?? '',
        userEmail: json["user_email"] ?? '',
        userUsername: json["user_username"] ?? '',
        userName: json["user_name"] ?? '',
        userCf: json["user_cf"] ?? '',
        userPassword: json["user_password"] ?? '',
        userToken: json["user_token"] ?? '',
        notification: json["notification"] ?? '',
        firstTimeLogged: json["first_time_logged"] ?? '',
        supplierName: json["supplier_name"] ?? '',
        supplierType: json["supplier_type"] ?? '',
        supplierCf: json["supplier_cf"] ?? '',
        operationState: json["operation_state"] ?? '',
        operationViewed: json["operation_viewed"] ?? '',
        operationWorking: json["operation_working"] ?? '',
        operationOpened: json["operation_opened"] ?? '',
        operationLastUpdate: json["operation_last_update"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "operation_id": operationId ?? '',
        "palace_id": palaceId ?? '',
        "user_id": userId ?? '',
        "operation_type": operationType ?? '',
        "operation": operation ?? '',
        "description": description ?? '',
        "media_1": media1 ?? '',
        "media_2": media2 ?? '',
        "media_3": media3 ?? '',
        "supplier_id": supplierId ?? '',
        "supplier_description": supplierDescription ?? '',
        "supplier_media_1": supplierMedia1 ?? '',
        "supplier_media_2": supplierMedia2 ?? '',
        "operation_datetime": operationDatetime ?? '',
        "palace_name": palaceName ?? '',
        "palace_cf": palaceCf ?? '',
        "palace_address": palaceAddress ?? '',
        "palace_description": palaceDescription ?? '',
        "user_email": userEmail ?? '',
        "user_username": userUsername ?? '',
        "user_name": userName ?? '',
        "user_cf": userCf ?? '',
        "user_password": userPassword ?? '',
        "user_token": userToken ?? '',
        "notification": notification ?? '',
        "first_time_logged": firstTimeLogged ?? '',
        "supplier_name": supplierName ?? '',
        "supplier_type": supplierType ?? '',
        "supplier_cf": supplierCf ?? '',
        "operation_state": operationState ?? '',
        "operation_viewed": operationViewed ?? '',
        "operation_working": operationWorking ?? '',
        "operation_opened": operationOpened ?? '',
        "operation_last_update": operationLastUpdate ?? '',
      };
}
