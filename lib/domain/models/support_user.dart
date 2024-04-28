class SupportUser {

  int id;
  String firstName;
  String lastName;
  String email;
  String password;

  SupportUser({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  String get userName => '$firstName $lastName $id';

  factory SupportUser.fromJson(Map<String, dynamic> json) => SupportUser(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password
  };

}