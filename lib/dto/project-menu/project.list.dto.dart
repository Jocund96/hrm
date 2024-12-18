import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/dto/project-menu/project.dto.dart';
import '../../annotations/json_encodable.dart';
import '../../annotations/nested_json_key.dart';

part 'project.list.dto.g.dart';

@JsonSerializable()
class ProjectListDto implements JsonEncodable {
  @NestedJsonKey(name: 'total')
  final int? total;

  @NestedJsonKey(name: 'list')
  final List<ProjectDto>? list;

  ProjectListDto({required this.total, required this.list});

  @override
  Map<String, dynamic> toJson() => _$ProjectListDtoToJson(this);

  factory ProjectListDto.fromJson(Map<String, dynamic> json) => _$ProjectListDtoFromJson(json);
}
