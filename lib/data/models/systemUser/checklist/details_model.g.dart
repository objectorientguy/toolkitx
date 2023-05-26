// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetChecklistDetailsModel _$GetChecklistDetailsModelFromJson(
        Map<String, dynamic> json) =>
    GetChecklistDetailsModel(
      status: json['Status'] as int,
      message: json['Message'] as String?,
      data: (json['Data'] as List<dynamic>)
          .map((e) =>
              GetChecklistDetailsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetChecklistDetailsModelToJson(
        GetChecklistDetailsModel instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Message': instance.message,
      'Data': instance.data,
    };

GetChecklistDetailsData _$GetChecklistDetailsDataFromJson(
        Map<String, dynamic> json) =>
    GetChecklistDetailsData(
      id: json['id'] as String,
      checklistname: json['checklistname'] as String,
      responsecount: json['responsecount'] as int,
      rejectcount: json['rejectcount'] as int,
      totalworkforcecount: json['totalworkforcecount'] as int,
      approvalpendingcount: json['approvalpendingcount'] as int,
      isoverdue: json['isoverdue'] as int,
      dates: json['dates'] as String,
    );

Map<String, dynamic> _$GetChecklistDetailsDataToJson(
        GetChecklistDetailsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'checklistname': instance.checklistname,
      'responsecount': instance.responsecount,
      'rejectcount': instance.rejectcount,
      'totalworkforcecount': instance.totalworkforcecount,
      'approvalpendingcount': instance.approvalpendingcount,
      'isoverdue': instance.isoverdue,
      'dates': instance.dates,
    };
