// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      nestedReader(json, 'firstName') as String?,
      nestedReader(json, 'lastName') as String?,
      nestedReader(json, 'parentName') as String?,
      (nestedReader(json, 'role') as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (nestedReader(json, 'permissions') as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (nestedReader(json, 'employeeId') as num?)?.toInt(),
      (nestedReader(json, 'id') as num?)?.toInt(),
      nestedReader(json, 'photoUploadPath') as String?,
      nestedReader(json, 'token') as String?,
      nestedReader(json, 'username') as String?,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'parentName': instance.parentName,
      'role': instance.role,
      'permissions': instance.permissions,
      'employeeId': instance.employeeId,
      'id': instance.id,
      'photoUploadPath': instance.photoUploadPath,
      'token': instance.token,
      'username': instance.username,
    };
