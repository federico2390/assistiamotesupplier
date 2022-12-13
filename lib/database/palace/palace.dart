import 'package:hive_flutter/hive_flutter.dart';

part 'palace.g.dart';

@HiveType(typeId: 2)
class Palace {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? cf;
  @HiveField(3)
  String? address;

  Palace({
    this.id,
    this.name,
    this.cf,
    this.address,
  });
}
