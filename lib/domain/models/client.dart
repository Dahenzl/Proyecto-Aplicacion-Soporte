class Client {

  int id;
  String firstName;
  String lastName;
  String email;

  Client({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  String get client => '$firstName $lastName $id';

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
  };

}
