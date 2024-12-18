// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthCredentialsDto _$AuthCredentialsDtoFromJson(Map<String, dynamic> json) =>
    AuthCredentialsDto(
      json['username'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$AuthCredentialsDtoToJson(AuthCredentialsDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
