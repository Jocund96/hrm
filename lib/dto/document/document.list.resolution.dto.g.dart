// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.list.resolution.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentListResolutionDto _$DocumentListResolutionDtoFromJson(
        Map<String, dynamic> json) =>
    DocumentListResolutionDto(
      total: (nestedReader(json, 'total') as num?)?.toInt(),
      list: (nestedReader(json, 'list') as List<dynamic>?)
          ?.map(
              (e) => DocumentResolutionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocumentListResolutionDtoToJson(
        DocumentListResolutionDto instance) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list,
    };
