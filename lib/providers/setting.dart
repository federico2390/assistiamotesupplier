import 'package:adminpanel/api/notification.dart' as notifications;
import 'package:adminpanel/database/notification.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingProvider extends ChangeNotifier {
  NotificationDatabase _notification = NotificationDatabase();
  NotificationDatabase get notification => _notification;

  Future<NotificationDatabase> getNotification() async {
    final box = await Hive.openBox<NotificationDatabase>('notification');
    _notification =
        box.values.isNotEmpty ? box.values.first : NotificationDatabase();
    notifyListeners();
    return _notification;
  }

  updateNotification(BuildContext context, NotificationDatabase enabled) {
    final box = Hive.box<NotificationDatabase>('notification');
    box.putAt(0, enabled);
    notifications.Notification().notification(context, enabled.notification!);
    getNotification();
    notifyListeners();
  }

  Future deleteNotification() async {
    final box = Hive.box<NotificationDatabase>('notification');
    box.deleteFromDisk().then((value) {
      _notification = NotificationDatabase();
      getNotification();
      notifyListeners();
      return _notification;
    });
  }
}
