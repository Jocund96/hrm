// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentDto _$DocumentDtoFromJson(Map<String, dynamic> json) => DocumentDto(
      (nestedReader(json, 'id') as num?)?.toInt(),
      nestedReader(json, 'docType') as String?,
      nestedReader(json, 'docNumber') as String?,
      nestedReader(json, 'docTitle') as String?,
      nestedReader(json, 'docMessage') as String?,
      nestedReader(json, 'docStatus') as String?,
    );

Map<String, dynamic> _$DocumentDtoToJson(DocumentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'docType': instance.docType,
      'docNumber': instance.docNumber,
      'docTitle': instance.docTitle,
      'docMessage': instance.docMessage,
      'docStatus': instance.docStatus,
    };
