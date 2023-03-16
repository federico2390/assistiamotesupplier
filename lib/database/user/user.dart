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
  String? supplierType;
  @HiveField(4)
  String? supplierCf;
  @HiveField(5)
  String? supplierToken;
  @HiveField(6)
  String? notification;

  UserDatabase({
    this.supplierId,
    this.supplierEmail,
    this.supplierName,
    this.supplierType,
    this.supplierCf,
    this.supplierToken,
    this.notification,
  });

  factory UserDatabase.fromJson(Map<String, dynamic> map) {
    return UserDatabase(
      supplierId: map['supplier_id'] ?? '',
      supplierEmail: map['supplier_email'] ?? '',
      supplierName: map['supplier_name'] ?? '',
      supplierType: map['supplier_type'] ?? '',
      supplierCf: map['supplier_cf'] ?? '',
      supplierToken: map['supplier_token'] ?? '',
      notification: map['notification'] ?? '',
    );
  }
}
