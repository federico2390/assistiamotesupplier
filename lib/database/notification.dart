import 'package:hive/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 1)
class NotificationDatabase {
  @HiveField(0)
  final bool? notification;

  NotificationDatabase({
    this.notification,
  });
}
