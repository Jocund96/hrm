import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/dto/document/document.resolution.dto.dart';
import '../../annotations/json_encodable.dart';
import '../../annotations/nested_json_key.dart';

part 'document.list.resolution.dto.g.dart';

@JsonSerializable()
class DocumentListResolutionDto implements JsonEncodable {
  @NestedJsonKey(name: 'total')
  final int? total;

  @NestedJsonKey(name: 'list')
  final List<DocumentResolutionDto>? list;

  DocumentListResolutionDto({required this.total, required this.list});

  @override
  Map<String, dynamic> toJson() => _$DocumentListResolutionDtoToJson(this);

  factory DocumentListResolutionDto.fromJson(Map<String, dynamic> json) => _$DocumentListResolutionDtoFromJson(json);
}
