import 'dart:convert';

List<Notifications> notificationsFromJson(String str) =>
    List<Notifications>.from(
        json.decode(str).map((x) => Notifications.fromJson(x)));

String notificationsToJson(List<Notifications> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notifications {
  Notifications({
    this.notificationId,
    this.notificationTitle,
    this.notificationMessage,
    this.notificationToUser,
    this.notificationDatetime,
    this.notificationType,
    this.notificationOpen,
    this.notificationRemainderDatetime1,
    this.notificationRemainderDatetime2,
  });

  String? notificationId;
  String? notificationTitle;
  String? notificationMessage;
  String? notificationToUser;
  String? notificationDatetime;
  String? notificationType;
  String? notificationOpen;
  String? notificationRemainderDatetime1;
  String? notificationRemainderDatetime2;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        notificationId: json["notification_id"] ?? '',
        notificationTitle: json["notification_title"] ?? '',
        notificationMessage: json["notification_message"] ?? '',
        notificationToUser: json["notification_to_user"] ?? '',
        notificationDatetime: json["notification_datetime"] ?? '',
        notificationType: json["notification_type"] ?? '',
        notificationOpen: json["notification_open"] ?? '',
        notificationRemainderDatetime1:
            json["notification_remainder_datetime_1"] ?? '',
        notificationRemainderDatetime2:
            json["notification_remainder_datetime_2"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "notification_id": notificationId ?? '',
        "notification_title": notificationTitle ?? '',
        "notification_message": notificationMessage ?? '',
        "notification_to_user": notificationToUser ?? '',
        "notification_datetime": notificationDatetime ?? '',
        "notification_type": notificationType ?? '',
        "notification_open": notificationOpen ?? '',
        "notification_remainder_datetime_1":
            notificationRemainderDatetime1 ?? '',
        "notification_remainder_datetime_2":
            notificationRemainderDatetime2 ?? '',
      };
}
