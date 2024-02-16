import 'dart:convert';

class Services {
  String uid;
  String name;
  String details;
  double lat;
  double long;
  int price;
  String upi;

  Services({
    required this.uid,
    required this.name,
    required this.details,
    required this.lat,
    required this.long,
    required this.price,
    required this.upi,
  });

  factory Services.fromRawJson(String str) => Services.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Services.fromJson(Map<String, dynamic> json) => Services(
    uid: json["uid"],
    name: json["name"],
    details: json["details"],
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
    price: json["price"],
    upi: json["upi"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "name": name,
    "details": details,
    "lat": lat,
    "long": long,
    "price": price,
    "upi": upi,
  };
}
