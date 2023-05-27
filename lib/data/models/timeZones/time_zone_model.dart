// To parse this JSON data, do
//
//     final getTimeZoneModel = getTimeZoneModelFromJson(jsonString);

import 'dart:convert';

GetTimeZoneModel getTimeZoneModelFromJson(String str) =>
    GetTimeZoneModel.fromJson(json.decode(str));

String getTimeZoneModelToJson(GetTimeZoneModel data) =>
    json.encode(data.toJson());

class GetTimeZoneModel {
  final int status;
  final String? message;
  final List<Datum>? data;

  GetTimeZoneModel({
    required this.status,
    this.message,
    this.data,
  });

  factory GetTimeZoneModel.fromJson(Map<String, dynamic> json) =>
      GetTimeZoneModel(
        status: json["Status"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String name;
  final String offset;
  final String code;

  Datum({
    required this.name,
    required this.offset,
    required this.code,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        offset: json["offset"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "offset": offset,
        "code": code,
      };
}
