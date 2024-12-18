import 'package:json_annotation/json_annotation.dart';

class GenericConverter<T> implements JsonConverter<T, Object?> {
  final T Function(Map<String, dynamic> json) fromJsonFunc;
  final Map<String, dynamic> Function(T object)? toJsonFunc;

  const GenericConverter(this.fromJsonFunc, {this.toJsonFunc});

  @override
  T fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      return fromJsonFunc(json);
    }
    throw UnimplementedError('Cannot convert $json to $T');
  }

  @override
  Object? toJson(T object) {
    if (toJsonFunc != null) {
      return toJsonFunc!(object);
    }
    return object?.toString(); // Fallback to a basic string representation
  }
}
