import 'dart:convert';

GetCheckListRolesModel getChecklistRolesModelFromJson(String str) =>
    GetCheckListRolesModel.fromJson(json.decode(str));

String getChecklistRolesModelToJson(GetCheckListRolesModel data) =>
    json.encode(data.toJson());

class GetCheckListRolesModel {
  final int status;
  final String? message;
  final List<GetCheckListChangeRoleData>? data;

  GetCheckListRolesModel({
    required this.status,
    this.message,
    this.data,
  });

  factory GetCheckListRolesModel.fromJson(Map<String, dynamic> json) =>
      GetCheckListRolesModel(
        status: json["Status"],
        message: json["Message"],
        data: List<GetCheckListChangeRoleData>.from(
            json["Data"].map((x) => GetCheckListChangeRoleData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetCheckListChangeRoleData {
  final String groupId;
  final String groupName;

  GetCheckListChangeRoleData({
    required this.groupId,
    required this.groupName,
  });

  factory GetCheckListChangeRoleData.fromJson(Map<String, dynamic> json) =>
      GetCheckListChangeRoleData(
        groupId: json["group_id"],
        groupName: json["group_name"],
      );

  Map<String, dynamic> toJson() => {
        "group_id": groupId,
        "group_name": groupName,
      };
}
