import 'dart:convert';

abstract final class JsonHelper {
  static T safeFromJson<T>(T? json) {
    return (json ?? '') as T;
  }

  static String prettyEncode(Map<String, dynamic> json) {
    final encoder = JsonEncoder.withIndent(' ' * 3);

    return encoder.convert(json);
  }
}
