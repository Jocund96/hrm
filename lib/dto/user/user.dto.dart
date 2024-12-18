import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/annotations/json_encodable.dart';
import 'package:mobile_ung/annotations/nested_json_key.dart';

part 'user.dto.g.dart';

@JsonSerializable()
class UserDto implements JsonEncodable {
  @NestedJsonKey(name: 'firstName')
  final String? firstName;

  @NestedJsonKey(name: 'lastName')
  final String? lastName;

  @NestedJsonKey(name: 'parentName')
  final String? parentName;

  @NestedJsonKey(name: 'role')
  final List<String>? role;

  @NestedJsonKey(name: 'permissions')
  final List<String>? permissions;

  @NestedJsonKey(name: 'employeeId')
  final int? employeeId;

  @NestedJsonKey(name: 'id')
  final int? id;

  @NestedJsonKey(name: 'photoUploadPath')
  final String? photoUploadPath;

  @NestedJsonKey(name: 'token')
  final String? token;

  @NestedJsonKey(name: 'username')
  final String? username;

  UserDto(this.firstName, this.lastName, this.parentName, this.role, this.permissions, this.employeeId, this.id, this.photoUploadPath,
      this.token, this.username);

  @override
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}
