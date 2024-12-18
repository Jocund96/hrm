import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';
import 'package:mobile_ung/core/theme/linear_progress.dart';
import 'package:mobile_ung/dto/document/document.list.dto.dart';
import 'package:mobile_ung/dto/document/document.resolution.dto.dart';
import 'package:mobile_ung/http.dart';
import 'package:mobile_ung/network/eimzo.service.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../dto/document/document.income.dto.dart';
import '../../network/document_service.dart';

class DocumentItemDetail extends StatefulWidget {
  final int? selectedIndex;
  final DocumentIncomeDto? documentIncomeDto;
  final DocumentResolutionDto? documentResolutionDto;

  const DocumentItemDetail({super.key, this.documentIncomeDto, this.documentResolutionDto, this.selectedIndex});

  @override
  State<DocumentItemDetail> createState() => _DocumentItemDetailState();
}

class _DocumentItemDetailState extends State<DocumentItemDetail> {
  bool _isLoading = false;
  bool _isSignLoading = false;
  bool _isRejectLoading = false;

  String base64Pdf = '';
  bool isResolution = false;
  bool isSporis = false;
  int documentId = 0;
  String comment = '';
  String documentTypeName = '';
  String date = '';
  String regNumber = '';
  String sendPurposeName = '';
  String ownerFullName = '';
  String signerFullName = '';
  int universalDocumentId = 0;

