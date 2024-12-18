// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eimzo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthDto _$AuthDtoFromJson(Map<String, dynamic> json) => AuthDto(
      status: (json['status'] as num).toInt(),
      challenge: json['challange'] as String,
      siteId: json['siteId'] as String,
      documentId: json['documentId'] as String,
    );

SignDto _$SignDtoFromJson(Map<String, dynamic> json) => SignDto(
      status: (json['status'] as num).toInt(),
      siteId: json['siteId'] as String,
      documentId: json['documentId'] as String,
    );

StatusDto _$StatusDtoFromJson(Map<String, dynamic> json) => StatusDto(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String?,
    );
