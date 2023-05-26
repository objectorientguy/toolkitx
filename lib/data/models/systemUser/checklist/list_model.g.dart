// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetChecklistModel _$GetChecklistModelFromJson(Map<String, dynamic> json) =>
    GetChecklistModel(
      status: json['Status'] as int?,
      message: json['Message'] as String?,
      data: (json['Data'] as List<dynamic>?)
          ?.map((e) => GetChecklistData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetChecklistModelToJson(GetChecklistModel instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Message': instance.message,
      'Data': instance.data,
    };

GetChecklistData _$GetChecklistDataFromJson(Map<String, dynamic> json) =>
    GetChecklistData(
      id: json['id'] as String,
      name: json['name'] as String,
      responsecount: json['responsecount'] as int,
      categoryname: json['categoryname'] as String?,
      subcategoryname: json['subcategoryname'] as String?,
      overduecount: json['overduecount'] as int,
      approvalpendingcount: json['approvalpendingcount'] as int,
    );

Map<String, dynamic> _$GetChecklistDataToJson(GetChecklistData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'responsecount': instance.responsecount,
      'categoryname': instance.categoryname,
      'subcategoryname': instance.subcategoryname,
      'overduecount': instance.overduecount,
      'approvalpendingcount': instance.approvalpendingcount,
    };
