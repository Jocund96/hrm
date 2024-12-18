import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';
import 'package:mobile_ung/core/theme/linear_progress.dart';
import 'package:mobile_ung/dto/task/task.income.dto.dart';
import 'package:mobile_ung/network/task_service.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../network/document_service.dart';

class TaskItemDetailScreen extends StatefulWidget {
  final TaskIncomeDto? taskIncomeDto;

  const TaskItemDetailScreen({super.key, this.taskIncomeDto});

  @override
  State<TaskItemDetailScreen> createState() => _TaskItemDetailScreenState();
}

class _TaskItemDetailScreenState extends State<TaskItemDetailScreen> {
  bool _isLoading = false;

  String base64Pdf = '';
  TaskIncomeDto? taskIncomeDto;

  Future<void> fetchProjectById(int id) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await TaskService().getTaskById(id);
      setState(() {
        taskIncomeDto = response;
      });
    } catch (error) {
      log('Error get project by id $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchAndOpenPdf(int id) async {
    setState(() {
      _isLoading = true;
    });

    try {
      base64Pdf = await DocumentService().getBase64(id);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      log('Error: $e');
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
    fetchProjectById(widget.taskIncomeDto?.id ?? 0);
    _fetchAndOpenPdf(widget.taskIncomeDto?.id ?? 0);

/*
    if(widget.documentIncomeDto?.sendPurposeName != null){
      isResolution =true;
    }
    if(widget.documentIncomeDto?.signerFullName != null){
      isSporis =true;
    }
*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        titleSpacing: 0,
        elevation: 1,
        leadingWidth: 50,
        centerTitle: true,
        title: Text(
          '№ ${taskIncomeDto?.id}',
          style: const TextStyle(fontSize: 20, color: AppColors.white),
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
                    visible: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr('task_name'),
                          style: const TextStyle(
                              // fontWeight: FontWeight.w500,
                              color: AppColors.hintText,
                              fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${taskIncomeDto?.title}',
                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    context.tr('end_date'),
                    style: const TextStyle(
                        // fontWeight: FontWeight.w500,
                        color: AppColors.hintText,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${taskIncomeDto?.beginDate} - ${taskIncomeDto?.endDate}',
                    style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    context.tr('status'),
                    style: const TextStyle(
                        // fontWeight: FontWeight.w500,
                        color: AppColors.hintText,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        color: getStatusColor(taskIncomeDto?.taskStatus ?? ''),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                          child: Text(getStatusDocument(context, taskIncomeDto?.taskStatus ?? ''),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.white,
                                fontWeight: FontWeight.w300,
                              )),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Card(
                        color: getStatusColorImportant(taskIncomeDto?.important ?? ''),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                          child: Text(getStatusDocumentImportant(context, taskIncomeDto?.important ?? ''),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.white,
                                fontWeight: FontWeight.w300,
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 0.3,
                    color: Colors.grey[400],
                    height: 5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    context.tr('participants'),
                    style: const TextStyle(
                        // fontWeight: FontWeight.w500,
                        color: AppColors.hintText,
                        fontSize: 14),
                  ),

                  GridView.builder(
                    itemCount: taskIncomeDto?.receivers?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, mainAxisSpacing: 0, crossAxisSpacing: 0, mainAxisExtent: 100),
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Row(
                              children: [
                                /*      FadeInImage.assetNetwork(
                            placeholder: 'assets/images/circle.png',
                            image: 'https://docflow.ung.uz/images/${projectResponse!.employees?[0].photoUploadPath}',
                            height: 60,
                            width: 60, ),
*/
                                Image.asset(
                                  'assets/images/circle.png',
                                  height: 60,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                // Expanded(
                                //child:
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        taskIncomeDto?.receivers?[index].receiverFullName ?? '',
                                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${taskIncomeDto?.receivers?[index].departmentName} / ${taskIncomeDto?.receivers?[index].staffPositionName}',
                                        style: const TextStyle(
                                            // fontWeight: FontWeight.w500,
                                            color: AppColors.hintText,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  width: 10,
                                ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Divider(
                              thickness: 0.3,
                              color: Colors.grey[400],
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  /*      Row(
                    children: [
                     /* FadeInImage.assetNetwork(
                        placeholder: 'assets/images/circle.png',
                        image: 'https://docflow.ung.uz/images/${projectResponse!.employees?[0].photoUploadPath}',
                        height: 60,
                        width: 60,

                      ),*/

                      Image.asset(
                          'assets/images/circle.png',
                          height: 60,),
                      const SizedBox(width: 10,),
                      // Expanded(
                        //child:
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(projectResponse?.employees?[0].employeeFullName ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 14
                                ),
                              ),

                              const SizedBox(height: 5,),

                              Text('${projectResponse?.employees?[0].departmentName} / ${projectResponse?.employees?[0].staffPositionName}',
                                style: TextStyle(
                                    // fontWeight: FontWeight.w500,
                                    color: AppColors.hint_text,
                                    fontSize: 14
                                ),
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(width: 10,),
                      // ),
            */

                  ///file
                  Visibility(
                    visible: base64Pdf.isNotEmpty,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr('file'),
                          style: const TextStyle(
                              // fontWeight: FontWeight.w500,
                              color: AppColors.hintText,
                              fontSize: 14),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () async {
                            await saveAndOpenPdf(base64Pdf, (taskIncomeDto?.id ?? 0).toString());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.pdfBg,
                                border: Border.all(color: AppColors.pdfStroke),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/pdf_image.png',
                                    height: 60,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  // Expanded(
                                  //child:
                                  Column(
                                    children: [
                                      Text(
                                        '${(taskIncomeDto?.id ?? 0)}.pdf',
                                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        pdfDate(taskIncomeDto?.beginDate),
                                        style: const TextStyle(
                                            // fontWeight: FontWeight.w500,
                                            color: AppColors.hintText,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  // ),
                                  Image.asset(
                                    'assets/images/eye.png',
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
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
    );
  }

  String getStatusDocument(BuildContext context, String status) {
    if (status == 'PLANNED') {
      return context.tr('planned');
    }
    if (status == 'COMPLETED') {
      return context.tr('completed');
    }
    if (status == 'FINISHED') {
      return context.tr('finished');
    }
    if (status == 'ACCEPTED') {
      return context.tr('accepted');
    }
    if (status == 'SEND') {
      return context.tr('send');
    }
    if (status == 'REJECTED') {
      return context.tr('rejected');
    }
    if (status == 'EXPIRED') {
      return context.tr('expired');
    }
    if (status == 'SEEN') {
      return context.tr('seen');
    }

    return '';
  }

  String getStatusDocumentImportant(BuildContext context, String important) {
    if (important == 'VERY_FAST') {
      return context.tr('very_fast');
    }
    if (important == 'FAST') {
      return context.tr('fast');
    }
    if (important == 'FASTER') {
      return context.tr('faster');
    }
    if (important == 'SLOW') {
      return context.tr('slow');
    }

    return '';
  }

  Color getStatusColor(String status) {
    if (status == 'PLANNED') {
      return AppColors.importantInTaskItem;
    }
    if (status == 'COMPLETED') {
      return AppColors.sendInTaskItem;
    }
    if (status == 'ACCEPTED') {
      return AppColors.importantInTaskItem;
    }
    if (status == 'SEND') {
      return AppColors.importantInTaskItem;
    }
    if (status == 'REJECTED') {
      return AppColors.sendInTaskItem;
    }
    if (status == 'EXPIRED') {
      return AppColors.sendInTaskItem;
    }
    return AppColors.sendInTaskItem;
  }

  Color getStatusColorImportant(String important) {
    if (important == 'VERY_FAST') {
      return AppColors.importantInTaskHigh;
    }
    if (important == 'FAST') {
      return AppColors.importantInTaskItem;
    }
    if (important == 'FASTER') {
      return AppColors.sendInTaskItem;
    }
    if (important == 'SLOW') {
      return AppColors.importantInTaskItem;
    }
    return AppColors.sendInTaskItem;
  }

  String pdfDate(String? documentIncomeDto) {
    String s = documentIncomeDto ?? '';
    if (s.isNotEmpty || s != '') {
      return s.substring(0, 10);
    }
    return '';
  }
}
