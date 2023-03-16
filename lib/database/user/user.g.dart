// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDatabaseAdapter extends TypeAdapter<UserDatabase> {
  @override
  final int typeId = 0;

  @override
  UserDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDatabase(
      supplierId: fields[0] as String?,
      supplierEmail: fields[1] as String?,
      supplierName: fields[2] as String?,
      supplierType: fields[3] as String?,
      supplierCf: fields[4] as String?,
      supplierToken: fields[5] as String?,
      notification: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDatabase obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.supplierId)
      ..writeByte(1)
      ..write(obj.supplierEmail)
      ..writeByte(2)
      ..write(obj.supplierName)
      ..writeByte(3)
      ..write(obj.supplierType)
      ..writeByte(4)
      ..write(obj.supplierCf)
      ..writeByte(5)
      ..write(obj.supplierToken)
      ..writeByte(6)
      ..write(obj.notification);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
