// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReadingAdapter extends TypeAdapter<Reading> {
  @override
  final int typeId = 3;

  @override
  Reading read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reading(
      id: fields[0] as String?,
      palaceId: fields[1] as String?,
      userId: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Reading obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.palaceId)
      ..writeByte(2)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
