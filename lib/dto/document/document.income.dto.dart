import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_ung/annotations/json_encodable.dart';
import 'package:mobile_ung/annotations/nested_json_key.dart';
import 'package:mobile_ung/annotations/raw_json_key.dart';

part 'document.income.dto.g.dart';

@JsonSerializable()
class DocumentIncomeDto implements JsonEncodable {
  @NestedJsonKey(name: 'id')
  final int? id;

  @NestedJsonKey(name: 'universalDocumentId')
  final int? universalDocumentId;

  @NestedJsonKey(name: 'typeStatus')
  final String? typeStatus;

  @NestedJsonKey(name: 'documentId')
  final int? documentId;

  @NestedJsonKey(name: 'batchId')
  final int? batchId;

  @NestedJsonKey(name: 'batchEmployeeId')
  final int? batchEmployeeId;

  @NestedJsonKey(name: 'batchFullName')
  final String? batchFullName;

  @NestedJsonKey(name: 'batchUploadPath')
  final String? batchUploadPath;

  @NestedJsonKey(name: 'photoUploadPath')
  final String? photoUploadPath;

  @NestedJsonKey(name: 'batchPositionId')
  final int? batchPositionId;

  @NestedJsonKey(name: 'batchPositionName')
  final String? batchPositionName;

  @NestedJsonKey(name: 'batchDepartmentId')
  final int? batchDepartmentId;

  @NestedJsonKey(name: 'batchDepartmentName')
  final String? batchDepartmentName;

  @NestedJsonKey(name: 'batchStatusId')
  final int? batchStatusId;

  @NestedJsonKey(name: 'batchStatusName')
  final String? batchStatusName;

  @NestedJsonKey(name: 'batchStatus')
  final String? batchStatus;

  @NestedJsonKey(name: 'batchStatusColor')
  final String? batchStatusColor;

  @NestedJsonKey(name: 'date')
  final String? date;

  @NestedJsonKey(name: 'docDate')
  final String? docDate;

  @NestedJsonKey(name: 'incomeDate')
  final String? incomeDate;

  @NestedJsonKey(name: 'regNumber')
  final String? regNumber;

  @NestedJsonKey(name: 'isVisible')
  final bool? isVisible;

  @NestedJsonKey(name: 'comment')
  final String? comment;

  @NestedJsonKey(name: 'ownerId')
  final int? ownerId;

  @NestedJsonKey(name: 'ownerFullName')
  final String? ownerFullName;

  @NestedJsonKey(name: 'documentTypeId')
  final int? documentTypeId;

  @NestedJsonKey(name: 'documentTypeName')
  final String? documentTypeName;

  @NestedJsonKey(name: 'isOnlyOffice')
  final bool? isOnlyOffice;

  @NestedJsonKey(name: 'assStatusName')
  final String? assStatusName;

  @NestedJsonKey(name: 'assStatus')
  final String? assStatus;

  @NestedJsonKey(name: 'assStatusColor')
  final String? assStatusColor;

  @NestedJsonKey(name: 'signerId')
  final int? signerId;

  @NestedJsonKey(name: 'signerShortName')
  final String? signerShortName;

  @NestedJsonKey(name: 'signerFullName')
  final String? signerFullName;

  @NestedJsonKey(name: 'signerLastName')
  final String? signerLastName;

  @NestedJsonKey(name: 'signerFirstName')
  final String? signerFirstName;

  @NestedJsonKey(name: 'signerParentName')
  final String? signerParentName;

  @NestedJsonKey(name: 'staffPositionId')
  final int? staffPositionId;

  @NestedJsonKey(name: 'staffPositionName')
  final String? staffPositionName;

  @NestedJsonKey(name: 'departmentId')
  final int? departmentId;

  @NestedJsonKey(name: 'departmentName')
  final String? departmentName;

  @NestedJsonKey(name: 'purposeId')
  final int? purposeId;

  @NestedJsonKey(name: 'sendPurposeId')
  final int? sendPurposeId;

  @NestedJsonKey(name: 'sendPurposeName')
  final String? sendPurposeName;

