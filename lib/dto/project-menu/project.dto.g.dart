// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectDto _$ProjectDtoFromJson(Map<String, dynamic> json) => ProjectDto(
      (nestedReader(json, 'id') as num?)?.toInt(),
      nestedReader(json, 'name') as String?,
      nestedReader(json, 'description') as String?,
      nestedReader(json, 'start') as String?,
      nestedReader(json, 'end') as String?,
      nestedReader(json, 'budget') as String?,
      nestedReader(json, 'status') as String?,
      nestedReader(json, 'isAdmin') as bool?,
      nestedReader(json, 'isDirector') as bool?,
      nestedReader(json, 'isRead') as bool?,
      (nestedReader(json, 'employeeId') as num?)?.toInt(),
      nestedReader(json, 'employeeFullName') as String?,
      nestedReader(json, 'departmentName') as String?,
      nestedReader(json, 'staffPositionName') as String?,
      (nestedReader(json, 'employees') as List<dynamic>?)
          ?.map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
      (nestedReader(json, 'ownerId') as num?)?.toInt(),
      nestedReader(json, 'ownerFirstName') as String?,
      nestedReader(json, 'ownerLastName') as String?,
      nestedReader(json, 'ownerParentName') as String?,
      (nestedReader(json, 'parentId') as num?)?.toInt(),
      nestedReader(json, 'parentName') as String?,
      nestedReader(json, 'parentDescription') as String?,
      (nestedReader(json, 'projectTypeId') as num?)?.toInt(),
      nestedReader(json, 'projectTypeName') as String?,
      (nestedReader(json, 'featureId') as num?)?.toInt(),
      nestedReader(json, 'featureName') as String?,
      (nestedReader(json, 'child') as List<dynamic>?)
          ?.map((e) => ProjectDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectDtoToJson(ProjectDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'start': instance.start,
      'end': instance.end,
      'budget': instance.budget,
      'status': instance.status,
      'isAdmin': instance.isAdmin,
      'isDirector': instance.isDirector,
      'isRead': instance.isRead,
      'employeeId': instance.employeeId,
      'employeeFullName': instance.employeeFullName,
      'departmentName': instance.departmentName,
      'staffPositionName': instance.staffPositionName,
      'employees': instance.employees,
      'ownerId': instance.ownerId,
      'ownerFirstName': instance.ownerFirstName,
      'ownerLastName': instance.ownerLastName,
      'ownerParentName': instance.ownerParentName,
      'parentId': instance.parentId,
      'parentName': instance.parentName,
      'parentDescription': instance.parentDescription,
      'projectTypeId': instance.projectTypeId,
      'projectTypeName': instance.projectTypeName,
      'featureId': instance.featureId,
      'featureName': instance.featureName,
      'child': instance.child,
    };
