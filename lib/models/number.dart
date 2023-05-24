import 'dart:convert';

List<Number> numberFromJson(String str) =>
    List<Number>.from(json.decode(str).map((x) => Number.fromJson(x)));

String numberToJson(List<Number> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Number {
  Number({
    this.userNumber,
  });

  String? userNumber;

  factory Number.fromJson(Map<String, dynamic> json) => Number(
        userNumber: json["user_number"],
      );

  Map<String, dynamic> toJson() => {
        "user_number": userNumber,
      };
}
