import 'dart:convert';

class Setting {
  Setting({
    this.settingId,
    this.settingYear,
    this.settingsMeters,
  });

  String? settingId;
  String? settingYear;
  String? settingsMeters;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        settingId: json["setting_id"] ?? '',
        settingYear: json["setting_year"] ?? '',
        settingsMeters: json["settings_meters"] ?? '',
      );
}

List<NotificationSetting> notificationSettingFromJson(String str) =>
    List<NotificationSetting>.from(
        json.decode(str).map((x) => NotificationSetting.fromJson(x)));

String notificationSettingToJson(List<NotificationSetting> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationSetting {
  NotificationSetting({
    this.notification,
  });

  String? notification;

  factory NotificationSetting.fromJson(Map<String, dynamic> json) =>
      NotificationSetting(
        notification: json["supplier_notification_permission"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "supplier_notification_permission": notification ?? '',
      };
}
