import 'package:adminpanel/providers/notification.dart';
import 'package:adminpanel/providers/operation.dart';
import 'package:adminpanel/providers/setting.dart';
import 'package:adminpanel/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StateProvider extends ChangeNotifier {
  late Future<void> _future;
  Future<void> get future => _future;

  Future<void> buildFuture(BuildContext context) async {
    _future = getFutures(context);
    await _future;
  }

  Future getFutures(BuildContext context) async {
    final operationProvider = context.read<OperationProvider>();
    final settingProvider = context.read<SettingProvider>();
    final userProvider = context.read<UserProvider>();
    final notificationProvider = context.read<NotificationProvider>();

    await userProvider.getLocalUser();
    // await userProvider.getUser();
    await operationProvider.getOperations(context);
    await notificationProvider.getNotifications(context);
    await settingProvider.getSetting(context);
    notifyListeners();
  }
}
