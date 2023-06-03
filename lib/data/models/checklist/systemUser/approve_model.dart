import 'dart:convert';

PostChecklistApproveModel postChecklistApproveModelFromJson(String str) =>
    PostChecklistApproveModel.fromJson(json.decode(str));

String postChecklistApproveModelToJson(PostChecklistApproveModel data) =>
    json.encode(data.toJson());

class PostChecklistApproveModel {
  final int status;
  final String? message;
  final Data data;

  PostChecklistApproveModel({
    required this.status,
    this.message,
    required this.data,
  });

  factory PostChecklistApproveModel.fromJson(Map<String, dynamic> json) =>
      PostChecklistApproveModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
