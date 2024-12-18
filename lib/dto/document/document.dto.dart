import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/annotations/json_encodable.dart';
import 'package:mobile_ung/annotations/nested_json_key.dart';

part 'document.dto.g.dart';

@JsonSerializable()
class DocumentDto implements JsonEncodable {
  @NestedJsonKey(name: 'id')
  final int? id;

  @NestedJsonKey(name: 'docType')
  final String? docType;

  @NestedJsonKey(name: 'docNumber')
  final String? docNumber;

  @NestedJsonKey(name: 'docTitle')
  final String? docTitle;

  @NestedJsonKey(name: 'docMessage')
  final String? docMessage;

  @NestedJsonKey(name: 'docStatus')
  final String? docStatus;

  DocumentDto(this.id, this.docType, this.docNumber, this.docTitle, this.docMessage, this.docStatus);

  @override
  Map<String, dynamic> toJson() => _$DocumentDtoToJson(this);

  factory DocumentDto.fromJson(Map<String, dynamic> json) => _$DocumentDtoFromJson(json);
}
