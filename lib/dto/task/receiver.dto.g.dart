// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiver.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receiver _$ReceiverFromJson(Map<String, dynamic> json) => Receiver(
      (nestedReader(json, 'id') as num?)?.toInt(),
      (nestedReader(json, 'receiverId') as num?)?.toInt(),
      nestedReader(json, 'receiverUploadPath') as String?,
      nestedReader(json, 'receiverFullName') as String?,
      (nestedReader(json, 'staffListId') as num?)?.toInt(),
      (nestedReader(json, 'staffPositionId') as num?)?.toInt(),
      nestedReader(json, 'staffPositionName') as String?,
      (nestedReader(json, 'departmentId') as num?)?.toInt(),
      nestedReader(json, 'departmentName') as String?,
      nestedReader(json, 'seenDate') as String?,
      nestedReader(json, 'sendDate') as String?,
      nestedReader(json, 'status') as String?,
    );

Map<String, dynamic> _$ReceiverToJson(Receiver instance) => <String, dynamic>{
      'id': instance.id,
      'receiverId': instance.receiverId,
      'receiverUploadPath': instance.receiverUploadPath,
      'receiverFullName': instance.receiverFullName,
      'staffListId': instance.staffListId,
      'staffPositionId': instance.staffPositionId,
      'staffPositionName': instance.staffPositionName,
      'departmentId': instance.departmentId,
      'departmentName': instance.departmentName,
      'seenDate': instance.seenDate,
      'sendDate': instance.sendDate,
      'status': instance.status,
    };
