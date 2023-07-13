import 'dart:convert';

List<Setting> settingFromJson(String str) =>
    List<Setting>.from(json.decode(str).map((x) => Setting.fromJson(x)));

String settingToJson(List<Setting> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Setting {
  Setting({
    this.notification,
  });

  String? notification;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        notification: json["supplier_notification_permission"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "supplier_notification_permission": notification ?? '',
      };
}
