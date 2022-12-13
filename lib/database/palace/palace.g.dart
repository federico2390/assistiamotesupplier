// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'palace.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PalaceAdapter extends TypeAdapter<Palace> {
  @override
  final int typeId = 2;

  @override
  Palace read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Palace(
      id: fields[0] as String?,
      name: fields[1] as String?,
      cf: fields[2] as String?,
      address: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Palace obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.cf)
      ..writeByte(3)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PalaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
