import 'dart:convert';

PostChecklistRejectModel postChecklistApproveModelFromJson(String str) =>
    PostChecklistRejectModel.fromJson(json.decode(str));

String postChecklistApproveModelToJson(PostChecklistRejectModel data) =>
    json.encode(data.toJson());

class PostChecklistRejectModel {
  final int status;
  final String? message;
  final Data data;

  PostChecklistRejectModel({
    required this.status,
    this.message,
    required this.data,
  });

  factory PostChecklistRejectModel.fromJson(Map<String, dynamic> json) =>
      PostChecklistRejectModel(
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
