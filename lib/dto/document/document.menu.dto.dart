import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/annotations/json_encodable.dart';
import 'package:mobile_ung/annotations/nested_json_key.dart';

part 'document.menu.dto.g.dart';

@JsonSerializable()
class DocumentMenuDto implements JsonEncodable {
  @NestedJsonKey(name: 'id')
  int? id;

  @NestedJsonKey(name: 'name')
  String? name;

  @NestedJsonKey(name: 'count')
  int? count;

  DocumentMenuDto(this.id, this.name, this.count);

  @override
  Map<String, dynamic> toJson() => _$DocumentMenuDtoToJson(this);

  factory DocumentMenuDto.fromJson(Map<String, dynamic> json) => _$DocumentMenuDtoFromJson(json);
}
