// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      (nestedReader(json, 'id') as num?)?.toInt(),
      (nestedReader(json, 'projectId') as num?)?.toInt(),
      nestedReader(json, 'projectName') as String?,
      (nestedReader(json, 'staffPositionId') as num?)?.toInt(),
      nestedReader(json, 'staffPositionName') as String?,
      nestedReader(json, 'photoUploadPath') as String?,
      (nestedReader(json, 'departmentId') as num?)?.toInt(),
      nestedReader(json, 'departmentName') as String?,
      (nestedReader(json, 'employeeId') as num?)?.toInt(),
      nestedReader(json, 'employeeFullName') as String?,
      nestedReader(json, 'isAdmin') as bool?,
      nestedReader(json, 'isDirector') as bool?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'staffPositionId': instance.staffPositionId,
      'staffPositionName': instance.staffPositionName,
      'photoUploadPath': instance.photoUploadPath,
      'departmentId': instance.departmentId,
      'departmentName': instance.departmentName,
      'employeeId': instance.employeeId,
      'employeeFullName': instance.employeeFullName,
      'isAdmin': instance.isAdmin,
      'isDirector': instance.isDirector,
    };