  Future<void> _fetchAndOpenPdf(int id) async {
    setState(() {
      _isLoading = true;
    });

    try {
      base64Pdf = await DocumentService().getBase64(id);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> saveAndOpenPdf(String base64Pdf, String fileName) async {
    final bytes = base64Decode(base64Pdf);

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName.pdf';

    final file = File(filePath);
    await file.writeAsBytes(bytes);

    await OpenFilex.open(filePath);
  }

  @override
  void initState() {
    super.initState();
    setDataDto(widget.selectedIndex);
    _fetchAndOpenPdf(universalDocumentId);
    if (widget.documentIncomeDto?.sendPurposeName != null) {
      isResolution = true;
    }
    if (widget.documentIncomeDto?.signerFullName != null) {
      isSporis = true;
    }
    reFetch(widget.selectedIndex);
  }

  Future<void> signDocument() async {
    if (widget.documentIncomeDto == null) return;

    final description = await descriptionDialog(title: 'description', context: context, confirmText: 'imzolash');

    if (description == null) return;

    try {
      setState(() {
        _isSignLoading = true;
      });

      final result = await EimzoService.sign(
        document: DocumentIncomeDto.fromJson(
          {
            ...widget.documentIncomeDto!.raw,
            'documentAssignmentId': widget.documentIncomeDto!.id,
            'comment': description.isEmpty ? null : description
          },
        ),
      );
      await api.post(
        '/document-assignment/make-sign',
        data: {'documentId': result.$1, 'documentAssignmentId': widget.documentIncomeDto!.id, 'document': result.$2, 'comment': comment},
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('signed'.tr(), style: const TextStyle(color: Colors.white)),
          backgroundColor: AppColors.importantInTaskCompleted,
        ),
      );

      reFetch(widget.selectedIndex);
    } on DioException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.response?.data?['message'] ?? 'Serverda xatolik!',
            style: const TextStyle(color: Colors.white),
          ),
          duration: Durations.extralong4,
          backgroundColor: AppColors.red,
        ),
      );
    } finally {
      setState(() {
        _isSignLoading = false;
      });
    }
  }

  Future<void> rejectDocument() async {
    if (widget.documentIncomeDto == null) return;

    final description = await descriptionDialog(title: 'description', confirmText: 'reject', context: context);

    if (description == null) return;

    try {
      setState(() {
        _isRejectLoading = true;
      });

      await api.post('/document-assignment/cancel', data: {
        'documentId': widget.documentIncomeDto!.universalDocumentId,
        'comment': description.isEmpty ? null : description,
      });

      reFetch(widget.selectedIndex);
    } on DioException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.response?.data?['message'] ?? 'Serverda xatolik!',
            style: const TextStyle(color: Colors.white),
          ),
          duration: Durations.extralong4,
          backgroundColor: AppColors.red,
        ),
      );
    } finally {
      setState(() {
        _isRejectLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 1,
        titleSpacing: 0,
        leadingWidth: 50,
        centerTitle: true,
        backgroundColor: AppColors.white,
        title: Text(
          '№ $documentId',
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LinearProgress(
            isLoading: _isLoading,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: regNumber.isNotEmpty,
                    child: Column(
                      children: [
                        Text(
                          context.tr('theme_dc'),
                          style: const TextStyle(color: AppColors.hintText, fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          regNumber,
                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    context.tr('type_dc'),
                    style: const TextStyle(color: AppColors.hintText, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    documentTypeName,
                    style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    context.tr('number_dc'),
                    style: const TextStyle(color: AppColors.hintText, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '№ $documentId',
                    style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    context.tr('date_dc'),
                    style: const TextStyle(color: AppColors.hintText, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Visibility(
                    visible: isResolution,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          context.tr('resolution'),
                          style: const TextStyle(color: AppColors.hintText, fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              sendPurposeName,
                              style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(thickness: 0.3, color: Colors.grey[400], height: 5),
                  const SizedBox(height: 10),
                  Text(
                    context.tr('sp_worker'),
                    style: const TextStyle(color: AppColors.hintText, fontSize: 14),
                  ),
                  Row(
                    children: [
                      Image.asset('assets/images/circle.png', height: 60),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              ownerFullName,
                              style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            context.tr('occupation'),
                            style: const TextStyle(color: AppColors.hintText, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(thickness: 0.3, color: Colors.grey[400], height: 5),
                  Visibility(
                    visible: isSporis,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          context.tr('sp_extra_worker'),
                          style: const TextStyle(color: AppColors.hintText, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Image.asset('assets/images/circle.png', height: 60),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 200,
                              child: Column(
                                children: [
                                  Text(
                                    signerFullName,
                                    style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    context.tr('occupation'),
                                    style: const TextStyle(color: AppColors.hintText, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Image.asset('assets/images/checks.png', height: 24),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(thickness: 0.3, color: Colors.grey[400], height: 5),
                  const SizedBox(height: 10),
                  Text(
                    context.tr('incoming_dc'),
                    style: const TextStyle(color: AppColors.hintText, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Visibility(
                    visible: base64Pdf.isNotEmpty,
                    child: InkWell(
                      onTap: () async {
                        await saveAndOpenPdf(base64Pdf, '$universalDocumentId');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.pdfBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.pdfStroke),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Image.asset('assets/images/pdf_image.png', height: 60),
                              const SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    '$universalDocumentId.pdf',
                                    style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    pdDate(date),
                                    style: const TextStyle(color: AppColors.hintText, fontSize: 14),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Image.asset('assets/images/eye.png', height: 24),
                              const SizedBox(width: 10)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(thickness: 0.3, color: Colors.grey[400], height: 5),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: widget.selectedIndex != 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          context.tr('incoming_dc'),
                          style: const TextStyle(color: AppColors.hintText, fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          comment,
                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ((widget.selectedIndex == 0 || widget.selectedIndex == 1) &&
              widget.documentIncomeDto?.status != 'CANCEL' &&
              widget.documentIncomeDto?.raw['assignmentStatus'] == false)
          ? Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shadowColor: Colors.black,
                      backgroundColor: AppColors.importantInTaskCompleted,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: _isSignLoading ? null : signDocument,
                    child: Row(
                      children: [
                        if (_isSignLoading) ...[
                          Container(
                            width: 16,
                            height: 16,
                            padding: const EdgeInsets.all(1),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          'imzolash'.tr(),
                          style: const TextStyle(
                            fontSize: 16, // Font size
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  if (widget.documentIncomeDto?.typeStatus != 'HOLIDAY')
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        shadowColor: Colors.black,
                        backgroundColor: AppColors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: _isRejectLoading ? null : rejectDocument,
                      child: Row(
                        children: [
                          if (_isRejectLoading) ...[
                            Container(
                              width: 16,
                              height: 16,
                              padding: const EdgeInsets.all(1),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            ),
                            const SizedBox(width: 6),
                          ],
                          Text(
                            'reject'.tr(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ].foldIndexed([], (index, acc, curr) => [...acc, curr, if (index != 2) const SizedBox(width: 6)]),
              ),
            )
          : null,
    );
  }

  String pdDate(String? documentIncomeDto) {
    String s = documentIncomeDto ?? '';
    if (s.isNotEmpty || s != '') {
      return s.substring(0, 10);
    }
    return '';
  }

  Future<void> reFetch(int? selectedIndex) async {
    if (selectedIndex == 0 || selectedIndex == 1) {
      final result = await api.post(
        '/universal-document/income',
        data: const IncomeDocumentsBody(page: 0, limit: 20).toJson(),
        queryParameters: {
          'date': widget.documentIncomeDto?.date,
          'prefix': widget.documentIncomeDto?.prefix,
          'outDate': widget.documentIncomeDto?.outDate,
          'statusId': widget.documentIncomeDto?.statusId,
          'regNumber': widget.documentIncomeDto?.regNumber,
          'incomeDate': widget.documentIncomeDto?.incomeDate,
          'expireDate': widget.documentIncomeDto?.expireDate,
          'contragentId': widget.documentIncomeDto?.contragentId,
          'outRegNumber': widget.documentIncomeDto?.outRegNumber,
          'assStatusName': widget.documentIncomeDto?.assStatusName,
          'sendPurposeId': widget.documentIncomeDto?.sendPurposeId,
          'documentTypeName': widget.documentIncomeDto?.documentTypeName,
          'assignmentStatusCode': widget.documentIncomeDto?.raw['assignmentStatusCode'],
        },
      );
      final data = DocumentListDto.fromJson(result.data);
      for (final document in data.list ?? []) {
        if (document != null && document.id != null && document.id == widget.documentIncomeDto?.id) {
          setDataDto(selectedIndex);
          break;
        }
      }
    }
  }

  void setDataDto(int? selectedIndex) {
    setState(() {
      if (selectedIndex == 0 || selectedIndex == 1) {
        documentId = widget.documentIncomeDto?.documentId ?? 0;
        universalDocumentId = widget.documentIncomeDto?.universalDocumentId ?? 0;
        comment = widget.documentIncomeDto?.comment ?? '';
        documentTypeName = widget.documentIncomeDto?.documentTypeName ?? '';
        date = widget.documentIncomeDto?.date ?? '';
        regNumber = widget.documentIncomeDto?.regNumber ?? '';
        sendPurposeName = widget.documentIncomeDto?.sendPurposeName ?? '';
        ownerFullName = widget.documentIncomeDto?.ownerFullName ?? '';
        signerFullName = widget.documentIncomeDto?.signerFullName ?? '';
      }
      if (selectedIndex == 3) {
        documentId = widget.documentResolutionDto?.documentId ?? 0;
        universalDocumentId = widget.documentResolutionDto?.universalDocumentId ?? 0;
        comment = widget.documentResolutionDto?.regNumber ?? '';
        regNumber = widget.documentResolutionDto?.regNumber ?? '';
        documentTypeName = widget.documentResolutionDto?.statusName ?? '';
        date = widget.documentResolutionDto?.incomingDate ?? '';
        sendPurposeName = widget.documentResolutionDto?.statusName ?? '';
        ownerFullName = widget.documentResolutionDto?.enteredFullName ?? '';
        signerFullName = widget.documentResolutionDto?.enteredFullName ?? '';
      }
    });
  }
}

Future<String?> descriptionDialog({
  String initialText = '',
  required String title,
  required String confirmText,
  required BuildContext context,
  String rejectText = 'cancel',
}) {
  final controller = TextEditingController(text: initialText);

  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      void close([String? result]) {
        Navigator.of(context).pop(result);
        controller.dispose();
      }

      return AlertDialog(
        title: Text(title.tr()),
        content: TextField(
          maxLines: 1,
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
        ),
        actions: [
          TextButton(
            onPressed: close,
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
            child: Text(rejectText.tr()),
          ),
          TextButton(
            onPressed: () async {
              close(controller.text);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.importantInTaskCompleted,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
            child: Text(confirmText.tr()),
          )
        ],
      );
    },
  );
}
