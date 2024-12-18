import 'package:json_annotation/json_annotation.dart';

Object? rawReader(Map json, String key) => json;

class RawJsonKey extends JsonKey {
  const RawJsonKey() : super(name: '', readValue: rawReader, includeToJson: false);
}
