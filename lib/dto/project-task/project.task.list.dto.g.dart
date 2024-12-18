// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.task.list.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectTaskListDto<T> _$ProjectTaskListDtoFromJson<T>(
        Map<String, dynamic> json) =>
    ProjectTaskListDto<T>(
      total: (nestedReader(json, 'total') as num?)?.toInt(),
      list: (nestedReader(json, 'list') as List<dynamic>?)
          ?.map((e) => ProjectTaskDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectTaskListDtoToJson<T>(
        ProjectTaskListDto<T> instance) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list,
    };

Map<String, dynamic> _$IncomeDocumentsBodyToJson(
        IncomeDocumentsBody instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
    };
