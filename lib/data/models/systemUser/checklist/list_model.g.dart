// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetChecklistModel _$GetChecklistListModelFromJson(Map<String, dynamic> json) =>
    GetChecklistModel(
        status: json["Status"],
        message: json["Message"],
        data: List<GetChecklistData>.from(
            json["Data"].map((x) => GetChecklistData.fromJson(x))));

Map<String, dynamic> _$GetChecklistListModelToJson(
        GetChecklistModel instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Message': instance.message,
      'Data': instance.data,
    };

GetChecklistData _$GetChecklistListDataFromJson(Map<String, dynamic> json) =>
    GetChecklistData(
      id: json['id'],
      name: json['name'],
      responsecount: json['responsecount'],
      categoryname: json['categoryname'],
      subcategoryname: json['subcategoryname'],
      overduecount: json['overduecount'],
      approvalpendingcount: json['approvalpendingcount'],
    );

Map<String, dynamic> _$GetChecklistListDataToJson(GetChecklistData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'responsecount': instance.responsecount,
      'categoryname': instance.categoryname,
      'subcategoryname': instance.subcategoryname,
      'overduecount': instance.overduecount,
      'approvalpendingcount': instance.approvalpendingcount,
    };
