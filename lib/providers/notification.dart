import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:adminpanel/api/notification.dart';
import 'package:adminpanel/models/notifications.dart';

class NotificationProvider extends ChangeNotifier {
  List<Notifications> _notifications = [];
  List<Notifications> get notifications => _notifications;

  Future<List<Notifications>> getNotifications(BuildContext context) async {
    List<Notifications> notificationList =
        await NotificationApi().getNotifications(context);

    notificationList.sort(
      (a, b) => DateTime.parse(
        DateFormat('dd/MM/yyyy HH:mm:ss')
            .parse(b.notificationDatetime!)
            .toIso8601String(),
      ).compareTo(
        DateTime.parse(
          DateFormat('dd/MM/yyyy HH:mm:ss')
              .parse(a.notificationDatetime!)
              .toIso8601String(),
        ),
      ),
    );

    _notifications = notificationList;
    notifyListeners();
    return _notifications;
  }
}
