import 'package:json_annotation/json_annotation.dart';

part 'list_model.g.dart';

@JsonSerializable()
class GetChecklistModel {
  final int? status;
  final String? message;
  final List<GetChecklistData>? data;

  GetChecklistModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetChecklistModel.fromJson(Map<String, dynamic> json) =>
      _$GetChecklistListModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetChecklistListModelToJson(this);
}

@JsonSerializable()
class GetChecklistData {
  final String id;
  final String name;
  final int responsecount;
  final String? categoryname;
  final String? subcategoryname;
  final int overduecount;
  final int approvalpendingcount;

  GetChecklistData({
    required this.id,
    required this.name,
    required this.responsecount,
    this.categoryname,
    this.subcategoryname,
    required this.overduecount,
    required this.approvalpendingcount,
  });

  factory GetChecklistData.fromJson(Map<String, dynamic> json) =>
      _$GetChecklistListDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetChecklistListDataToJson(this);
}