  @NestedJsonKey(name: 'purposeName')
  final String? purposeName;

  @NestedJsonKey(name: 'sendPurposeCode')
  final String? sendPurposeCode;

  @NestedJsonKey(name: 'sendPurposeColor')
  final String? sendPurposeColor;

  @NestedJsonKey(name: 'expireDateAssignment')
  final String? expireDateAssignment;

  @NestedJsonKey(name: 'outRegNumber')
  final String? outRegNumber;

  @NestedJsonKey(name: 'outRegNumberExists')
  final String? outRegNumberExists;

  @NestedJsonKey(name: 'outDate')
  final String? outDate;

  @NestedJsonKey(name: 'receptionTypeId')
  final int? receptionTypeId;

  @NestedJsonKey(name: 'receptionTypeName')
  final String? receptionTypeName;

  @NestedJsonKey(name: 'incomeTypeId')
  final int? incomeTypeId;

  @NestedJsonKey(name: 'incomeTypeName')
  final String? incomeTypeName;

  @NestedJsonKey(name: 'incomeDocumentStateId')
  final int? incomeDocumentStateId;

  @NestedJsonKey(name: 'incomeDocumentStateName')
  final String? incomeDocumentStateName;

  @NestedJsonKey(name: 'contragentId')
  final int? contragentId;

  @NestedJsonKey(name: 'contragentName')
  final String? contragentName;

  @NestedJsonKey(name: 'contragentFullName')
  final String? contragentFullName;

  @NestedJsonKey(name: 'contragentPositionName')
  final String? contragentPositionName;

  @NestedJsonKey(name: 'contragentEmail')
  final String? contragentEmail;

  @NestedJsonKey(name: 'contragentAddress')
  final String? contragentAddress;

  @NestedJsonKey(name: 'appealFieldId')
  final int? appealFieldId;

  @NestedJsonKey(name: 'appealFieldName')
  final String? appealFieldName;

  @NestedJsonKey(name: 'personFullName')
  final String? personFullName;

  @NestedJsonKey(name: 'personAddress')
  final String? personAddress;

  @NestedJsonKey(name: 'personPhone')
  final String? personPhone;

  @NestedJsonKey(name: 'personEmail')
  final String? personEmail;

  @NestedJsonKey(name: 'personSpecialNote')
  final String? personSpecialNote;

  @NestedJsonKey(name: 'incomeRegNumber')
  final String? incomeRegNumber;

  @NestedJsonKey(name: 'incomeDateDoc')
  final String? incomeDateDoc;

  @NestedJsonKey(name: 'shortContent')
  final String? shortContent;

  @NestedJsonKey(name: 'recipientId')
  final int? recipientId;

  @NestedJsonKey(name: 'recipientFullName')
  final String? recipientFullName;

  @NestedJsonKey(name: 'recipientDepartmentId')
  final int? recipientDepartmentId;

  @NestedJsonKey(name: 'recipientDepartmentName')
  final String? recipientDepartmentName;

  @NestedJsonKey(name: 'recipientStaffPositionId')
  final int? recipientStaffPositionId;

  @NestedJsonKey(name: 'recipientStaffPositionName')
  final String? recipientStaffPositionName;

  @NestedJsonKey(name: 'oldDocumentName')
  final String? oldDocumentName;

  @NestedJsonKey(name: 'priority')
  final String? priority;

  @NestedJsonKey(name: 'prefix')
  final String? prefix;

  @NestedJsonKey(name: 'isYur')
  final bool? isYur;

  @NestedJsonKey(name: 'directorId')
  final int? directorId;

  @NestedJsonKey(name: 'directorFullName')
  final String? directorFullName;

  @NestedJsonKey(name: 'statusId')
  final int? statusId;

  @NestedJsonKey(name: 'statusName')
  final String? statusName;

  @NestedJsonKey(name: 'status')
  final String? status;

  @NestedJsonKey(name: 'statusColor')
  final String? statusColor;

  @NestedJsonKey(name: 'isSendToSafety')
  final bool? isSendToSafety;

  @NestedJsonKey(name: 'isManager')
  final bool? isManager;

