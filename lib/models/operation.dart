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
    this.operationLastUpdate,
    this.operationState,
    this.operationViewed,
    this.operationWorking,
    this.supplierOpened,
    this.requestBy,
    this.palaceName,
    this.palaceCf,
    this.palaceAddress,
    this.palaceUtilsName,
    this.palaceUtilsNumber,
    this.palaceDescription,
    this.supplierEmail,
    this.supplierName,
    this.supplierType,
    this.supplierCf,
    this.supplierToken,
    this.notification,
    this.supplierIsLogged,
    this.yearId,
    this.yearValue,
    this.media,
    this.supplierMedia,
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
  String? operationLastUpdate;
  String? operationState;
  String? operationViewed;
  String? operationWorking;
  String? supplierOpened;
  String? requestBy;
  String? palaceName;
  String? palaceCf;
  String? palaceAddress;
  String? palaceUtilsName;
  String? palaceUtilsNumber;
  String? palaceDescription;
  String? supplierEmail;
  String? supplierName;
  String? supplierType;
  String? supplierCf;
  String? supplierToken;
  String? supplierIsLogged;
  String? notification;
  String? yearId;
  String? yearValue;

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
        operationLastUpdate: json["operation_last_update"] ?? '',
        operationState: json["operation_state"] ?? '',
        operationViewed: json["operation_viewed"] ?? '',
        operationWorking: json["operation_working"] ?? '',
        supplierOpened: json["supplier_opened"] ?? '',
        requestBy: json["request_by"] ?? '',
        palaceName: json["palace_name"] ?? '',
        palaceCf: json["palace_cf"] ?? '',
        palaceAddress: json["palace_address"] ?? '',
        palaceUtilsName: json["palace_utils_name"] ?? '',
        palaceUtilsNumber: json["palace_utils_number"] ?? '',
        palaceDescription: json["palace_description"] ?? '',
        supplierEmail: json["supplier_email"] ?? '',
        supplierName: json["supplier_name"] ?? '',
        supplierType: json["supplier_type"] ?? '',
        supplierCf: json["supplier_cf"] ?? '',
        supplierToken: json["supplier_token"] ?? '',
        notification: json["notification"] ?? '',
        yearId: json["year_id"] ?? '',
        yearValue: json["year_value"] ?? '',
        supplierIsLogged: json["supplier_is_logged"] ?? '',
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
        "operation_last_update": operationLastUpdate ?? '',
        "operation_state": operationState ?? '',
        "operation_viewed": operationViewed ?? '',
        "operation_working": operationWorking ?? '',
        "supplier_opened": supplierOpened ?? '',
        "request_by": requestBy ?? '',
        "palace_name": palaceName ?? '',
        "palace_cf": palaceCf ?? '',
        "palace_address": palaceAddress ?? '',
        "palace_utils_name": palaceUtilsName ?? '',
        "palace_utils_number": palaceUtilsNumber ?? '',
        "palace_description": palaceDescription ?? '',
        "supplier_email": supplierEmail ?? '',
        "supplier_name": supplierName ?? '',
        "supplier_type": supplierType ?? '',
        "supplier_cf": supplierCf ?? '',
        "supplier_token": supplierToken ?? '',
        "notification": notification ?? '',
        "year_id": yearId ?? '',
        "year_value": yearValue ?? '',
        "supplier_is_logged": supplierIsLogged ?? '',
      };
}
