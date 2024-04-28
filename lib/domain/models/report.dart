class Report {

  int id;
  int rating;
  String title;
  String description;
  int startTime;
  int duration;
  int userId;
  int supportId;

  Report({
    this.id = 0,
    this.rating = -1,
    required this.title,
    required this.description,
    required this.startTime,
    required this.duration,
    required this.userId,
    required this.supportId,
  });

  String get reportTitle => title;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    id: json["id"],
    rating: json["rating"],
    title: json["title"],
    description: json["email"],
    startTime: json["start_time"],
    duration: json["duration"],
    userId: json["user_id"],
    supportId: json["support_id"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "title": title,
    "email": description,
    "start_time": startTime,
    "duration": duration,
    "user_id": userId,
    "support_id": supportId,
  };

}