  @NestedJsonKey(name: 'isHeadOfDepartment')
  final bool? isHeadOfDepartment;

  @NestedJsonKey(name: 'createdOutgoingDocument')
  final bool? createdOutgoingDocument;

  @NestedJsonKey(name: 'isRead')
  final bool? isRead;

  @NestedJsonKey(name: 'hashLink')
  final String? hashLink;

  @NestedJsonKey(name: 'lang')
  final String? lang;

  @NestedJsonKey(name: 'qrCodeNotUse')
  final bool? qrCodeNotUse;

  @NestedJsonKey(name: 'isContract')
  final bool? isContract;

  @NestedJsonKey(name: 'expireDate')
  final String? expireDate;

  @RawJsonKey()
  final Map<String, dynamic> raw;

  DocumentIncomeDto(
      this.id,
      this.raw,
      this.universalDocumentId,
      this.typeStatus,
      this.documentId,
      this.batchId,
      this.batchEmployeeId,
      this.batchFullName,
      this.batchUploadPath,
      this.photoUploadPath,
      this.batchPositionId,
      this.batchPositionName,
      this.batchDepartmentId,
      this.batchDepartmentName,
      this.batchStatusId,
      this.batchStatusName,
      this.batchStatus,
      this.batchStatusColor,
      this.date,
      this.docDate,
      this.incomeDate,
      this.regNumber,
      this.isVisible,
      this.comment,
      this.ownerId,
      this.ownerFullName,
      this.documentTypeId,
      this.documentTypeName,
      this.isOnlyOffice,
      this.assStatusName,
      this.assStatus,
      this.assStatusColor,
      this.signerId,
      this.signerShortName,
      this.signerFullName,
      this.signerLastName,
      this.signerFirstName,
      this.signerParentName,
      this.staffPositionId,
      this.staffPositionName,
      this.departmentId,
      this.departmentName,
      this.purposeId,
      this.sendPurposeId,
      this.sendPurposeName,
      this.purposeName,
      this.sendPurposeCode,
      this.sendPurposeColor,
      this.expireDateAssignment,
      this.outRegNumber,
      this.outRegNumberExists,
      this.outDate,
      this.receptionTypeId,
      this.receptionTypeName,
      this.incomeTypeId,
      this.incomeTypeName,
      this.incomeDocumentStateId,
      this.incomeDocumentStateName,
      this.contragentId,
      this.contragentName,
      this.contragentFullName,
      this.contragentPositionName,
      this.contragentEmail,
      this.contragentAddress,
      this.appealFieldId,
      this.appealFieldName,
      this.personFullName,
      this.personAddress,
      this.personPhone,
      this.personEmail,
      this.personSpecialNote,
      this.incomeRegNumber,
      this.incomeDateDoc,
      this.shortContent,
      this.recipientId,
      this.recipientFullName,
      this.recipientDepartmentId,
      this.recipientDepartmentName,
      this.recipientStaffPositionId,
      this.recipientStaffPositionName,
      this.oldDocumentName,
      this.priority,
      this.prefix,
      this.isYur,
      this.directorId,
      this.directorFullName,
      this.statusId,
      this.statusName,
      this.status,
      this.statusColor,
      this.isSendToSafety,
      this.isManager,
      this.isHeadOfDepartment,
      this.createdOutgoingDocument,
      this.isRead,
      this.hashLink,
      this.lang,
      this.qrCodeNotUse,
      this.isContract,
      this.expireDate);

  @override
  Map<String, dynamic> toJson() => _$DocumentIncomeDtoToJson(this);

  factory DocumentIncomeDto.fromJson(Map<String, dynamic> json) => _$DocumentIncomeDtoFromJson(json);
}

@JsonSerializable(createFactory: false)
class IncomeDocumentsBody implements JsonEncodable {
  final int page;
  final int limit;

  const IncomeDocumentsBody({required this.page, required this.limit});

  @override
  Map<String, dynamic> toJson() => _$IncomeDocumentsBodyToJson(this);

  static const initial = IncomeDocumentsBody(page: 0, limit: 20);
}
