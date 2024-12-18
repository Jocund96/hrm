import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/annotations/json_encodable.dart';
import 'package:mobile_ung/annotations/nested_json_key.dart';

part 'receiver.dto.g.dart';

@JsonSerializable()
class Receiver implements JsonEncodable {
  @NestedJsonKey(name: 'id')
  final int? id;

  @NestedJsonKey(name: 'receiverId')
  final int? receiverId;

  @NestedJsonKey(name: 'receiverUploadPath')
  final String? receiverUploadPath;

  @NestedJsonKey(name: 'receiverFullName')
  final String? receiverFullName;

  @NestedJsonKey(name: 'staffListId')
  final int? staffListId;

  @NestedJsonKey(name: 'staffPositionId')
  final int? staffPositionId;

  @NestedJsonKey(name: 'staffPositionName')
  final String? staffPositionName;

  @NestedJsonKey(name: 'departmentId')
  final int? departmentId;

  @NestedJsonKey(name: 'departmentName')
  final String? departmentName;

  @NestedJsonKey(name: 'seenDate')
  final String? seenDate;

  @NestedJsonKey(name: 'sendDate')
  final String? sendDate;

  @NestedJsonKey(name: 'status')
  final String? status;

  Receiver(this.id, this.receiverId, this.receiverUploadPath, this.receiverFullName, this.staffListId, this.staffPositionId,
      this.staffPositionName, this.departmentId, this.departmentName, this.seenDate, this.sendDate, this.status);

  @override
  Map<String, dynamic> toJson() => _$ReceiverToJson(this);

  factory Receiver.fromJson(Map<String, dynamic> json) => _$ReceiverFromJson(json);
}
