import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/annotations/json_encodable.dart';
import 'package:mobile_ung/annotations/nested_json_key.dart';

part 'document.resolution.dto.g.dart';

@JsonSerializable()
class DocumentResolutionDto implements JsonEncodable {
  @NestedJsonKey(name: 'id')
  final int? id;

  @NestedJsonKey(name: 'regNumber')
  final String? regNumber;

  @NestedJsonKey(name: 'incomingDate')
  final String? incomingDate;

  final String? incomeRegNumber;
  final String? incomeDate;
  final String? incomeTypeName;

  @NestedJsonKey(name: 'directorFullName')
  final String? directorFullName;

  @NestedJsonKey(name: 'approvedDate')
  final String? approvedDate;

  @NestedJsonKey(name: 'enteredFullName')
  final String? enteredFullName;

  @NestedJsonKey(name: 'documentCount')
  final int? documentCount;

  @NestedJsonKey(name: 'statusId')
  final int? statusId;

  @NestedJsonKey(name: 'statusName')
  final String? statusName;

  @NestedJsonKey(name: 'statusCode')
  final String? statusCode;

  @NestedJsonKey(name: 'statusColor')
  final String? statusColor;

  @NestedJsonKey(name: 'documentId')
  final int? documentId;

  @NestedJsonKey(name: 'universalDocumentId')
  final int? universalDocumentId;

  @NestedJsonKey(name: 'typeStatus')
  final String? typeStatus;

  DocumentResolutionDto(
    this.id,
    this.regNumber,
    this.incomingDate,
    this.directorFullName,
    this.approvedDate,
    this.enteredFullName,
    this.documentCount,
    this.statusId,
    this.statusName,
    this.statusCode,
    this.statusColor,
    this.documentId,
    this.universalDocumentId,
    this.typeStatus,
    this.incomeRegNumber,
    this.incomeDate,
    this.incomeTypeName,
  );

  @override
  Map<String, dynamic> toJson() => _$DocumentResolutionDtoToJson(this);

  factory DocumentResolutionDto.fromJson(Map<String, dynamic> json) => _$DocumentResolutionDtoFromJson(json);
}
