// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.list.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectListDto _$ProjectListDtoFromJson(Map<String, dynamic> json) =>
    ProjectListDto(
      total: (nestedReader(json, 'total') as num?)?.toInt(),
      list: (nestedReader(json, 'list') as List<dynamic>?)
          ?.map((e) => ProjectDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectListDtoToJson(ProjectListDto instance) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list,
    };
