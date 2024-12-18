import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/annotations/json_encodable.dart';

part 'auth.g.dart';

@JsonSerializable()
class AuthCredentialsDto implements JsonEncodable {
  final String username;
  final String password;

  const AuthCredentialsDto(this.username, this.password);

  @override
  Map<String, dynamic> toJson() => _$AuthCredentialsDtoToJson(this);

  factory AuthCredentialsDto.fromJson(Map<String, dynamic> json) => _$AuthCredentialsDtoFromJson(json);
}
