import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';

import '../../dto/project-task/project.task.dto.dart';

class ProjectTaskItemDetail extends StatefulWidget {
  final ProjectTaskDto? projectTaskDto;

  const ProjectTaskItemDetail({super.key, required this.projectTaskDto});

  @override
  State<ProjectTaskItemDetail> createState() => _ProjectTaskItemDetailState();
}

class _ProjectTaskItemDetailState extends State<ProjectTaskItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        titleSpacing: 0,
        elevation: 1,
        leadingWidth: 50,
        centerTitle: true,
        title: Text(
          '${context.tr('project')}: ${widget.projectTaskDto?.projectId}',
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.projectTaskDto?.cardName}',
                style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${widget.projectTaskDto?.endDate}}',
                style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54, fontSize: 13),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                '${widget.projectTaskDto?.projectName}',
                style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 13),
              ),
              const SizedBox(height: 16),
              Text(
                '${widget.projectTaskDto?.ownerFullName}',
                style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
