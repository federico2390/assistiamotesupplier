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
      userEmail: fields[1] as String?,
      userName: fields[6] as String?,
      userCf: fields[7] as String?,
      userUsername: fields[8] as String?,
      userPassword: fields[9] as String?,
      userToken: fields[10] as String?,
      notification: fields[11] as String?,
      firstTimeLogged: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDatabase obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
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
      ..write(obj.userToken)
      ..writeByte(11)
      ..write(obj.notification)
      ..writeByte(12)
      ..write(obj.firstTimeLogged);
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
