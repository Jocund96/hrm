// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate.list.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CorporateListDto _$CorporateListDtoFromJson(Map<String, dynamic> json) =>
    CorporateListDto(
      (nestedReader(json, 'total') as num?)?.toInt(),
      (nestedReader(json, 'list') as List<dynamic>?)
          ?.map((e) => CorporateDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CorporateListDtoToJson(CorporateListDto instance) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list,
    };
