import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/annotations/json_encodable.dart';
import 'package:mobile_ung/annotations/nested_json_key.dart';

part 'project.task.dto.g.dart';

@JsonSerializable()
class ProjectTaskDto implements JsonEncodable {
  @NestedJsonKey(name: 'id')
  final int? id;

  @NestedJsonKey(name: 'name')
  final String? name;

  @NestedJsonKey(name: 'color')
  final String? color;

  @NestedJsonKey(name: 'projectId')
  final int? projectId;

  @NestedJsonKey(name: 'projectName')
  final String? projectName;

  @NestedJsonKey(name: 'parentId')
  final int? parentId;

  @NestedJsonKey(name: 'parentName')
  final String? parentName;

  @NestedJsonKey(name: 'parentColor')
  final String? parentColor;

  @NestedJsonKey(name: 'cardId')
  final int? cardId;

  @NestedJsonKey(name: 'endDate')
  final String? endDate;

  @NestedJsonKey(name: 'endDateTime')
  final String? endDateTime;

  @NestedJsonKey(name: 'cardName')
  final String? cardName;

  @NestedJsonKey(name: 'cardColor')
  final String? cardColor;

  @NestedJsonKey(name: 'fileName')
  final String? fileName;

  @NestedJsonKey(name: 'fileExtension')
  final String? fileExtension;

  @NestedJsonKey(name: 'uploadPath')
  final String? uploadPath;

  @NestedJsonKey(name: 'cardParentId')
  final int? cardParentId;

  @NestedJsonKey(name: 'cardParentName')
  final String? cardParentName;

  @NestedJsonKey(name: 'ownerId')
  final int? ownerId;

  @NestedJsonKey(name: 'ownerFullName')
  final String? ownerFullName;

  ProjectTaskDto(
      this.id,
      this.name,
      this.color,
      this.projectId,
      this.projectName,
      this.parentId,
      this.parentName,
      this.parentColor,
      this.cardId,
      this.endDate,
      this.endDateTime,
      this.cardName,
      this.cardColor,
      this.fileName,
      this.fileExtension,
      this.uploadPath,
      this.cardParentId,
      this.cardParentName,
      this.ownerId,
      this.ownerFullName);

  @override
  Map<String, dynamic> toJson() => _$ProjectTaskDtoToJson(this);

  factory ProjectTaskDto.fromJson(Map<String, dynamic> json) => _$ProjectTaskDtoFromJson(json);
}
