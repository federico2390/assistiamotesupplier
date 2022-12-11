class Palace {
  String? id, name, cf, address;

  Palace({
    this.id,
    this.name,
    this.cf,
    this.address,
  });

  factory Palace.fromJson(Map<String, dynamic> json) {
    return Palace(
      id: json['palace_id'] ?? '',
      name: json['palace_name'] ?? '',
      cf: json['palace_cf'] ?? '',
      address: json['palace_address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "palace_id": id ?? '',
      "palace_name": name ?? '',
      "vcf": cf ?? '',
      "palace_address": address ?? '',
    };
  }
}
