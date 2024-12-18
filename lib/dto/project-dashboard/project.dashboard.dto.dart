import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/annotations/json_encodable.dart';
import 'package:mobile_ung/annotations/nested_json_key.dart';

part 'project.dashboard.dto.g.dart';

@JsonSerializable()
class ProjectDashboardDto implements JsonEncodable {
  @NestedJsonKey(name: 'create')
  final int? create;

  @NestedJsonKey(name: 'process')
  final int? process;

  @NestedJsonKey(name: 'finish')
  final int? finish;

  @NestedJsonKey(name: 'expired')
  final int? expired;

  ProjectDashboardDto(this.create, this.process, this.finish, this.expired);

  @override
  Map<String, dynamic> toJson() => _$ProjectDashboardDtoToJson(this);

  factory ProjectDashboardDto.fromJson(Map<String, dynamic> json) => _$ProjectDashboardDtoFromJson(json);
}
