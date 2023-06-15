import 'dart:convert';

SaveThirdPartyApproval saveThirdPartyApprovalFromJson(String str) =>
    SaveThirdPartyApproval.fromJson(json.decode(str));

String saveThirdPartyApprovalToJson(SaveThirdPartyApproval data) =>
    json.encode(data.toJson());

class SaveThirdPartyApproval {
  final int status;
  final String? message;
  final Data? data;

  SaveThirdPartyApproval({
    required this.status,
    this.message,
    this.data,
  });

  factory SaveThirdPartyApproval.fromJson(Map<String, dynamic> json) =>
      SaveThirdPartyApproval(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data!.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
