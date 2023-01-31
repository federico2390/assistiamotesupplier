import 'dart:convert';

List<Feed> feedFromJson(String str) =>
    List<Feed>.from(json.decode(str).map((x) => Feed.fromJson(x)));

String feedToJson(List<Feed> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Feed {
  Feed({
    this.notificationId,
    this.notificationTitle,
    this.notificationMessage,
    this.notificationToUser,
    this.notificationToPalace,
    this.notificationDatetime,
    this.notificationType,
    this.notificationRead,
    this.notificationRemainderDatetime1,
    this.notificationRemainderDatetime2,
    this.notificationExpiration,
    this.notificationOpened,
  });

  String? notificationId;
  String? notificationTitle;
  String? notificationMessage;
  String? notificationToUser;
  String? notificationToPalace;
  String? notificationDatetime;
  String? notificationType;
  String? notificationRead;
  String? notificationRemainderDatetime1;
  String? notificationRemainderDatetime2;
  String? notificationExpiration;
  String? notificationOpened;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        notificationId: json["notification_id"] ?? '',
        notificationTitle: json["notification_title"] ?? '',
        notificationMessage: json["notification_message"] ?? '',
        notificationToUser: json["notification_to_user"] ?? '',
        notificationToPalace: json["notification_to_palace"] ?? '',
        notificationDatetime: json["notification_datetime"] ?? '',
        notificationType: json["notification_type"] ?? '',
        notificationRead: json["notification_read"] ?? '',
        notificationRemainderDatetime1:
            json["notification_remainder_datetime_1"] ?? '',
        notificationRemainderDatetime2:
            json["notification_remainder_datetime_2"] ?? '',
        notificationExpiration: json["notification_expiration"] ?? '',
        notificationOpened: json["notification_opened"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "notification_id": notificationId ?? '',
        "notification_title": notificationTitle ?? '',
        "notification_message": notificationMessage ?? '',
        "notification_to_user": notificationToUser ?? '',
        "notification_to_palace": notificationToPalace ?? '',
        "notification_datetime": notificationDatetime ?? '',
        "notification_type": notificationType ?? '',
        "notification_read": notificationRead ?? '',
        "notification_remainder_datetime_1":
            notificationRemainderDatetime1 ?? '',
        "notification_remainder_datetime_2":
            notificationRemainderDatetime2 ?? '',
        "notification_expiration": notificationExpiration ?? '',
        "notification_opened": notificationOpened ?? '',
      };
}

class PushNotificationsMessage {
  String? title;
  String? body;

  PushNotificationsMessage({
    this.title = '',
    this.body = '',
  });
}
