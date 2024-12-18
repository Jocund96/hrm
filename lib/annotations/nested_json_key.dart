import 'package:json_annotation/json_annotation.dart';

Object? nestedReader(Map json, String key) {
  if (json.containsKey(key)) {
    return json[key];
  }

  return _nestedReader(json, key.split('/'));
}

Object? _nestedReader(final Object? object, Iterable<String> keys) {
  if (keys.isEmpty || object == null) {
    return object;
  }

  if (object is Map) {
    final subObject = object[keys.first];
    final subKeys = keys.skip(1);
    return _nestedReader(subObject, subKeys);
  }

  if (object is List) {
    return object.fold<dynamic>([], (list, subObject) {
      return list..add(_nestedReader(subObject, keys));
    });
  }

  return object;
}

class NestedJsonKey extends JsonKey {
  const NestedJsonKey({
    super.toJson,
    super.fromJson,
    super.required,
    super.defaultValue,
    super.includeIfNull,
    super.includeToJson,
    required super.name,
    super.includeFromJson,
    super.unknownEnumValue,
    super.disallowNullValue,
  }) : super(readValue: nestedReader);
}
