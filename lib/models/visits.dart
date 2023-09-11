class Visits {
  String? name;
  DateTime? time;
  double? price;
  String? signedUrl;
  DateTime? signedDateTime;

  Visits({
    this.name,
    this.time,
    this.price,
    this.signedUrl,
    this.signedDateTime,
  });

  Map<String, dynamic> toJson() => {
        "name": name ?? '',
        "time": time ?? '',
        "price": price ?? '',
        "signedUrl": signedUrl ?? '',
        "signedDateTime": signedDateTime ?? '',
      };
}
