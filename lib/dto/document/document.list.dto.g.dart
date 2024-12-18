// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.list.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentListDto _$DocumentListDtoFromJson(Map<String, dynamic> json) =>
    DocumentListDto(
      total: (nestedReader(json, 'total') as num?)?.toInt(),
      list: (nestedReader(json, 'list') as List<dynamic>?)
          ?.map((e) => DocumentIncomeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocumentListDtoToJson(DocumentListDto instance) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list,
    };
