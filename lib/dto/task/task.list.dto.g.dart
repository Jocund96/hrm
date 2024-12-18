// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.list.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskListDto _$TaskListDtoFromJson(Map<String, dynamic> json) => TaskListDto(
      (nestedReader(json, 'total') as num?)?.toInt(),
      (nestedReader(json, 'list') as List<dynamic>?)
          ?.map((e) => TaskIncomeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskListDtoToJson(TaskListDto instance) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list,
    };
