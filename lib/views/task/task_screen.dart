import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';
import 'package:mobile_ung/core/theme/linear_progress.dart';
import 'package:mobile_ung/network/task_service.dart';
import 'package:mobile_ung/views/task/task_item.dart';
import 'package:mobile_ung/views/task/task_item_detail_screen.dart';

import '../../dto/document/document.income.dto.dart';
import '../../dto/task/task.income.dto.dart';
import '../home/home_screen.dart';

// import '../home/task_item.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
/*  int index1 = 1;
  int index2 = 0;*/
  int selectIndex = 0;
  List<TaskIncomeDto>? listTask = [];
  bool _isLoading = false;

  int limit = 20;
  int startCount = 0, endCount = 20, totalCount = 0, pageIndex = 0;

  FetchMode fetchMode = FetchMode.infinitely;
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (selectIndex == 0) {
        fetchTaskIncomeList(IncomeDocumentsBody(page: pageIndex, limit: limit), query);
      }
      if (selectIndex == 1) {
        fetchTaskSendList(IncomeDocumentsBody(page: pageIndex, limit: limit), query);
      }
    });
  }

  Future<void> fetchTaskIncomeList(IncomeDocumentsBody incomeDocumentBody, String query) async {
    try {
      setState(() {
        _isLoading = true;
        listTask = [];
      });
      final response = await TaskService()
          .getTaskIncomeList(data: IncomeDocumentsBody(page: incomeDocumentBody.page, limit: incomeDocumentBody.limit), value: query);
      setState(() {
        listTask = response.list;
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

  Future<void> fetchTaskSendList(IncomeDocumentsBody incomeDocumentBody, String query) async {
    try {
      setState(() {
        _isLoading = true;
        listTask = [];
      });
      final response = await TaskService()
          .getTaskSendList(data: IncomeDocumentsBody(page: incomeDocumentBody.page, limit: incomeDocumentBody.limit), value: query);
      setState(() {
        listTask = response.list;
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

  @override
  void initState() {
    super.initState();
    fetchTaskIncomeList(IncomeDocumentsBody(page: pageIndex, limit: limit), '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: LinearProgress(
          isLoading: _isLoading,
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),

            ///income and created
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        /*index1 = 1;
                                        index2 = 0;*/

                        ///income
                        selectIndex = 0;
                        fetchTaskIncomeList(IncomeDocumentsBody(page: pageIndex, limit: limit), searchController.text);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: selectIndex == 0 ? AppColors.buttonSelect : AppColors.buttonUnselect,
                        ),
                        height: 36,
                        child: Center(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: IntrinsicWidth(
                                    child: Text(
                                  context.tr('income'),
                                  style: const TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w600),
                                )))),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        /*  index1 = 0;
                                        index2 = 1;*/

                        ///send
                        selectIndex = 1;
                        fetchTaskSendList(IncomeDocumentsBody(page: pageIndex, limit: limit), searchController.text);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: selectIndex == 1 ? AppColors.buttonSelect : AppColors.buttonUnselect,
                        ),
                        height: 36,
                        child: Center(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: IntrinsicWidth(
                                    child: Text(
                                  context.tr('built'),
                                  style: const TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w600),
                                )))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 16,),

            ///search and done
            /*    Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Row(children: [
                                    Expanded(child: Container(decoration: BoxDecoration(
                                        color: AppColors.white,
                                        border: Border.all(
                                            color: Colors.grey[200] ?? Colors.grey),
                                        borderRadius: BorderRadius.circular(12)),
                                      child: const Padding(padding: EdgeInsets.only(
                                          left: 14, right: 8),
                                        child: TextField(
                                          maxLines: 1, // controller: userNameController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Qidiruv',
                                            hintStyle: TextStyle(fontSize: 15,
                                                fontWeight: FontWeight.normal),
                                            icon: Icon(Icons.search_rounded),),),),),),
                                    const SizedBox(width: 16,),
                                    const Text('TUGATILGAN', style: TextStyle(
                                      fontSize: 14.0, fontWeight: FontWeight.w600,),),
                                    const SizedBox(width: 16,),
                                    SizedBox(height: 24,
                                      width: 24,
                                      child: Image.asset(
                                        AppConst.checkbox, width: 24, height: 24,),),
                                  ],),),*/
            // const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 0),
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

            /// list task

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  itemCount: listTask?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisExtent: 206),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TaskItemDetailScreen(taskIncomeDto: listTask?[index])),
                        );
                      },
                      child: TaskItem(
                        title: listTask?[index].title ?? '',
                        description: listTask?[index].directorDepartmentName ?? '',
                        leader: listTask?[index].directorFullName ?? '',
                        dateRange: '${listTask?[index].beginDate?.substring(0, 10)}-${listTask?[index].endDate?.substring(0, 10)}',
                        status: listTask?[index].taskStatus ?? '',
                        important: listTask?[index].important ?? '',
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text('${startCount + 1} -- ${getEndCount()}, ${context.tr('total')} $totalCount'),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _loadBack(selectIndex);
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
                        _loadMore(selectIndex);
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
          ]),
        ));
  }

  int getEndCount() {
    if (totalCount < 20) {
      return totalCount;
    } else {
      return endCount;
    }
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
      if (selectIndex == 0) {
        fetchTaskIncomeList(IncomeDocumentsBody(page: pageIndex, limit: limit), searchController.text);
      }
      if (selectIndex == 1) {
        fetchTaskSendList(IncomeDocumentsBody(page: pageIndex, limit: limit), searchController.text);
      }
    }
  }

  Future<void> _loadBack(int selectIndex) async {
    if (fetchMode != FetchMode.infinitely) return;

    if (pageIndex > 0) {
      pageIndex = pageIndex - 1;
      endCount = (pageIndex + 1) * 20;
      startCount = endCount - 20;
      if (selectIndex == 0) {
        fetchTaskIncomeList(IncomeDocumentsBody(page: pageIndex, limit: limit), searchController.text);
      }
      if (selectIndex == 1) {
        fetchTaskSendList(IncomeDocumentsBody(page: pageIndex, limit: limit), searchController.text);
      }
    }
  }
}
