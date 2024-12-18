import 'package:intl/intl.dart';

extension DateTimeHelper on DateTime {
  static final yyyyMMddWithTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  static final parseFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
  static final ddMMYYYYFormat = DateFormat('dd-MM-yyyy');
  static final dateFormat = DateFormat('dd/MM/yyyy');

  static DateTime fromIso8601Json(String json) => DateTimeHelper.parseFormat.parse(json);

  static String toIso8601Json(DateTime date) => date.toIso8601String();

  static DateTime fromDDMMYYYY(String json) => DateTimeHelper.ddMMYYYYFormat.parse(json);

  static DateTime? fromDDMMYYYYNullable(String? json) => json == null ? null : DateTimeHelper.ddMMYYYYFormat.parse(json);

  static String toDDMMYYYY(DateTime date) => ddMMYYYYFormat.format(date);

  String format() => dateFormat.format(this);

  static DateTime fromYyyyMMddWithTime(String json) => DateTimeHelper.yyyyMMddWithTimeFormat.parse(json);
}
