import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobile_ung/core/const/app_const.dart';
import 'package:mobile_ung/crypto/crc32.dart';
import 'package:mobile_ung/dto/document/document.income.dto.dart';
import 'package:omega_dio_logger/omega_dio_logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../crypto/gost_hash.dart';
import '../dto/eimzo/eimzo.dart';
import '../errors/app_not_installed.dart';
import '../http.dart';

const channel = MethodChannel('eimzo_installed');

const EventChannel windowFocusChannel = EventChannel('window_focus_channel');

final dio = Dio(
  dioOptions.copyWith(baseUrl: AppConst.eImzoUrl),
)..interceptors.add(
    const OmegaDioLogger(
      showCurl: false,
      colorized: true,
      requestBody: true,
      responseBody: true,
      requestHeader: false,
      responseHeader: false,
      showLog: kDebugMode,
      logPrint: log,
    ),
  );

class _EimzoParams {
  final BaseDto base;
  final String payload;

  List<int> get payloadBytes => utf8.encode(payload);

  String get crc32 => Crc32.calcHex(code);

  String get code => '${base.siteId}${base.documentId}$hash';

  String get hash => GostHash.hashGost2Hex(payloadBytes);

  String get launchHash => '$code$crc32';

  const _EimzoParams(this.base, this.payload);
}

abstract final class EimzoService {
  static Future<AuthDto> _auth() async {
    final response = await dio.post('/frontend/mobile/auth');

    return AuthDto.fromJson(response.data);
  }

  static Future<SignDto> _sign() async {
    final response = await dio.post('/frontend/mobile/sign');

    return SignDto.fromJson(response.data);
  }

  static Future<bool> _launch(String code) async {
    final isInstalled = await channel.invokeMethod<bool>('get');

    if (isInstalled != null && !isInstalled) {
      throw AppNotInstalledError();
    }

    final deepLink = Uri.parse('eimzo://sign?qc=$code');

    if (!(await canLaunchUrl(deepLink))) {
      throw Exception('Could not launch deep link');
    }

    return launchUrl(deepLink);
  }

  static Future<String> auth() async {
    final completer = Completer<String>();

    final result = await _auth();
    final params = _EimzoParams(result, result.challenge);
    final isLaunched = await _launch(params.launchHash);

    if (isLaunched) {
      try {
        final status = await _poolStatus(params.base.documentId);

        if (status.isSuccess) {
          completer.complete(params.base.documentId);
        }
      } catch (error) {
        completer.completeError(error);
      }
    }

    return completer.future;
  }

  static Future<(String, String)> sign({required DocumentIncomeDto document}) async {
    final completer = Completer<(String, String)>();

    final params = _EimzoParams(await _sign(), jsonEncode(document.raw));
    final isLaunched = await _launch(params.launchHash);

    if (isLaunched) {
      try {
        final status = await _poolStatus(params.base.documentId);

        if (status.isSuccess) {
          completer.complete((params.base.documentId, base64Encode(params.payloadBytes)));
        }
      } on Error catch (error) {
        await FirebaseCrashlytics.instance.recordError(error, null, information: [
          {'documentId': document.id, 'type': document.typeStatus}
        ]);
        completer.completeError(error);
      } catch (error) {
        await FirebaseCrashlytics.instance.recordError(error, null, information: [
          {'documentId': document.id, 'type': document.typeStatus}
        ]);
        completer.completeError(error);
      }
    }

    return completer.future;
  }

  static Future<StatusDto> _poolStatus(String documentId) async {
    final completer = Completer<StatusDto>();

    var tick = 6;
    var hasFocus = true;

    final listener = windowFocusChannel.receiveBroadcastStream().listen((event) {
      hasFocus = event as bool;
    });

    await Future.doWhile(() async {
      if (tick == 0) {
        completer.completeError(Exception('Unable to sign document'));

        return false;
      }

      tick -= 1;

      sleep(const Duration(seconds: 2));

      try {
        final response = await dio.post('/frontend/mobile/status', queryParameters: {'documentId': documentId});
        final status = StatusDto.fromJson(response.data);

        if (status.isError) {
          completer.completeError(status.message ?? Exception('Unable to sign document'));
          return false;
        }

        if (status.isSuccess) {
          completer.complete(status);
          return false;
        }

        if (status.status == 2 && hasFocus) {
          completer.completeError(Exception('Sign document canceled'));

          return false;
        }

        return status.isNotSigned;
      } catch (error) {
        completer.completeError(Exception('Unable to sign document'));
        return false;
      }
    });

    completer.future.whenComplete(() => listener.cancel());

    return completer.future;
  }
}
