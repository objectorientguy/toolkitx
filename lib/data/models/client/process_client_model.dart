// To parse this JSON data, do
//
//     final processClientModel = processClientModelFromJson(jsonString);

import 'dart:convert';

HomeScreenModel processClientModelFromJson(String str) =>
    HomeScreenModel.fromJson(json.decode(str));

String processClientModelToJson(HomeScreenModel data) =>
    json.encode(data.toJson());

class HomeScreenModel {
  final int? status;
  final String? message;
  final Data? data;

  HomeScreenModel({this.status, this.message, this.data});

  factory HomeScreenModel.fromJson(Map<String, dynamic> json) =>
      HomeScreenModel(
          status: json["Status"],
          message: json["Message"],
          data: Data.fromJson(json["Data"]));

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data!.toJson()};
}

class Data {
  final String userid;
  final String userid2;
  final String? permission;
  final String? alerts;
  final String? datetimecode;
  final String? tracklocation;
  final String? timezoneoffset;
  final List<dynamic>? badges;

  Data(
      {required this.userid,
      required this.userid2,
      this.permission,
      this.alerts,
      this.datetimecode,
      this.tracklocation,
      this.timezoneoffset,
      this.badges});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      userid: json["userid"],
      userid2: json["userid2"],
      permission: json["permission"],
      alerts: json["alerts"],
      datetimecode: json["datetimecode"],
      tracklocation: json["tracklocation"],
      timezoneoffset: json["timezoneoffset"],
      badges: List<dynamic>.from(json["badges"].map((x) => x)));

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "userid2": userid2,
        "permission": permission,
        "alerts": alerts,
        "datetimecode": datetimecode,
        "tracklocation": tracklocation,
        "timezoneoffset": timezoneoffset,
        "badges": List<dynamic>.from(badges!.map((x) => x))
      };
}
