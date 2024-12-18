import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_ung/config/language_service.dart';
import 'package:mobile_ung/core/const/app_const.dart';
import 'package:mobile_ung/core/shared_prefs.dart';
import 'package:mobile_ung/firebase_options.dart';
import 'package:mobile_ung/http.dart';
import 'views/login/login_screen.dart';
import 'views/navbar_screen.dart';

final prefs = SharedPrefs();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    configureDio(),
    EasyLocalization.ensureInitialized(),
    if (Platform.isAndroid || Platform.isIOS) Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  ]);

  final token = await prefs.getToken();

  final app = EasyLocalization(
    path: LanguageService.path,
    supportedLocales: LanguageService.locales,
    fallbackLocale: LanguageService.fallbackLocale,
    child: ProviderScope(
      child: UngApp(
        initialScreen: token == null || token == '' ? const LoginScreen() : const NavbarScreen(),
      ),
    ),
  );

  if (kReleaseMode && (Platform.isAndroid || Platform.isIOS)) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true).ignore();
      return true;
    };

    runZonedGuarded(() => runApp(app), (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true).ignore();
    });
  } else {
    runApp(app);
  }
}

class UngApp extends StatelessWidget {
  final Widget initialScreen;

  const UngApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, child) {
        return MaterialApp(
          home: initialScreen,
          title: 'UNG - docflow',
          locale: context.locale,
          navigatorKey: rootNavigatorKey,
          debugShowCheckedModeBanner: false,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
        );
      },
    );
  }
}
