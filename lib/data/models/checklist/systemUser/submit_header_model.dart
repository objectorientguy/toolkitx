import 'dart:convert';

PostChecklistSubmitHeaderModel postChecklistApproveModelFromJson(String str) =>
    PostChecklistSubmitHeaderModel.fromJson(json.decode(str));

String postChecklistApproveModelToJson(PostChecklistSubmitHeaderModel data) =>
    json.encode(data.toJson());

class PostChecklistSubmitHeaderModel {
  final int status;
  final String? message;
  final Data data;

  PostChecklistSubmitHeaderModel({
    required this.status,
    this.message,
    required this.data,
  });

  factory PostChecklistSubmitHeaderModel.fromJson(Map<String, dynamic> json) =>
      PostChecklistSubmitHeaderModel(
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
