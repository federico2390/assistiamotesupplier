import 'package:hive_flutter/hive_flutter.dart';

part 'reading.g.dart';

@HiveType(typeId: 3)
class Reading {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? palaceId;
  @HiveField(2)
  String? userId;

  Reading({
    this.id,
    this.palaceId,
    this.userId,
  });
}
