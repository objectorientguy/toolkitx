import 'dart:convert';

GenerateOtpLoginModel generateOtpLoginModelFromJson(String str) =>
    GenerateOtpLoginModel.fromJson(json.decode(str));

String generateOtpLoginModelToJson(GenerateOtpLoginModel data) =>
    json.encode(data.toJson());

class GenerateOtpLoginModel {
  final int status;
  final String message;
  final Data data;

  GenerateOtpLoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GenerateOtpLoginModel.fromJson(Map<String, dynamic> json) =>
      GenerateOtpLoginModel(
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
