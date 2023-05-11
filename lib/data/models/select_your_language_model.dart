import 'dart:convert';

LanguageModel languageModelFromJson(String str) =>
    LanguageModel.fromJson(json.decode(str));

String languageModelToJson(LanguageModel data) => json.encode(data.toJson());

class LanguageModel {
  final int? status;
  final List<MultilngualData>? data;
  final String? message;

  LanguageModel({
    this.status,
    this.data,
    this.message,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        status: json["Status"],
        data: List<MultilngualData>.from(
            json["Data"].map((x) => MultilngualData.fromJson(x))),
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "Message": message,
      };
}

class MultilngualData {
  final int id;
  final String? flagName;
  final String langName;
  final int active;

  MultilngualData({
    required this.id,
    this.flagName,
    required this.langName,
    required this.active,
  });

  factory MultilngualData.fromJson(Map<String, dynamic> json) =>
      MultilngualData(
        id: json["id"],
        flagName: json["flag_name"],
        langName: json["lang_name"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "flag_name": flagName,
        "lang_name": langName,
        "active": active,
      };
}
