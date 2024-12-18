// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.income.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskIncomeDto _$TaskIncomeDtoFromJson(Map<String, dynamic> json) =>
    TaskIncomeDto(
      (nestedReader(json, 'id') as num?)?.toInt(),
      nestedReader(json, 'title') as String?,
      nestedReader(json, 'beginDate') as String?,
      nestedReader(json, 'endDate') as String?,
      (nestedReader(json, 'directorId') as num?)?.toInt(),
      nestedReader(json, 'employeeFullName') as String?,
      nestedReader(json, 'directorFullName') as String?,
      nestedReader(json, 'employeeUploadPath') as String?,
      nestedReader(json, 'directorUploadPath') as String?,
      (nestedReader(json, 'employeeId') as num?)?.toInt(),
      (nestedReader(json, 'departmentId') as num?)?.toInt(),
      nestedReader(json, 'departmentName') as String?,
      (nestedReader(json, 'staffPositionId') as num?)?.toInt(),
      nestedReader(json, 'staffPositionName') as String?,
      (nestedReader(json, 'directorDepartmentId') as num?)?.toInt(),
      nestedReader(json, 'directorDepartmentName') as String?,
      (nestedReader(json, 'directorStaffPositionId') as num?)?.toInt(),
      nestedReader(json, 'directorStaffPositionName') as String?,
      nestedReader(json, 'taskStatus') as String?,
      nestedReader(json, 'important') as String?,
      (nestedReader(json, 'receivers') as List<dynamic>?)
          ?.map((e) => Receiver.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskIncomeDtoToJson(TaskIncomeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'beginDate': instance.beginDate,
      'endDate': instance.endDate,
      'directorId': instance.directorId,
      'employeeFullName': instance.employeeFullName,
      'directorFullName': instance.directorFullName,
      'employeeUploadPath': instance.employeeUploadPath,
      'directorUploadPath': instance.directorUploadPath,
      'employeeId': instance.employeeId,
      'departmentId': instance.departmentId,
      'departmentName': instance.departmentName,
      'staffPositionId': instance.staffPositionId,
      'staffPositionName': instance.staffPositionName,
      'directorDepartmentId': instance.directorDepartmentId,
      'directorDepartmentName': instance.directorDepartmentName,
      'directorStaffPositionId': instance.directorStaffPositionId,
      'directorStaffPositionName': instance.directorStaffPositionName,
      'taskStatus': instance.taskStatus,
      'important': instance.important,
      'receivers': instance.receivers,
    };
