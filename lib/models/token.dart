import 'dart:convert';

List<Token> tokenFromJson(String str) =>
    List<Token>.from(json.decode(str).map((x) => Token.fromJson(x)));

String tokenToJson(List<Token> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Token {
  Token({
    this.userToken,
  });

  String? userToken;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        userToken: json["user_token"],
      );

  Map<String, dynamic> toJson() => {
        "user_token": userToken,
      };
}
