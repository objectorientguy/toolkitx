import 'dart:convert';

LanguageModel multilingualModelFromJson(String str) =>
    LanguageModel.fromJson(json.decode(str));

String multilingualModelToJson(LanguageModel data) =>
    json.encode(data.toJson());

class LanguageModel {
  LanguageModel({
    this.status,
    this.data,
    this.message,
  });

  final int? status;
  final List<MultilngualData>? data;
  final String? message;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        status: json["Status"],
        data: json["Data"] == null
            ? null
            : List<MultilngualData>.from(
                json["Data"].map((x) => MultilngualData.fromJson(x))),
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "Message": message,
      };
}

class MultilngualData {
  MultilngualData({
    required this.id,
    this.flagName,
    required this.langName,
    this.active,
  });

  final int id;
  final String? flagName;
  final String langName;
  final int? active;

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
