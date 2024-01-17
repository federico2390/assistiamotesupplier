import 'package:adminpanel/configs/const.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:adminpanel/api/setting.dart';
import 'package:adminpanel/models/setting.dart';
import 'package:adminpanel/utils/modal_popup.dart';

class SettingProvider extends ChangeNotifier {
  Setting _setting = Setting();
  Setting get setting => _setting;

  Future<Setting> getSetting() async {
    Setting getSetting = await SettingApi().getSettings();
    _setting = getSetting;

    notifyListeners();
    return _setting;
  }

  NotificationSetting _notificationSetting = NotificationSetting();
  NotificationSetting get notificationSetting => _notificationSetting;

  Future<NotificationSetting> getNotificationSetting(
      BuildContext context) async {
    NotificationSetting getNotificationSetting =
        await SettingApi().getNotificationSetting(context);
    _notificationSetting = getNotificationSetting;
    notifyListeners();
    return _notificationSetting;
  }

  updateNotification(BuildContext context, bool enabled) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('User granted OS permission');
      await SettingApi().editNotificationSetting(context, enabled);
      if (enabled == true) {
        debugPrint('User subscribed to push notifications');
        setNotificationStatus(true);
      } else {
        debugPrint('User unsubscribed from push notifications');
        setNotificationStatus(false);
      }
    } else {
      debugPrint('User declined or hat not accepted permission');
      buildModalPopup(
        context,
        'Attenzione',
        'Per ricevere tutte le comunicazioni che riguardano te e il tuo condominio vai in impostazioni e attiva la ricezione delle notifiche.',
        'Impostazioni',
      );
    }

    notifyListeners();
  }

  void setNotificationStatus(bool status) {
    _notificationSetting.notification = status == true ? 'true' : 'false';
    setPush(status);
    notifyListeners();
  }

  void setPush(bool status) async {
    if (status == true) {
      await FirebaseMessaging.instance.subscribeToTopic(AppConst.firebaseTopic);
      debugPrint('User subscribed to topic');
    } else {
      await FirebaseMessaging.instance
          .unsubscribeFromTopic(AppConst.firebaseTopic);
      debugPrint('User unsubscribed from topic');
    }
  }
}
