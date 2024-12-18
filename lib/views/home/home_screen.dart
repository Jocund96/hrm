import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';
import 'package:mobile_ung/core/theme/linear_progress.dart';
import 'package:mobile_ung/dto/project-dashboard/project.dashboard.dto.dart';
import 'package:mobile_ung/views/home/project_task_item_detail.dart';

import '../../dto/project-task/project.task.dto.dart';
import '../../dto/project-task/project.task.list.dto.dart';
import '../../network/dashboard_service.dart';
import 'project_task_item_view.dart';
import 'project_dashboard_item.dart';

enum FetchMode { pagination, infinitely }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  bool _isLoading = false;

  ProjectDashboardDto? parentDashboard;
  ProjectDashboardDto? subDashboard;
  ProjectDashboardDto? taskDashboard;
  ProjectDashboardDto? subTaskDashboard;

  DateTime? selectedDateTime;
  List<ProjectTaskDto>? listProjectTask = [];

  int pageIndex = 0;
  int limit = 20;
  int startCount = 0, endCount = 20, totalCount = 0;

  FetchMode fetchMode = FetchMode.infinitely;

  Timer? _debounce;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchProjectTaskData(const IncomeDocumentsBody(page: 0, limit: 20), query);
    });
  }

  Future<void> fetchProjectTaskData(IncomeDocumentsBody incomeDocumentBody, String value) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await DashboardService()
          .getProjectTaskData(data: IncomeDocumentsBody(page: incomeDocumentBody.page, limit: incomeDocumentBody.limit), value: value);
      setState(() {
        listProjectTask = response.list;
        totalCount = response.total ?? 0;
        log('limitt $limit == $pageIndex dif: ${(totalCount - limit * (pageIndex + 1))}');
        log('Response task: ${response.list}');
      });
    } catch (error) {
      log('Error task $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchProjectDashboardParentData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await DashboardService().getProjectDashboardParentData();
      setState(() {
        parentDashboard = response;
        log('parent: ${parentDashboard?.create},  ${parentDashboard?.expired},  ${parentDashboard?.finish}, ');
      });
    } catch (error) {
      log('Error task $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchProjectDashboardSubData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await DashboardService().getProjectDashboardSubData();
      setState(() {
        subDashboard = response;
        log('parent: ${subDashboard?.create},  ${subDashboard?.expired},  ${subDashboard?.finish}, ');
      });
    } catch (error) {
      log('Error task $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchProjectDashboardTaskData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await DashboardService().getProjectDashboardTaskData();
      setState(() {
        taskDashboard = response;
        log('parent: ${taskDashboard?.create},  ${taskDashboard?.expired},  ${taskDashboard?.finish}, ');
      });
    } catch (error) {
      log('Error task $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchProjectDashboardSubTaskData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await DashboardService().getProjectDashboardSubTaskData();
      setState(() {
        subTaskDashboard = response;
        log('parent: ${subTaskDashboard?.create},  ${subTaskDashboard?.expired},  ${subTaskDashboard?.finish}, ');
      });
    } catch (error) {
      log('Error task $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  Future<void> fetchAll() async {
    fetchProjectTaskData(IncomeDocumentsBody.initial, '');
    fetchProjectDashboardParentData();
    fetchProjectDashboardSubData();
    fetchProjectDashboardTaskData();
    fetchProjectDashboardSubTaskData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhite,
      body: SafeArea(
        child: LinearProgress(
          isLoading: _isLoading,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                    context.tr('project_management'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    height: 455,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ProjectDashboardItem(
                                name: context.tr('projects'),
                                count: (parentDashboard?.create ?? 0) +
                                    (parentDashboard?.process ?? 0) +
                                    (parentDashboard?.finish ?? 0) +
                                    (parentDashboard?.expired ?? 0),
                                notStarted: parentDashboard?.create ?? 0,
                                inProgress: parentDashboard?.process ?? 0),
                            ProjectDashboardItem(
                                name: context.tr('events'),
                                count: (subDashboard?.create ?? 0) +
                                    (subDashboard?.process ?? 0) +
                                    (subDashboard?.finish ?? 0) +
                                    (subDashboard?.expired ?? 0),
                                notStarted: subDashboard?.create ?? 0,
                                inProgress: subDashboard?.process ?? 0),
                          ],
                        ),
                        Row(
                          children: [
                            ProjectDashboardItem(
                                name: context.tr('mechanism'),
                                count: (taskDashboard?.create ?? 0) +
                                    (taskDashboard?.process ?? 0) +
                                    (taskDashboard?.finish ?? 0) +
                                    (taskDashboard?.expired ?? 0),
                                notStarted: taskDashboard?.create ?? 0,
                                inProgress: taskDashboard?.process ?? 0),
                            ProjectDashboardItem(
                                name: context.tr('sub_mechanism'),
                                count: (subTaskDashboard?.create ?? 0) +
                                    (subTaskDashboard?.process ?? 0) +
                                    (subTaskDashboard?.finish ?? 0) +
                                    (subTaskDashboard?.expired ?? 0),
                                notStarted: subTaskDashboard?.create ?? 0,
                                inProgress: subTaskDashboard?.process ?? 0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ///calendar would use next
                /*                Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          context.tr('calendar'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          elevation: 1.0,
                          color: AppColors.white,
                          child: TableCalendar(
                            firstDay: DateTime.utc(2000, 01, 01),
                            lastDay: DateTime.utc(2100, 12, 12),
                            focusedDay: _focusedDay,
                            selectedDayPredicate: (day) {
                              return isSameDay(_selectedDay, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay =
                                    focusedDay; // update `_focusedDay` here as well
                              });
                            },
                            onPageChanged: (focusedDay) {
                              _focusedDay = focusedDay;
                            },
                            calendarStyle: const CalendarStyle(
                              todayDecoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: Colors.blueAccent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            headerStyle: const HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                            ),
                          ),
                        ),
                      ),*/
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('my_tasks'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      //                                    prefixIcon: Icon(Icons.search),
                      Card(
                        color: AppColors.white,
                        elevation: 1.0,
                        child: Column(
                          children: [
                            ///search in later
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
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
                            // SizedBox(height: 16),
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listProjectTask?.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1, mainAxisSpacing: 4, crossAxisSpacing: 4, mainAxisExtent: 125),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProjectTaskItemDetail(projectTaskDto: listProjectTask?[index])),
                                    );
                                  },
                                  child: Wrap(children: [
                                    ProjectTaskItemView(
                                      date: listProjectTask?[index].endDate ?? '',
                                      title: listProjectTask?[index].cardName ?? '',
                                      body: listProjectTask?[index].projectName ?? '',
                                    ),
                                  ]),
                                );
                              },
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text('$startCount -- $endCount , ${context.tr("total")} $totalCount'),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _loadBack();
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
                                        _loadMore();
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
                            )
                          ],
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
    );
  }

  Future<void> _loadMore() async {
    if (fetchMode != FetchMode.infinitely) return;

    if ((totalCount - limit * pageIndex) > 20) {
      startCount = endCount;

      if (totalCount > endCount + 20) {
        endCount = endCount + 20;
      } else {
        endCount = totalCount;
      }

      pageIndex = pageIndex + 1;
      fetchProjectTaskData(IncomeDocumentsBody(page: pageIndex, limit: limit), searchController.text);
    }
  }

  Future<void> _loadBack() async {
    if (fetchMode != FetchMode.infinitely) return;

    if (pageIndex > 0) {
      pageIndex = pageIndex - 1;
      endCount = (pageIndex + 1) * 20;
      startCount = endCount - 20;
      fetchProjectTaskData(IncomeDocumentsBody(page: pageIndex, limit: limit), searchController.text);
    }
  }
}
