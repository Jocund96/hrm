import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/const/app_const.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';
import 'package:mobile_ung/core/theme/linear_progress.dart';
import 'package:mobile_ung/dto/project-menu/project.dto.dart';
import 'package:mobile_ung/views/project/project_item.dart';
import 'package:mobile_ung/views/project/project_item_detail_screen.dart';

class ProjectChildListScreen extends StatefulWidget {
  final List<ProjectDto>? listProject;

  const ProjectChildListScreen({super.key, required this.listProject});

  @override
  State<ProjectChildListScreen> createState() => _ProjectChildListScreenState();
}

class _ProjectChildListScreenState extends State<ProjectChildListScreen> {
  final bool _isLoading = false;
  String? title;

  List<ProjectDto>? listProject = [];

  @override
  void initState() {
    super.initState();
    listProject = widget.listProject;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        titleSpacing: 0,
        elevation: 1,
        leadingWidth: 50,
        centerTitle: true,
        title: Text(
          context.tr('project_mng_dc'),
          style: const TextStyle(fontSize: 18, color: AppColors.white),
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: LinearProgress(
            isLoading: _isLoading,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Text(
                    '${context.tr('project_management')} - ${listProject?.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                ///list

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listProject?.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisExtent: 180),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ProjectItemDetailScreen(projectDto: listProject?[index])),
                                  );
                                },
                                child: Wrap(children: [
                                  ProjectItem(
                                    title: listProject?[index].name ?? '',
                                    description: listProject?[index].description ?? '',
                                    leader: '',
                                    dateRange:
                                        '${listProject?[index].start?.substring(0, 10)}-${listProject?[index].end?.substring(0, 10)}',
                                    status: listProject?[index].status ?? '',
                                  ),
                                ]),
                              );
                            },
                          ),
                        ),
                        Visibility(
                            visible: false,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  SizedBox(
                                    height: 168,
                                    width: 226,
                                    child: Image.asset(
                                      AppConst.noContent,
                                      width: 226,
                                      height: 168,
                                    ),
                                  ),
                                ]))
                      ],
                    )
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDropdownButtonFormField extends StatelessWidget {
  final List<String> items;
  final String? hintText;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownButtonFormField({
    super.key,
    required this.items,
    this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.hintColor, fontSize: 14, fontWeight: FontWeight.w400),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: AppColors.dropMenuBorderColor, width: 1.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.dropMenuBorderColor, width: 1.0), // Enabled border color
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      icon: Image.asset(
        AppConst.arrowDown,
        height: 24,
        width: 24,
      ),
      style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w400),
      dropdownColor: Colors.white,
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
