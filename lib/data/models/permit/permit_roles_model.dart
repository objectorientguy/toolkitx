import 'dart:convert';

PermitRolesModel permitRolesModelFromJson(String str) =>
    PermitRolesModel.fromJson(json.decode(str));

String permitRolesModelToJson(PermitRolesModel data) =>
    json.encode(data.toJson());

class PermitRolesModel {
  final int? status;
  final String? message;
  final List<Datum>? data;

  PermitRolesModel({
    this.status,
    this.message,
    this.data,
  });

  factory PermitRolesModel.fromJson(Map<String, dynamic> json) =>
      PermitRolesModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null
            ? []
            : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String? groupId;
  final String? groupName;

  Datum({
    this.groupId,
    this.groupName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        groupId: json["group_id"],
        groupName: json["group_name"],
      );

  Map<String, dynamic> toJson() => {
        "group_id": groupId,
        "group_name": groupName,
      };
}
