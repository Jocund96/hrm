import 'package:json_annotation/json_annotation.dart';

import '../../annotations/json_encodable.dart';

part 'dio.g.dart';

@JsonSerializable(createFactory: false)
class PaginationDto implements JsonEncodable {
  final int page;
  final int limit;

  const PaginationDto({required this.page, required this.limit});

  @override
  Map<String, dynamic> toJson() => _$PaginationDtoToJson(this);

  static const PaginationDto initial = PaginationDto(page: 0, limit: 20);
}
