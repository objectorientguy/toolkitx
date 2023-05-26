import 'package:json_annotation/json_annotation.dart';

part 'details_model.g.dart';

@JsonSerializable()
class GetChecklistDetailsModel {
  final int status;
  final String? message;
  final List<GetChecklistDetailsData> data;

  GetChecklistDetailsModel({
    required this.status,
    this.message,
    required this.data,
  });

  factory GetChecklistDetailsModel.fromJson(Map<String, dynamic> details) =>
      _$GetChecklistDetailsModelFromJson(details);

  Map<String, dynamic> toJson() => _$GetChecklistDetailsModelToJson(this);
}

@JsonSerializable()
class GetChecklistDetailsData {
  final String id;
  final String checklistname;
  final int responsecount;
  final int rejectcount;
  final int totalworkforcecount;
  final int approvalpendingcount;
  final int isoverdue;
  final String dates;

  GetChecklistDetailsData({
    required this.id,
    required this.checklistname,
    required this.responsecount,
    required this.rejectcount,
    required this.totalworkforcecount,
    required this.approvalpendingcount,
    required this.isoverdue,
    required this.dates,
  });

  factory GetChecklistDetailsData.fromJson(Map<String, dynamic> detailsData) =>
      _$GetChecklistDetailsDataFromJson(detailsData);

  Map<String, dynamic> toJson() => _$GetChecklistDetailsDataToJson(this);
}
