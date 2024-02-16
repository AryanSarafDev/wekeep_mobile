import 'dart:convert';

class Users {
  String id;
  String username;
  String type;
  double long;
  double lat;
  String email;
  bool isorg;

  Users({
      required this.id,
      required this.username,
      required this.type,
      required this.long,
      required this.lat,
      required this.email,
      required this.isorg,
  });

  factory Users.fromRawJson(String str) => Users.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    username: json["username"],
    type: json["type"],
    long: json["long"]?.toDouble(),
    lat: json["lat"]?.toDouble(),
    email: json["email"],
    isorg: json["isorg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "type": type,
    "long": long,
    "lat": lat,
    "email": email,
    "isorg": isorg,
  };
}
