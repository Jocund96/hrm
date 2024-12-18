import 'package:flutter/material.dart';

@staticIconProvider
abstract final class CustomIcons {
  static const _fontFamily = 'CustomIcons';

  static const eye = IconData(0xe900, fontFamily: _fontFamily);
  static const userUp = IconData(0xe901, fontFamily: _fontFamily);
  static const lock = IconData(0xe902, fontFamily: _fontFamily);
  static const user = IconData(0xe903, fontFamily: _fontFamily);
  static const home = IconData(0xe904, fontFamily: _fontFamily);
  static const documents = IconData(0xe905, fontFamily: _fontFamily);
  static const search = IconData(0xe906, fontFamily: _fontFamily);
  static const userOutlined = IconData(0xe907, fontFamily: _fontFamily);
  static const scan = IconData(0xe908, fontFamily: _fontFamily);
}

@staticIconProvider
abstract final class DashboardIcons {
  static const _fontFamily = 'CustomIcons';

  static const icon1 = IconData(0xe909, fontFamily: _fontFamily);
  static const icon2 = IconData(0xe90a, fontFamily: _fontFamily);
  static const icon3 = IconData(0xe90b, fontFamily: _fontFamily);
  static const icon4 = IconData(0xe90c, fontFamily: _fontFamily);

  static const List<IconData> icons = [DashboardIcons.icon1, DashboardIcons.icon2, DashboardIcons.icon3, DashboardIcons.icon4];
}

@staticIconProvider
abstract final class StatusIcons {
  static const _fontFamily = 'CustomIcons';

  static const signed = IconData(0xe90e, fontFamily: _fontFamily);
  static const inSign = IconData(0xe90d, fontFamily: _fontFamily);
  static const inAgree = IconData(0xe90f, fontFamily: _fontFamily);
  static const agreed = IconData(0xe910, fontFamily: _fontFamily);
  static const inEntering = IconData(0xe911, fontFamily: _fontFamily);
}
