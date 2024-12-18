import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile_ung/dto/auth/auth.dart';
import 'package:mobile_ung/http.dart';
import 'package:mobile_ung/main.dart';

import '../dto/user/user.dto.dart';
import 'eimzo.service.dart';

class AuthService {
  static Future<bool> login(AuthCredentialsDto credentials) async {
    var response = await api.post('/auth-payload', data: credentials.toJson());

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.toString());

      final employee = UserDto.fromJson(jsonMap);
      prefs.employee = employee;
      prefs.accessToken = employee.token;

      return true;
    } else if (response.statusCode == 400) {
      throw Exception('User not found');
    } else {
      throw Exception('Unexpected error');
    }
  }

  static Future<bool> loginByEsp(bool rememberMe) async {
    try {
      final documentId = await EimzoService.auth();
      var response = await api.post('/auth-payload', data: {'documentId': documentId});

      if (response.statusCode == 200) {
        final employee = UserDto.fromJson(response.data);
        prefs.employee = employee;
        prefs.accessToken = employee.token;

        return true;
      } else if (response.statusCode == 400) {
        throw Exception('User not found');
      } else {
        throw Exception('Unexpected error');
      }
    } on DioException {
      // await FirebaseCrashlytics.instance.recordError(error, error.stackTrace, information: [
      //   error.type,
      //   {'uri': error.requestOptions.uri.toString(), 'method': error.requestOptions.method, 'body': error.requestOptions.data}
      // ]);

      rethrow;
    } catch (error) {
      // await FirebaseCrashlytics.instance.recordError(error, StackTrace.current);
      // logError(error);
      rethrow;
    }
  }
}
