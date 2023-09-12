class Visits {
  String? name;
  DateTime? time;
  String? signedUrl;
  DateTime? signedDateTime;

  Visits({
    this.name,
    this.time,
    this.signedUrl,
    this.signedDateTime,
  });

  Map<String, dynamic> toJson() => {
        "name": name ?? '',
        "time": time ?? '',
        "signedUrl": signedUrl ?? '',
        "signedDateTime": signedDateTime ?? '',
      };
}
