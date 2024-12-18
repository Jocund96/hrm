import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';
import 'package:mobile_ung/core/theme/linear_progress.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../dto/project-menu/project.dto.dart';
import '../../network/document_service.dart';
import '../../network/project_service.dart';

// import '../home/task_item.dart';

class ProjectItemDetailScreen extends StatefulWidget {
  final ProjectDto? projectDto;
  final int? selectedIndex;

  const ProjectItemDetailScreen({super.key, this.projectDto, this.selectedIndex});

  @override
  State<ProjectItemDetailScreen> createState() => _ProjectItemDetailScreenState();
}

class _ProjectItemDetailScreenState extends State<ProjectItemDetailScreen> {
  bool _isLoading = false;

  String base64Pdf = '';
  ProjectDto? projectResponse;

  Future<void> fetchProjectById(int id) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await ProjectService().getProjectById(id);
      setState(() {
        projectResponse = response;
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
    fetchProjectById(widget.projectDto?.id ?? 0);
    _fetchAndOpenPdf(widget.projectDto?.id ?? 0);

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
          '№ ${projectResponse?.id}',
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
                          '${projectResponse?.name}',
                          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    context.tr('task_theme'),
                    style: const TextStyle(
                        // fontWeight: FontWeight.w500,
                        color: AppColors.hintText,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${projectResponse?.description}',
                    style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14),
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
                    '${projectResponse?.start} - ${projectResponse?.end}',
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
                      /*   Card(
                          color: AppColors.important_in_task_item,
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(getStatusDocument(),
                                style: TextStyle(fontSize: 12, color: AppColors.white, fontWeight: FontWeight.w300,)),
                          ),
                        ),
                        SizedBox(width: 10),*/
                      Card(
                        color: getStatusColor(projectResponse?.status ?? ''),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                          child: Text(getStatusDocument(context, projectResponse?.status ?? ''),
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
                    itemCount: projectResponse?.employees?.length ?? 0,
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
                                        projectResponse?.employees?[index].employeeFullName ?? '',
                                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${projectResponse?.employees?[index].departmentName} / ${projectResponse?.employees?[index].staffPositionName}',
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
                            await saveAndOpenPdf(base64Pdf, (projectResponse?.id ?? 0).toString());
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
                                        '${(projectResponse?.id ?? 0)}.pdf',
                                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        pdfDate(projectResponse?.start),
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
    if (status == 'CREATED') {
      return context.tr('created');
    }
    if (status == 'FINISHED') {
      return context.tr('finished');
    }
    if (status == 'PROCESS') {
      return context.tr('process');
    }
    if (status == 'SIGN_NEED') {
      return context.tr('sign_need');
    }
    if (status == 'EXPIRED_FINISHED') {
      return context.tr('expired_finished');
    }
    if (status == 'EXPIRED') {
      return context.tr('expired');
    }
    if (status == 'SEEN') {
      return context.tr('seen');
    }

    return '';
  }

  Color getStatusColor(String status) {
    if (status == 'CREATED') {
      return AppColors.importantInTaskItem;
    }
    if (status == 'FINISHED') {
      return AppColors.sendInTaskItem;
    }
    if (status == 'PROCESS') {
      return AppColors.importantInTaskItem;
    }
    if (status == 'SIGN_NEED') {
      return AppColors.importantInTaskItem;
    }
    if (status == 'EXPIRED_FINISHED') {
      return AppColors.sendInTaskItem;
    }
    if (status == 'EXPIRED') {
      return AppColors.importantInTaskHigh;
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
