import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/dto/corporate/corporate.dto.dart';
import '../../annotations/json_encodable.dart';
import '../../annotations/nested_json_key.dart';

part 'corporate.list.dto.g.dart';

@JsonSerializable()
class CorporateListDto implements JsonEncodable {
  @NestedJsonKey(name: 'total')
  final int? total;

  @NestedJsonKey(name: 'list')
  final List<CorporateDto>? list;

  CorporateListDto(this.total, this.list);

  @override
  Map<String, dynamic> toJson() => _$CorporateListDtoToJson(this);

  factory CorporateListDto.fromJson(Map<String, dynamic> json) => _$CorporateListDtoFromJson(json);
}
