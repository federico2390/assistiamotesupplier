import 'package:hive/hive.dart';

part 'general_notification.g.dart';

@HiveType(typeId: 2)
class GeneralNotificationDatabase {
  @HiveField(0)
  bool? generalNotification;

  GeneralNotificationDatabase({
    this.generalNotification,
  });
}
