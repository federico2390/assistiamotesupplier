class User {
  String? userId,
      palaceId,
      palaceName,
      palaceCf,
      palaceAddress,
      userEmail,
      userName,
      userSurname,
      userCf,
      userUsername,
      userPassword,
      userToken;

  User({
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] ?? '',
      palaceId: json['palace_id'] ?? '',
      palaceName: json['palace_name'] ?? '',
      palaceCf: json['palace_cf'] ?? '',
      palaceAddress: json['palace_address'] ?? '',
      userEmail: json['user_email'] ?? '',
      userName: json['user_name'] ?? '',
      userSurname: json['user_surname'] ?? '',
      userCf: json['user_cf'] ?? '',
      userUsername: json['user_username'] ?? '',
      userPassword: json['user_password'] ?? '',
      userToken: json['user_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId ?? '',
      "palace_id": palaceId ?? '',
      "palace_name": palaceName ?? '',
      "palace_cf": palaceCf ?? '',
      "palace_address": palaceAddress ?? '',
      "user_email": userEmail ?? '',
      "user_name": userName ?? '',
      "user_surname": userSurname ?? '',
      "user_username": userUsername ?? '',
      "user_cf": userCf ?? '',
      "user_password": userPassword ?? '',
      "user_token": userToken ?? '',
    };
  }
}
