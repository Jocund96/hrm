import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/dto/task/task.income.dto.dart';
import '../../annotations/json_encodable.dart';
import '../../annotations/nested_json_key.dart';

part 'task.list.dto.g.dart';

@JsonSerializable()
class TaskListDto implements JsonEncodable {
  @NestedJsonKey(name: 'total')
  final int? total;

  @NestedJsonKey(name: 'list')
  final List<TaskIncomeDto>? list;

  TaskListDto(this.total, this.list);

  @override
  Map<String, dynamic> toJson() => _$TaskListDtoToJson(this);

  factory TaskListDto.fromJson(Map<String, dynamic> json) => _$TaskListDtoFromJson(json);
}
