import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/const/app_const.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';
import 'package:mobile_ung/core/theme/linear_progress.dart';
import 'package:mobile_ung/dto/project-menu/project.dto.dart';
import 'package:mobile_ung/network/project_service.dart';
import 'package:mobile_ung/views/project/project_child_list_screen.dart';
import 'package:mobile_ung/views/project/project_item_detail_screen.dart';

import '../../dto/document/document.income.dto.dart';
import '../home/home_screen.dart';
import 'project_item.dart';

// import '../home/task_item.dart';

class ProjectListScreen extends StatefulWidget {
  final int? selectedIndex;

  const ProjectListScreen({super.key, required this.selectedIndex});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  bool _isLoading = false;
  String? title;

  int limit = 20;
  int startCount = 0, endCount = 20, totalCount = 0, pageIndex = 0;

  FetchMode fetchMode = FetchMode.infinitely;

  List<ProjectDto>? listProject = [];
  final List<String> statusList = ['🟠  Faol', '🟢  Yakunlangan', '🔴 Muddati o\'tib yakunlandi'];
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (widget.selectedIndex == 1) {
        fetchProjectList(IncomeDocumentsBody(page: pageIndex, limit: limit), query);
      }
      if (widget.selectedIndex == 2) {
        fetchProjectListByYur(IncomeDocumentsBody(page: pageIndex, limit: limit), query);
      }
    });
  }

  Future<void> fetchProjectList(IncomeDocumentsBody incomeDocumentBody, String query) async {
    try {
      setState(() {
        _isLoading = true;
        listProject = [];
      });
      final response = await ProjectService()
          .getProjectList(data: IncomeDocumentsBody(page: incomeDocumentBody.page, limit: incomeDocumentBody.limit), value: query);
      setState(() {
        listProject = response.list;
        totalCount = response.total ?? 0;
      });
    } catch (error) {
      log('Error task $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchProjectListByYur(IncomeDocumentsBody incomeDocumentBody, String query) async {
    try {
      setState(() {
        _isLoading = true;
        listProject = [];
      });
      final response = await ProjectService()
          .getProjectListByYur(data: IncomeDocumentsBody(page: incomeDocumentBody.page, limit: incomeDocumentBody.limit), value: query);
      setState(() {
        listProject = response.list;
        totalCount = response.total ?? 0;
      });
    } catch (error) {
      log('Error task $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    /*
    *

    Most important work in any society in growth children.
    Taking care of children is arguably the most essential role in any society.
    Looking after children is arguably the most essential role within any society.
   *
    *  */
  }

  @override
  void initState() {
    super.initState();
    //callApi(widget.selectedIndex??0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.microtask(() async {
      if (widget.selectedIndex == 1) {
        title = context.tr('project_management');
        await fetchProjectList(IncomeDocumentsBody(page: pageIndex, limit: limit), '');
      } else if (widget.selectedIndex == 2) {
        title = context.tr('project_report');
        await fetchProjectListByYur(IncomeDocumentsBody(page: pageIndex, limit: limit), '');
      } else if (widget.selectedIndex == 3) {
        title = context.tr('project_monitoring');
      }
    });
/*    if (widget.selectedIndex == 1) {
      title = context.tr('project_management');
      fetchProjectList(IncomeDocumentsBody(page: pageIndex, limit: limit));
    } else if (widget.selectedIndex == 2) {
      title = context.tr('project_report');
      fetchProjectListByYur(IncomeDocumentsBody(page: pageIndex, limit: limit));
    } else if (widget.selectedIndex == 3) {
      title = context.tr('project_monitoring');
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        leadingWidth: 50,
        backgroundColor: AppColors.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 15),
            Image.asset(AppConst.logo0, width: 40, height: 50, fit: BoxFit.contain),
            Image.asset(AppConst.logo1, width: 220, height: 50, fit: BoxFit.contain),
          ],
        ),
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
                    '$title',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                /*

                ///select an orginazation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: CustomDropdownButtonFormField(
                    items: _items,
                    hintText: "Tashkilotni tanlang",
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 8,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      ///search
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(
                                  color: Colors.grey[200] ?? Colors.grey),
                              borderRadius:
                              BorderRadius.circular(12)),
                          child: const Padding(
                            padding:
                            EdgeInsets.only(left: 14, right: 8),
                            child: TextField(
                              maxLines:
                              1, // controller: userNameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Qidiruv',
                                hintStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                icon:
                                Icon(Icons.search_rounded),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 12,),
                      ///select an status

                   */
                /*   Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "Holati",
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            DropdownMenuItem(value: "Faol", child: Text("Faol")),
                            DropdownMenuItem(value: "Yakunlangan", child: Text("Yakunlangan")),
                            DropdownMenuItem(value: "Muddat o'tib yakunlandi", child: Text("Muddat o'tib yakunlandi")),
                          ],
                          onChanged: (value) {
                            // Handle status selection
                          },
                        ),
                      ),*/ /*

                      Expanded(
                        child: CustomDropdownButtonFormField(
                          items: statusList,
                          hintText: "Holatni tanlang",
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16,),
            */
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 2),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: Colors.grey[200] ?? Colors.grey),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4, right: 8.0),
                      child: TextField(
                        maxLines: 1,
                        controller: searchController,
                        onChanged: onSearchChanged, // Add this
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: context.tr('search'),
                          hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                          prefixIcon: const Icon(Icons.search_rounded),
                        ),
                      ),
                    ),
                  ),
                ),

                ///list
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Column(
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
                                      try {
                                        if (listProject?[index].child == null || listProject![index].child!.isEmpty) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ProjectItemDetailScreen(
                                                      projectDto: listProject?[index],
                                                    )),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ProjectChildListScreen(listProject: listProject?[index].child)),
                                          );
                                        }
                                      } catch (e) {
                                        log('Navigate to Project dto $e');
                                      }
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
                            const SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: listProject != null,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text('${startCount + 1} -- ${getEndCount()} , ${context.tr('total')} $totalCount'),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _loadBack(widget.selectedIndex ?? 0);
                                        },
                                        child: const SizedBox(
                                          height: 44,
                                          width: 46,
                                          child: Card(
                                            color: AppColors.buttonNext,
                                            child: Icon(color: AppColors.white, Icons.arrow_back_ios_new_rounded),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _loadMore(widget.selectedIndex ?? 0);
                                        },
                                        child: const SizedBox(
                                          height: 44,
                                          width: 46,
                                          child: Card(
                                            color: AppColors.buttonNext,
                                            child: Icon(color: AppColors.white, Icons.arrow_forward_ios_rounded),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadMore(int selectIndex) async {
    if (fetchMode != FetchMode.infinitely) return;

    if ((totalCount - limit * pageIndex) > 20) {
      startCount = endCount;

      if (totalCount > endCount + 20) {
        endCount = endCount + 20;
      } else {
        endCount = totalCount;
      }
      pageIndex = pageIndex + 1;
      callApi(selectIndex);
    }
  }

  Future<void> _loadBack(int selectIndex) async {
    if (fetchMode != FetchMode.infinitely) return;

    if (pageIndex > 0) {
      pageIndex = pageIndex - 1;
      endCount = (pageIndex + 1) * 20;
      startCount = endCount - 20;
      callApi(selectIndex);
    }
  }

  Future<void> callApi(int selectedIndex) async {
    if (widget.selectedIndex == 1) {
      title = context.tr('project_management');
      fetchProjectList(IncomeDocumentsBody(page: pageIndex, limit: limit), searchController.text);
    }
    if (widget.selectedIndex == 2) {
      title = context.tr('project_report');
      fetchProjectListByYur(IncomeDocumentsBody(page: pageIndex, limit: limit), searchController.text);
    }
    if (widget.selectedIndex == 3) {
      title = context.tr('project_monitoring');
      //   fetchProjectListByYur();
    }
  }

  int getEndCount() {
    if (totalCount < 20) {
      return totalCount;
    } else {
      return endCount;
    }
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
