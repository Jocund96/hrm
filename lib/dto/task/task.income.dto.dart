import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/annotations/json_encodable.dart';
import 'package:mobile_ung/annotations/nested_json_key.dart';
import 'package:mobile_ung/dto/task/receiver.dto.dart';

part 'task.income.dto.g.dart';

@JsonSerializable()
class TaskIncomeDto implements JsonEncodable {
  @NestedJsonKey(name: 'id')
  final int? id;

  @NestedJsonKey(name: 'title')
  final String? title;

  @NestedJsonKey(name: 'beginDate')
  final String? beginDate;

  @NestedJsonKey(name: 'endDate')
  final String? endDate;

  @NestedJsonKey(name: 'directorId')
  final int? directorId;

  @NestedJsonKey(name: 'employeeFullName')
  final String? employeeFullName;

  @NestedJsonKey(name: 'directorFullName')
  final String? directorFullName;

  @NestedJsonKey(name: 'employeeUploadPath')
  final String? employeeUploadPath;

  @NestedJsonKey(name: 'directorUploadPath')
  final String? directorUploadPath;

  @NestedJsonKey(name: 'employeeId')
  final int? employeeId;

  @NestedJsonKey(name: 'departmentId')
  final int? departmentId;

  @NestedJsonKey(name: 'departmentName')
  final String? departmentName;

  @NestedJsonKey(name: 'staffPositionId')
  final int? staffPositionId;

  @NestedJsonKey(name: 'staffPositionName')
  final String? staffPositionName;

  @NestedJsonKey(name: 'directorDepartmentId')
  final int? directorDepartmentId;

  @NestedJsonKey(name: 'directorDepartmentName')
  final String? directorDepartmentName;

  @NestedJsonKey(name: 'directorStaffPositionId')
  final int? directorStaffPositionId;

  @NestedJsonKey(name: 'directorStaffPositionName')
  final String? directorStaffPositionName;

  @NestedJsonKey(name: 'taskStatus')
  final String? taskStatus;

  @NestedJsonKey(name: 'important')
  final String? important;

  @NestedJsonKey(name: 'receivers')
  final List<Receiver>? receivers;

  TaskIncomeDto(
      this.id,
      this.title,
      this.beginDate,
      this.endDate,
      this.directorId,
      this.employeeFullName,
      this.directorFullName,
      this.employeeUploadPath,
      this.directorUploadPath,
      this.employeeId,
      this.departmentId,
      this.departmentName,
      this.staffPositionId,
      this.staffPositionName,
      this.directorDepartmentId,
      this.directorDepartmentName,
      this.directorStaffPositionId,
      this.directorStaffPositionName,
      this.taskStatus,
      this.important,
      this.receivers);

  @override
  Map<String, dynamic> toJson() => _$TaskIncomeDtoToJson(this);

  factory TaskIncomeDto.fromJson(Map<String, dynamic> json) => _$TaskIncomeDtoFromJson(json);
}
