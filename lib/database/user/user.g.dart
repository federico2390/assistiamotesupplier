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
      userId: fields[0] as String?,
      palaceId: fields[1] as String?,
      palaceName: fields[2] as String?,
      palaceCf: fields[3] as String?,
      palaceAddress: fields[4] as String?,
      userEmail: fields[5] as String?,
      userName: fields[6] as String?,
      userCf: fields[7] as String?,
      userUsername: fields[8] as String?,
      userPassword: fields[9] as String?,
      userToken: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDatabase obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.palaceId)
      ..writeByte(2)
      ..write(obj.palaceName)
      ..writeByte(3)
      ..write(obj.palaceCf)
      ..writeByte(4)
      ..write(obj.palaceAddress)
      ..writeByte(5)
      ..write(obj.userEmail)
      ..writeByte(6)
      ..write(obj.userName)
      ..writeByte(7)
      ..write(obj.userCf)
      ..writeByte(8)
      ..write(obj.userUsername)
      ..writeByte(9)
      ..write(obj.userPassword)
      ..writeByte(10)
      ..write(obj.userToken);
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
