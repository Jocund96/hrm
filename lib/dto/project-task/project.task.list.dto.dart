import 'package:json_annotation/json_annotation.dart';
import '../../annotations/json_encodable.dart';
import '../../annotations/nested_json_key.dart';
import 'project.task.dto.dart';

part 'project.task.list.dto.g.dart';

@JsonSerializable()
class ProjectTaskListDto<T> implements JsonEncodable {
  @NestedJsonKey(name: 'total')
  final int? total;

  @NestedJsonKey(name: 'list')
  final List<ProjectTaskDto>? list;

  ProjectTaskListDto({required this.total, required this.list});

  @override
  Map<String, dynamic> toJson() => _$ProjectTaskListDtoToJson(this);

  factory ProjectTaskListDto.fromJson(Map<String, dynamic> json) => _$ProjectTaskListDtoFromJson(json);
}

@JsonSerializable(createFactory: false)
class IncomeDocumentsBody implements JsonEncodable {
  final int page;
  final int limit;

  const IncomeDocumentsBody({required this.page, required this.limit});

  @override
  Map<String, dynamic> toJson() => _$IncomeDocumentsBodyToJson(this);

  static const initial = IncomeDocumentsBody(page: 0, limit: 20);
}
