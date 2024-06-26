class Report {

  int id;
  double rating;
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
    description: json["description"],
    startTime: json["start_time"],
    duration: json["duration"],
    userId: json["user_id"],
    supportId: json["support_id"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "title": title,
    "description": description,
    "start_time": startTime,
    "duration": duration,
    "user_id": userId,
    "support_id": supportId,
  };
}