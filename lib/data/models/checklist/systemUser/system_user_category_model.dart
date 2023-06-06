import 'dart:convert';

GetFilterCategoryModel getFilterCategoryModelFromJson(String str) =>
    GetFilterCategoryModel.fromJson(json.decode(str));

String getFilterCategoryModelToJson(GetFilterCategoryModel data) =>
    json.encode(data.toJson());

class GetFilterCategoryModel {
  final int status;
  final String? message;
  final List<List<GetFilterCategoryData>>? data;

  GetFilterCategoryModel({
    required this.status,
    this.message,
    this.data,
  });

  factory GetFilterCategoryModel.fromJson(Map<String, dynamic> json) =>
      GetFilterCategoryModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<GetFilterCategoryData>>.from(json["Data"].map((x) =>
            List<GetFilterCategoryData>.from(
                x.map((x) => GetFilterCategoryData.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class GetFilterCategoryData {
  final int id;
  final String name;
  final int? active;
  final int? subcategorycount;

  GetFilterCategoryData({
    required this.id,
    required this.name,
    this.active,
    this.subcategorycount,
  });

  factory GetFilterCategoryData.fromJson(Map<String, dynamic> json) =>
      GetFilterCategoryData(
        id: json["id"],
        name: json["name"],
        active: json["active"],
        subcategorycount: json["subcategorycount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
        "subcategorycount": subcategorycount,
      };
}
