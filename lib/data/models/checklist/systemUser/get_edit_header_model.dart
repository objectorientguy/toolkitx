import 'dart:convert';

GetCheckListEditHeaderModel getCheckListEditHeaderModelFromJson(String str) =>
    GetCheckListEditHeaderModel.fromJson(json.decode(str));

String getCheckListEditHeaderModelToJson(GetCheckListEditHeaderModel data) =>
    json.encode(data.toJson());

class GetCheckListEditHeaderModel {
  final int status;
  final String? message;
  final List<EditHeaderListData>? data;

  GetCheckListEditHeaderModel({
    required this.status,
    this.message,
    this.data,
  });

  factory GetCheckListEditHeaderModel.fromJson(Map<String, dynamic> json) =>
      GetCheckListEditHeaderModel(
        status: json["Status"],
        message: json["Message"],
        data: List<EditHeaderListData>.from(
            json["Data"].map((x) => EditHeaderListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EditHeaderListData {
  final int id;
  final String title;
  final String fieldvalue;
  final int? ismandatory;
  final int? maxlength;
  final String checklistname;

  EditHeaderListData({
    required this.id,
    required this.title,
    required this.fieldvalue,
    this.ismandatory,
    this.maxlength,
    required this.checklistname,
  });

  factory EditHeaderListData.fromJson(Map<String, dynamic> json) =>
      EditHeaderListData(
        id: json["id"],
        title: json["title"],
        fieldvalue: json["fieldvalue"],
        ismandatory: json["ismandatory"],
        maxlength: json["maxlength"],
        checklistname: json["checklistname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "fieldvalue": fieldvalue,
        "ismandatory": ismandatory,
        "maxlength": maxlength,
        "checklistname": checklistname,
      };
}
