// To parse this JSON data, do
//
//     final getLanguagesModel = getLanguagesModelFromJson(jsonString);

import 'dart:convert';

GetLanguagesModel getLanguagesModelFromJson(String str) =>
    GetLanguagesModel.fromJson(json.decode(str));

String getLanguagesModelToJson(GetLanguagesModel data) =>
    json.encode(data.toJson());

class GetLanguagesModel {
  final int status;
  final String? message;
  final List<GetLanguagesData>? data;

  GetLanguagesModel({
    required this.status,
    this.message,
    this.data,
  });

  factory GetLanguagesModel.fromJson(Map<String, dynamic> json) =>
      GetLanguagesModel(
        status: json["Status"],
        message: json["Message"],
        data: List<GetLanguagesData>.from(
            json["Data"].map((x) => GetLanguagesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetLanguagesData {
  final int id;
  final String flagName;
  final String langName;
  final int active;

  GetLanguagesData({
    required this.id,
    required this.flagName,
    required this.langName,
    required this.active,
  });

  factory GetLanguagesData.fromJson(Map<String, dynamic> json) =>
      GetLanguagesData(
        id: json["id"],
        flagName: json["flag_name"],
        langName: json["lang_name"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "flag_name": flagName,
        "lang_name": langName,
        "active": active,
      };
}
