import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/annotations/json_encodable.dart';
import 'package:mobile_ung/annotations/nested_json_key.dart';

part 'employee.dto.g.dart';

@JsonSerializable()
class Employee implements JsonEncodable {
  @NestedJsonKey(name: 'id')
  final int? id;

  @NestedJsonKey(name: 'projectId')
  final int? projectId;

  @NestedJsonKey(name: 'projectName')
  final String? projectName;

  @NestedJsonKey(name: 'staffPositionId')
  final int? staffPositionId;

  @NestedJsonKey(name: 'staffPositionName')
  final String? staffPositionName;

  @NestedJsonKey(name: 'photoUploadPath')
  final String? photoUploadPath;

  @NestedJsonKey(name: 'departmentId')
  final int? departmentId;

  @NestedJsonKey(name: 'departmentName')
  final String? departmentName;

  @NestedJsonKey(name: 'employeeId')
  final int? employeeId;

  @NestedJsonKey(name: 'employeeFullName')
  final String? employeeFullName;

  @NestedJsonKey(name: 'isAdmin')
  final bool? isAdmin;

  @NestedJsonKey(name: 'isDirector')
  final bool? isDirector;

  Employee(this.id, this.projectId, this.projectName, this.staffPositionId, this.staffPositionName, this.photoUploadPath, this.departmentId,
      this.departmentName, this.employeeId, this.employeeFullName, this.isAdmin, this.isDirector);

  @override
  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);
}
