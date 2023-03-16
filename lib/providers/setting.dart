import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:adminpanel/api/setting.dart';
import 'package:adminpanel/models/setting.dart';
import 'package:adminpanel/utils/modal_popup.dart';

class SettingProvider extends ChangeNotifier {
  Setting _setting = Setting();
  Setting get setting => _setting;

  Future<Setting> getSetting(BuildContext context) async {
    Setting getNotificationSetting =
        await SettingApi().getNotificationSetting(context);
    _setting = getNotificationSetting;
    notifyListeners();
    return _setting;
  }

  updateNotification(BuildContext context, bool enabled) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted OS permission');
      await SettingApi().editNotificationSetting(context, enabled);
      if (enabled == true) {
        print('User subscribed to push notifications');
        setNotificationStatus(true);
      } else {
        print('User unsubscribed from push notifications');
        setNotificationStatus(false);
      }
    } else {
      print('User declined or hat not accepted permission');
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
    _setting.notification = status == true ? 'true' : 'false';
    notifyListeners();
  }
}
