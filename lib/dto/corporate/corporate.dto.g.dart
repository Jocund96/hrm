// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorporateDto _$CorporateDtoFromJson(Map<String, dynamic> json) => CorporateDto(
      (nestedReader(json, 'departmentId') as num?)?.toInt(),
      nestedReader(json, 'departmentName') as String?,
      nestedReader(json, 'employeeFullName') as String?,
      nestedReader(json, 'innerPhoneNumber') as String?,
      nestedReader(json, 'mobilePhoneNumber') as String?,
      nestedReader(json, 'photoUploadPath') as String?,
      nestedReader(json, 'genderName') as String?,
      nestedReader(json, 'yurDepName') as String?,
      nestedReader(json, 'positionName') as String?,
    );

Map<String, dynamic> _$CorporateDtoToJson(CorporateDto instance) =>
    <String, dynamic>{
      'departmentId': instance.departmentId,
      'departmentName': instance.departmentName,
      'employeeFullName': instance.employeeFullName,
      'innerPhoneNumber': instance.innerPhoneNumber,
      'mobilePhoneNumber': instance.mobilePhoneNumber,
      'photoUploadPath': instance.photoUploadPath,
      'genderName': instance.genderName,
      'yurDepName': instance.yurDepName,
      'positionName': instance.positionName,
    };
