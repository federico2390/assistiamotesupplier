import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class UserDatabase {
  @HiveField(0)
  String? supplierId;
  @HiveField(1)
  String? supplierEmail;
  @HiveField(2)
  String? supplierName;
  @HiveField(3)
  String? supplierPhone;
  @HiveField(4)
  String? supplierType;
  @HiveField(5)
  String? supplierCf;
  @HiveField(6)
  String? supplierCountry;
  @HiveField(7)
  String? supplierRegion;
  @HiveField(8)
  String? supplierProvince;
  @HiveField(9)
  String? supplierCity;
  @HiveField(10)
  String? supplierAddress;
  @HiveField(11)
  String? supplierProfilePicture;
  @HiveField(12)
  String? supplierDeviceToken;
  @HiveField(13)
  String? supplierNotificationPermission;
  @HiveField(14)
  String? supplierIsLogged;
  @HiveField(15)
  String? verified;
  @HiveField(16)
  String? curriculum;
  @HiveField(17)
  String? createdDateTime;
  @HiveField(18)
  String? coverageArea;

  UserDatabase({
    this.supplierId,
    this.supplierEmail,
    this.supplierName,
    this.supplierPhone,
    this.supplierType,
    this.supplierCf,
    this.supplierCountry,
    this.supplierRegion,
    this.supplierProvince,
    this.supplierCity,
    this.supplierAddress,
    this.supplierProfilePicture,
    this.supplierDeviceToken,
    this.supplierNotificationPermission,
    this.supplierIsLogged,
    this.verified,
    this.curriculum,
    this.createdDateTime,
    this.coverageArea,
  });

  factory UserDatabase.fromJson(Map<String, dynamic> json) {
    return UserDatabase(
      supplierId: json['supplier_id'] ?? '',
      supplierEmail: json['supplier_email'] ?? '',
      supplierName: json['supplier_name'] ?? '',
      supplierPhone: json['supplier_phone'] ?? '',
      supplierType: json['supplier_type'] ?? '',
      supplierCf: json['supplier_cf'] ?? '',
      supplierCountry: json['supplier_country'] ?? '',
      supplierRegion: json['supplier_region'] ?? '',
      supplierProvince: json['supplier_province'] ?? '',
      supplierCity: json['supplier_city'] ?? '',
      supplierAddress: json['supplier_address'] ?? '',
      supplierProfilePicture: json['supplier_profile_picture'] ?? '',
      supplierDeviceToken: json['supplier_device_token'] ?? '',
      supplierNotificationPermission:
          json['supplier_notification_permission'] ?? '',
      supplierIsLogged: json['supplier_is_logged'] ?? '',
      verified: json['verified'] ?? '',
      curriculum: json['curriculum'] ?? '',
      createdDateTime: json['createdDateTime'] ?? '',
      coverageArea: json['coverage_area'] ?? '',
    );
  }
}
