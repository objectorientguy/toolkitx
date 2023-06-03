import 'dart:convert';

GetChecklistModel getChecklistModelFromJson(String str) =>
    GetChecklistModel.fromJson(json.decode(str));

String getChecklistModelToJson(GetChecklistModel data) =>
    json.encode(data.toJson());

class GetChecklistModel {
  final int? status;
  final String? message;
  final List<GetChecklistData>? data;

  GetChecklistModel({
    required this.status,
    this.message,
    this.data,
  });

  factory GetChecklistModel.fromJson(Map<String, dynamic> json) =>
      GetChecklistModel(
        status: json["Status"],
        message: json["Message"],
        data: List<GetChecklistData>.from(
            json["Data"].map((x) => GetChecklistData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetChecklistData {
  final String id;
  final String name;
  final int? responsecount;
  final String? categoryname;
  final String? subcategoryname;
  final int? overduecount;
  final int approvalpendingcount;

  GetChecklistData({
    required this.id,
    required this.name,
    required this.responsecount,
    this.categoryname,
    this.subcategoryname,
    this.overduecount,
    required this.approvalpendingcount,
  });

  factory GetChecklistData.fromJson(Map<String, dynamic> json) =>
      GetChecklistData(
        id: json["id"],
        name: json["name"],
        responsecount: json["responsecount"],
        categoryname: json["categoryname"],
        subcategoryname: json["subcategoryname"],
        overduecount: json["overduecount"],
        approvalpendingcount: json["approvalpendingcount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "responsecount": responsecount,
        "categoryname": categoryname,
        "subcategoryname": subcategoryname,
        "overduecount": overduecount,
        "approvalpendingcount": approvalpendingcount,
      };
}
