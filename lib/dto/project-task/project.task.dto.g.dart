// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.task.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectTaskDto _$ProjectTaskDtoFromJson(Map<String, dynamic> json) =>
    ProjectTaskDto(
      (nestedReader(json, 'id') as num?)?.toInt(),
      nestedReader(json, 'name') as String?,
      nestedReader(json, 'color') as String?,
      (nestedReader(json, 'projectId') as num?)?.toInt(),
      nestedReader(json, 'projectName') as String?,
      (nestedReader(json, 'parentId') as num?)?.toInt(),
      nestedReader(json, 'parentName') as String?,
      nestedReader(json, 'parentColor') as String?,
      (nestedReader(json, 'cardId') as num?)?.toInt(),
      nestedReader(json, 'endDate') as String?,
      nestedReader(json, 'endDateTime') as String?,
      nestedReader(json, 'cardName') as String?,
      nestedReader(json, 'cardColor') as String?,
      nestedReader(json, 'fileName') as String?,
      nestedReader(json, 'fileExtension') as String?,
      nestedReader(json, 'uploadPath') as String?,
      (nestedReader(json, 'cardParentId') as num?)?.toInt(),
      nestedReader(json, 'cardParentName') as String?,
      (nestedReader(json, 'ownerId') as num?)?.toInt(),
      nestedReader(json, 'ownerFullName') as String?,
    );

Map<String, dynamic> _$ProjectTaskDtoToJson(ProjectTaskDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'parentId': instance.parentId,
      'parentName': instance.parentName,
      'parentColor': instance.parentColor,
      'cardId': instance.cardId,
      'endDate': instance.endDate,
      'endDateTime': instance.endDateTime,
      'cardName': instance.cardName,
      'cardColor': instance.cardColor,
      'fileName': instance.fileName,
      'fileExtension': instance.fileExtension,
      'uploadPath': instance.uploadPath,
      'cardParentId': instance.cardParentId,
      'cardParentName': instance.cardParentName,
      'ownerId': instance.ownerId,
      'ownerFullName': instance.ownerFullName,
    };
