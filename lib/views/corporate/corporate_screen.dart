import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/const/app_const.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';
import 'package:mobile_ung/core/theme/linear_progress.dart';
import 'package:mobile_ung/dto/corporate/corporate.dto.dart';
import 'package:mobile_ung/views/corporate/corporate_item.dart';

import '../../dto/document/document.income.dto.dart';
import '../../network/corporate_service.dart';
import '../home/home_screen.dart';

class CorporateScreen extends StatefulWidget {
  const CorporateScreen({super.key});

  @override
  State<CorporateScreen> createState() => _CorporateScreenState();
}

class _CorporateScreenState extends State<CorporateScreen> {
  List<CorporateDto>? listCorporate = [];
  bool _isLoading = false;
  int limit = 20;
  int startCount = 0, endCount = 20, totalCount = 0, pageIndex = 0;

  FetchMode fetchMode = FetchMode.infinitely;

  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      fetchCorporateList(const IncomeDocumentsBody(page: 0, limit: 20), query);
    });
  }

  Future<void> fetchCorporateList(IncomeDocumentsBody incomeDocumentBody, String value) async {
    try {
      setState(() {
        _isLoading = true;
        listCorporate = [];
      });
      final response = await CorporateService()
          .getCorporateList(data: IncomeDocumentsBody(page: incomeDocumentBody.page, limit: incomeDocumentBody.limit), value: value);
      setState(() {
        listCorporate = response.list;
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
    fetchCorporateList(IncomeDocumentsBody(page: pageIndex, limit: limit), '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: LinearProgress(
          isLoading: _isLoading,
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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

              ///list
              Stack(
                children: [
                  Column(
                    children: [
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listCorporate?.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 4, mainAxisSpacing: 4, crossAxisCount: 1, mainAxisExtent: 210),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: CorporateItem(
                              title: listCorporate?[index].employeeFullName ?? '',
                              yurDepName: listCorporate?[index].yurDepName ?? '',
                              departmentName: listCorporate?[index].departmentName ?? '',
                              position: listCorporate?[index].positionName ?? '',
                              phone: '${listCorporate?[index].mobilePhoneNumber}',
                              innerPhone: listCorporate?[index].innerPhoneNumber ?? '',
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: listCorporate != null,
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
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                      visible: listCorporate == [],
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              ),
            ]),
          ),
        ));
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
      fetchCorporateList(IncomeDocumentsBody(page: pageIndex, limit: limit), searchController.text);
    }
  }

  Future<void> _loadBack() async {
    if (fetchMode != FetchMode.infinitely) return;

    if (pageIndex > 0) {
      pageIndex = pageIndex - 1;
      endCount = (pageIndex + 1) * 20;
      startCount = endCount - 20;
      fetchCorporateList(IncomeDocumentsBody(page: pageIndex, limit: limit), searchController.text);
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
