class Reading {
  String? id, palaceId, userId;

  Reading({
    this.id,
    this.palaceId,
    this.userId,
  });

  factory Reading.fromJson(Map<String, dynamic> json) {
    return Reading(
      id: json['reading_id'] ?? '',
      palaceId: json['palace_id'] ?? '',
      userId: json['user_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "reading_id": id ?? '',
      "palace_id": palaceId ?? '',
      "user_id": userId ?? '',
    };
  }
}
