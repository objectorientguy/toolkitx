import 'dart:convert';

FetchIncidentsListModel fetchIncidentsListModelFromJson(String str) =>
    FetchIncidentsListModel.fromJson(json.decode(str));

String fetchIncidentsListModelToJson(FetchIncidentsListModel data) =>
    json.encode(data.toJson());

class FetchIncidentsListModel {
  final int? status;
  final String? message;
  final List<Datum>? data;

  FetchIncidentsListModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchIncidentsListModel.fromJson(Map<String, dynamic> json) =>
      FetchIncidentsListModel(
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
  final String id;
  final String refno;
  final String eventdatetime;
  final String location;
  final String description;
  final String status;

  Datum({
    required this.id,
    required this.refno,
    required this.eventdatetime,
    required this.location,
    required this.description,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        refno: json["refno"],
        eventdatetime: json["eventdatetime"],
        location: json["location"],
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "refno": refno,
        "eventdatetime": eventdatetime,
        "location": location,
        "description": description,
        "status": status,
      };
}
