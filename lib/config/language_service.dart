import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/const/app_const.dart';

class LanguageService {
  static const path = 'assets/translations';

  static const List<Locale> locales = [
    Locale('en', 'US'),
    Locale('ru', 'RU'),
    Locale('uz', 'UZ'),
    Locale('uz', 'Cyrl-UZ'),
  ];

  static const fallbackLocale = Locale('uz', 'UZ');

  static const items = ['English', 'Русский', 'O\'zbekcha', 'Ўзбекча'];

  static const languages = ['en', 'ru', 'uz', 'oz'];

  static String get selectedLang {
    Locale? currentLocale = rootNavigatorKey.currentContext?.locale;
    int index = locales.indexOf(currentLocale ?? fallbackLocale);
    if (index != -1) return items[index];
    return items.first;
  }

  static Future<void> changeLanguage(String lang) async {
    Locale locale = locales.elementAt(items.indexOf(lang));
    if (rootNavigatorKey.currentContext != null) {
      await rootNavigatorKey.currentContext!.setLocale(locale);
      log('Change Language ${rootNavigatorKey.currentContext!.locale}');
    }
  }
}
