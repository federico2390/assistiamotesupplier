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
      supplierPhone: fields[3] as String?,
      supplierType: fields[4] as String?,
      supplierCf: fields[5] as String?,
      supplierCountry: fields[6] as String?,
      supplierRegion: fields[7] as String?,
      supplierProvince: fields[8] as String?,
      supplierCity: fields[9] as String?,
      supplierAddress: fields[10] as String?,
      supplierProfilePicture: fields[11] as String?,
      supplierDeviceToken: fields[12] as String?,
      supplierNotificationPermission: fields[13] as String?,
      supplierIsLogged: fields[14] as String?,
      verified: fields[15] as String?,
      curriculum: fields[16] as String?,
      createdDateTime: fields[17] as String?,
      coverageArea: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDatabase obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.supplierId)
      ..writeByte(1)
      ..write(obj.supplierEmail)
      ..writeByte(2)
      ..write(obj.supplierName)
      ..writeByte(3)
      ..write(obj.supplierPhone)
      ..writeByte(4)
      ..write(obj.supplierType)
      ..writeByte(5)
      ..write(obj.supplierCf)
      ..writeByte(6)
      ..write(obj.supplierCountry)
      ..writeByte(7)
      ..write(obj.supplierRegion)
      ..writeByte(8)
      ..write(obj.supplierProvince)
      ..writeByte(9)
      ..write(obj.supplierCity)
      ..writeByte(10)
      ..write(obj.supplierAddress)
      ..writeByte(11)
      ..write(obj.supplierProfilePicture)
      ..writeByte(12)
      ..write(obj.supplierDeviceToken)
      ..writeByte(13)
      ..write(obj.supplierNotificationPermission)
      ..writeByte(14)
      ..write(obj.supplierIsLogged)
      ..writeByte(15)
      ..write(obj.verified)
      ..writeByte(16)
      ..write(obj.curriculum)
      ..writeByte(17)
      ..write(obj.createdDateTime)
      ..writeByte(18)
      ..write(obj.coverageArea);
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
