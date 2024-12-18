import 'package:json_annotation/json_annotation.dart';

part 'eimzo.g.dart';

class BaseDto {
  final int status;

  final String siteId;

  final String documentId;

  BaseDto({
    required this.status,
    required this.siteId,
    required this.documentId,
  });
}

@JsonSerializable(createToJson: false)
class AuthDto extends BaseDto {
  @JsonKey(name: 'challange')
  final String challenge;

  AuthDto({required super.status, required this.challenge, required super.siteId, required super.documentId});

  factory AuthDto.fromJson(Map<String, dynamic> json) => _$AuthDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class SignDto extends BaseDto {
  SignDto({
    required super.status,
    required super.siteId,
    required super.documentId,
  });

  factory SignDto.fromJson(Map<String, dynamic> json) => _$SignDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class StatusDto {
  final int status;
  final String? message;

  bool get isSuccess => status == 1;

  bool get isNotSigned => status == 2;

  bool get isError => status < 0;

  const StatusDto({required this.status, this.message});

  factory StatusDto.fromJson(Map<String, dynamic> json) => _$StatusDtoFromJson(json);
}
