import 'dart:convert';

DownloadLanguageModel downloadLanguageModelFromJson(String str) =>
    DownloadLanguageModel.fromJson(json.decode(str));

String downloadLanguageModelToJson(DownloadLanguageModel data) =>
    json.encode(data.toJson());

class DownloadLanguageModel {
  final int status;
  final String message;
  final Data data;

  DownloadLanguageModel(
      {required this.status, required this.message, required this.data});

  factory DownloadLanguageModel.fromJson(Map<String, dynamic> json) =>
      DownloadLanguageModel(
          status: json["Status"],
          message: json["Message"],
          data: Data.fromJson(json["Data"]));

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data.toJson()};
}

class Data {
  final String download;

  Data({required this.download});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(download: json["download"]);

  Map<String, dynamic> toJson() => {"download": download};
}
