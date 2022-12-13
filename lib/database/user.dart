import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class UserDatabase {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String? palaceId;
  @HiveField(2)
  String? palaceName;
  @HiveField(3)
  String? palaceCf;
  @HiveField(4)
  String? palaceAddress;
  @HiveField(5)
  String? userEmail;
  @HiveField(6)
  String? userName;
  @HiveField(7)
  String? userSurname;
  @HiveField(8)
  String? userCf;
  @HiveField(9)
  String? userUsername;
  @HiveField(10)
  String? userPassword;
  @HiveField(11)
  String? userToken;

  UserDatabase({
    this.userId,
    this.palaceId,
    this.palaceName,
    this.palaceCf,
    this.palaceAddress,
    this.userEmail,
    this.userName,
    this.userSurname,
    this.userCf,
    this.userUsername,
    this.userPassword,
    this.userToken,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': userId,
      'palace_id': palaceId,
      'palace_name': palaceName,
      'palace_cf': palaceCf,
      'palace_Address': palaceAddress,
      'user_email': userEmail,
      'user_name': userName,
      'user_surname': userSurname,
      'user_cf': userCf,
      'user_username': userUsername,
      'user_password': userPassword,
      'user_token': userToken,
    };
  }

  factory UserDatabase.fromJson(Map<String, dynamic> map) {
    return UserDatabase(
      userId: map['user_id'] ?? '',
      palaceId: map['palace_id'] ?? '',
      palaceName: map['palace_name'] ?? '',
      palaceCf: map['palace_cf'] ?? '',
      palaceAddress: map['palace_address'] ?? '',
      userEmail: map['user_email'] ?? '',
      userName: map['user_name'] ?? '',
      userSurname: map['user_surname'] ?? '',
      userCf: map['user_cf'] ?? '',
      userUsername: map['user_username'] ?? '',
      userPassword: map['user_password'] ?? '',
      userToken: map['user_token'] ?? '',
    );
  }
}
