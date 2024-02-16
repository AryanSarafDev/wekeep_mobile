import 'dart:convert';

import 'package:flutter/material.dart';

class Warranty {
  String useruid;
  String modelno;
  String orguid;
  String startdate;
  int daysremaining;
  bool pending;
  String image;

  Warranty(
      {required this.useruid,
      required this.modelno,
      required this.orguid,
      required this.startdate,
      required this.daysremaining,
      required this.pending,
      required this.image});

  factory Warranty.fromRawJson(String str) =>
      Warranty.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Warranty.fromJson(Map<String, dynamic> json) => Warranty(
        useruid: json["useruid"],
        modelno: json["modelno"],
        orguid: json["orguid"],
        startdate: json["startdate"],
        daysremaining: json["daysremaining"],
        pending: json["pending"],
        image: json["imageurl"],
      );

  Map<String, dynamic> toJson() => {
        "useruid": useruid,
        "modelno": modelno,
        "orguid": orguid,
        "startdate": startdate,
        "daysremaining": daysremaining,
        "pending": pending,
        "imageurl":image
      };
}
