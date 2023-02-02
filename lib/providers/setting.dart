import 'package:adminpanel/api/setting.dart';
import 'package:adminpanel/configs/const.dart';
import 'package:adminpanel/database/notification/general_notification.dart';
import 'package:adminpanel/database/notification/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  updateNotification(BuildContext context, NotificationDatabase enabled) async {
    final box = Hive.box<NotificationDatabase>('notification');
    box.putAll({'notification': enabled});
    await SettingApi.notificationSwitch(context, enabled.notification!);
    await getNotification();
    notifyListeners();
  }

  Future deleteNotification() async {
    final box = Hive.box<NotificationDatabase>('notification');
    await box.deleteFromDisk().then((value) {
      _notification = NotificationDatabase();
      getGeneralNotification();
      notifyListeners();
      return _notification;
    });
  }

  GeneralNotificationDatabase _generalNotification =
      GeneralNotificationDatabase();
  GeneralNotificationDatabase get generalNotification => _generalNotification;

  Future<GeneralNotificationDatabase> getGeneralNotification() async {
    final box =
        await Hive.openBox<GeneralNotificationDatabase>('general_notification');
    _generalNotification = box.values.isNotEmpty
        ? box.values.first
        : GeneralNotificationDatabase();
    notifyListeners();
    return _generalNotification;
  }

  updateGeneralNotification(
      BuildContext context, GeneralNotificationDatabase enabled) async {
    final box = Hive.box<GeneralNotificationDatabase>('general_notification');
    box.putAll({'general_notification': enabled});
    await SettingApi.generalNotificationSwitch(
        context, enabled.generalNotification!);
    if (enabled.generalNotification == false) {
      await FirebaseMessaging.instance
          .unsubscribeFromTopic(AppConst.firebaseTopic);
    } else {
      await FirebaseMessaging.instance.subscribeToTopic(AppConst.firebaseTopic);
    }
    await getGeneralNotification();
    notifyListeners();
  }

  Future deleteGeneralNotification() async {
    final box = Hive.box<GeneralNotificationDatabase>('general_notification');
    await box.deleteFromDisk().then((value) {
      _generalNotification = GeneralNotificationDatabase();
      getGeneralNotification();
      notifyListeners();
      return _generalNotification;
    });
  }
}
