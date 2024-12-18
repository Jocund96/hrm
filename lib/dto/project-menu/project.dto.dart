import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/annotations/json_encodable.dart';
import 'package:mobile_ung/annotations/nested_json_key.dart';
import 'package:mobile_ung/dto/project-menu/employee.dto.dart';

part 'project.dto.g.dart';

@JsonSerializable()
class ProjectDto implements JsonEncodable {
  @NestedJsonKey(name: 'id')
  final int? id;

  @NestedJsonKey(name: 'name')
  final String? name;

  @NestedJsonKey(name: 'description')
  final String? description;

  @NestedJsonKey(name: 'start')
  final String? start;

  @NestedJsonKey(name: 'end')
  final String? end;

  @NestedJsonKey(name: 'budget')
  final String? budget;

  @NestedJsonKey(name: 'status')
  final String? status;

  @NestedJsonKey(name: 'isAdmin')
  final bool? isAdmin;

  @NestedJsonKey(name: 'isDirector')
  final bool? isDirector;

  @NestedJsonKey(name: 'isRead')
  final bool? isRead;

  @NestedJsonKey(name: 'employeeId')
  final int? employeeId;

  @NestedJsonKey(name: 'employeeFullName')
  final String? employeeFullName;

  @NestedJsonKey(name: 'departmentName')
  final String? departmentName;

  @NestedJsonKey(name: 'staffPositionName')
  final String? staffPositionName;

  @NestedJsonKey(name: 'employees')
  final List<Employee>? employees;

  @NestedJsonKey(name: 'ownerId')
  final int? ownerId;

  @NestedJsonKey(name: 'ownerFirstName')
  final String? ownerFirstName;

  @NestedJsonKey(name: 'ownerLastName')
  final String? ownerLastName;

  @NestedJsonKey(name: 'ownerParentName')
  final String? ownerParentName;

  @NestedJsonKey(name: 'parentId')
  final int? parentId;

  @NestedJsonKey(name: 'parentName')
  final String? parentName;

  @NestedJsonKey(name: 'parentDescription')
  final String? parentDescription;

  @NestedJsonKey(name: 'projectTypeId')
  final int? projectTypeId;

  @NestedJsonKey(name: 'projectTypeName')
  final String? projectTypeName;

  @NestedJsonKey(name: 'featureId')
  final int? featureId;

  @NestedJsonKey(name: 'featureName')
  final String? featureName;

  @NestedJsonKey(name: 'child')
  final List<ProjectDto>? child;

  ProjectDto(
      this.id,
      this.name,
      this.description,
      this.start,
      this.end,
      this.budget,
      this.status,
      this.isAdmin,
      this.isDirector,
      this.isRead,
      this.employeeId,
      this.employeeFullName,
      this.departmentName,
      this.staffPositionName,
      this.employees,
      this.ownerId,
      this.ownerFirstName,
      this.ownerLastName,
      this.ownerParentName,
      this.parentId,
      this.parentName,
      this.parentDescription,
      this.projectTypeId,
      this.projectTypeName,
      this.featureId,
      this.featureName,
      this.child);

  @override
  Map<String, dynamic> toJson() => _$ProjectDtoToJson(this);

  factory ProjectDto.fromJson(Map<String, dynamic> json) => _$ProjectDtoFromJson(json);
}
