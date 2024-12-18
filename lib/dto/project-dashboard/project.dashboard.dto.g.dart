// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dashboard.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectDashboardDto _$ProjectDashboardDtoFromJson(Map<String, dynamic> json) =>
    ProjectDashboardDto(
      (nestedReader(json, 'create') as num?)?.toInt(),
      (nestedReader(json, 'process') as num?)?.toInt(),
      (nestedReader(json, 'finish') as num?)?.toInt(),
      (nestedReader(json, 'expired') as num?)?.toInt(),
    );

Map<String, dynamic> _$ProjectDashboardDtoToJson(
        ProjectDashboardDto instance) =>
    <String, dynamic>{
      'create': instance.create,
      'process': instance.process,
      'finish': instance.finish,
      'expired': instance.expired,
    };
