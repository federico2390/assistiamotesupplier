// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationDatabaseAdapter extends TypeAdapter<NotificationDatabase> {
  @override
  final int typeId = 1;

  @override
  NotificationDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationDatabase(
      notification: fields[0] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationDatabase obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.notification);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
