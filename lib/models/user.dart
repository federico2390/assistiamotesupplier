class User {
  String? id, email, username, name, surname, cf, password, token;

  User({
    this.id,
    this.email,
    this.username,
    this.name,
    this.surname,
    this.cf,
    this.password,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
      cf: json['cf'] ?? '',
      password: json['password'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? '',
      "email": email ?? '',
      "username": username ?? '',
      "name": name ?? '',
      "surname": surname ?? '',
      "password": password ?? '',
      "token": token ?? '',
    };
  }
}
