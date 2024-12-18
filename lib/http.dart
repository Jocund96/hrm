import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobile_ung/core/const/app_const.dart';
import 'package:omega_dio_logger/omega_dio_logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'main.dart';

const publicUrls = ['/auth/login'];

class _AppInterceptor extends Interceptor {
  const _AppInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (publicUrls.any((url) => !options.path.endsWith(url))) {
      final token = await prefs.getToken();

      if (token != null) {
        options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.badResponse) {
      if ([401, 403].contains(err.response!.statusCode)) {
        //authProvider.logout();
      }
    }

    super.onError(err, handler);
  }
}

final dioOptions = BaseOptions(
  contentType: ContentType.json.mimeType,
  connectTimeout: const Duration(seconds: 20),
);

final api = Dio(dioOptions)..interceptors.add(const _AppInterceptor());

Uri apiUrl() {
  return Uri.parse(AppConst.baseUrl);
}

Future<void> configureDio() async {
  api.options.baseUrl = AppConst.baseUrl;
  api.options.headers[HttpHeaders.userAgentHeader] = await getUserAgent();

  if (kDebugMode) {
    api.interceptors.add(
      const OmegaDioLogger(
        request: false,
        showCurl: true,
        logPrint: print,
        colorized: false,
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        requestQueryParameters: true,
      ),
    );
  }
}

const channel = MethodChannel('user_agent');

Future<String> getUserAgent() async {
  try {
    final userAgent = await channel.invokeMethod<String>('get');

    if (userAgent == null) throw Exception();

    return userAgent;
  } catch (error) {
    final info = await PackageInfo.fromPlatform();

    return '${info.packageName}/${info.version}';
  }
}
