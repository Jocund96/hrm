import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/dto/document/document.income.dto.dart';
import '../../annotations/json_encodable.dart';
import '../../annotations/nested_json_key.dart';

part 'document.list.dto.g.dart';

@JsonSerializable()
class DocumentListDto implements JsonEncodable {
  @NestedJsonKey(name: 'total')
  final int? total;

  @NestedJsonKey(name: 'list')
  final List<DocumentIncomeDto>? list;

  DocumentListDto({required this.total, required this.list});

  @override
  Map<String, dynamic> toJson() => _$DocumentListDtoToJson(this);

  factory DocumentListDto.fromJson(Map<String, dynamic> json) => _$DocumentListDtoFromJson(json);
}
