// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.menu.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentMenuDto _$DocumentMenuDtoFromJson(Map<String, dynamic> json) =>
    DocumentMenuDto(
      (nestedReader(json, 'id') as num?)?.toInt(),
      nestedReader(json, 'name') as String?,
      (nestedReader(json, 'count') as num?)?.toInt(),
    );

Map<String, dynamic> _$DocumentMenuDtoToJson(DocumentMenuDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
    };
