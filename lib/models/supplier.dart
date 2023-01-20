import 'dart:convert';

List<Supplier> supplierFromJson(String str) =>
    List<Supplier>.from(json.decode(str).map((x) => Supplier.fromJson(x)));

String supplierToJson(List<Supplier> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Supplier {
  Supplier({
    this.supplierType,
  });

  String? supplierType;

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        supplierType: json["supplier_type"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "supplier_type": supplierType ?? '',
      };
}
