import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/annotations/json_encodable.dart';
import 'package:mobile_ung/annotations/nested_json_key.dart';

part 'corporate.dto.g.dart';

@JsonSerializable()
class CorporateDto implements JsonEncodable {
  @NestedJsonKey(name: 'departmentId')
  final int? departmentId;

  @NestedJsonKey(name: 'departmentName')
  final String? departmentName;

  @NestedJsonKey(name: 'employeeFullName')
  final String? employeeFullName;

  @NestedJsonKey(name: 'innerPhoneNumber')
  final String? innerPhoneNumber;

  @NestedJsonKey(name: 'mobilePhoneNumber')
  final String? mobilePhoneNumber;

  @NestedJsonKey(name: 'photoUploadPath')
  final String? photoUploadPath;

  @NestedJsonKey(name: 'genderName')
  final String? genderName;

  @NestedJsonKey(name: 'yurDepName')
  final String? yurDepName;

  @NestedJsonKey(name: 'positionName')
  final String? positionName;

  CorporateDto(this.departmentId, this.departmentName, this.employeeFullName, this.innerPhoneNumber, this.mobilePhoneNumber,
      this.photoUploadPath, this.genderName, this.yurDepName, this.positionName);

  @override
  Map<String, dynamic> toJson() => _$CorporateDtoToJson(this);

  factory CorporateDto.fromJson(Map<String, dynamic> json) => _$CorporateDtoFromJson(json);
}
