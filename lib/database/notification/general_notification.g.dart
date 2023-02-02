// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeneralNotificationDatabaseAdapter
    extends TypeAdapter<GeneralNotificationDatabase> {
  @override
  final int typeId = 2;

  @override
  GeneralNotificationDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneralNotificationDatabase(
      generalNotification: fields[0] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, GeneralNotificationDatabase obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.generalNotification);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneralNotificationDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
