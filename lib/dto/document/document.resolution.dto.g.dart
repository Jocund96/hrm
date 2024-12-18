// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.resolution.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentResolutionDto _$DocumentResolutionDtoFromJson(
        Map<String, dynamic> json) =>
    DocumentResolutionDto(
      (nestedReader(json, 'id') as num?)?.toInt(),
      nestedReader(json, 'regNumber') as String?,
      nestedReader(json, 'incomingDate') as String?,
      nestedReader(json, 'directorFullName') as String?,
      nestedReader(json, 'approvedDate') as String?,
      nestedReader(json, 'enteredFullName') as String?,
      (nestedReader(json, 'documentCount') as num?)?.toInt(),
      (nestedReader(json, 'statusId') as num?)?.toInt(),
      nestedReader(json, 'statusName') as String?,
      nestedReader(json, 'statusCode') as String?,
      nestedReader(json, 'statusColor') as String?,
      (nestedReader(json, 'documentId') as num?)?.toInt(),
      (nestedReader(json, 'universalDocumentId') as num?)?.toInt(),
      nestedReader(json, 'typeStatus') as String?,
      json['incomeRegNumber'] as String?,
      json['incomeDate'] as String?,
      json['incomeTypeName'] as String?,
    );

Map<String, dynamic> _$DocumentResolutionDtoToJson(
        DocumentResolutionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'regNumber': instance.regNumber,
      'incomingDate': instance.incomingDate,
      'incomeRegNumber': instance.incomeRegNumber,
      'incomeDate': instance.incomeDate,
      'incomeTypeName': instance.incomeTypeName,
      'directorFullName': instance.directorFullName,
      'approvedDate': instance.approvedDate,
      'enteredFullName': instance.enteredFullName,
      'documentCount': instance.documentCount,
      'statusId': instance.statusId,
      'statusName': instance.statusName,
      'statusCode': instance.statusCode,
      'statusColor': instance.statusColor,
      'documentId': instance.documentId,
      'universalDocumentId': instance.universalDocumentId,
      'typeStatus': instance.typeStatus,
    };
