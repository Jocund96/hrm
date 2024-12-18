import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';
import 'package:mobile_ung/core/theme/linear_progress.dart';
import 'package:mobile_ung/dto/document/document.income.dto.dart';
import 'package:mobile_ung/dto/document/document.menu.dto.dart';
import 'package:mobile_ung/dto/document/document.resolution.dto.dart';
import 'package:mobile_ung/network/document_service.dart';
import 'package:mobile_ung/views/document/document_item_detail.dart';

import '../home/home_screen.dart';
import 'document_item.dart';

class DocumentListScreen extends StatefulWidget {
  final int typeDocument;

  const DocumentListScreen({super.key, required this.typeDocument});

  @override
  State<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends State<DocumentListScreen> {
  bool _isLoading = false;
  int selectIndex = 0;

  int countDocumentIncome = 0;
  int countDocumentSend = 0;
  int countDocumentRegistration = 0;
  int countDocumentResolution = 0;

  int limit = 20;
  int startCount = 0, endCount = 20, totalCount = 0, pageIndex = 0;

  List<DocumentIncomeDto>? listDocumentIncome = [];
  List<DocumentIncomeDto>? listDocumentSend = [];
  List<DocumentIncomeDto>? listDocumentRegistration = [];
  List<DocumentResolutionDto>? listDocumentResolution = [];

  FetchMode fetchMode = FetchMode.infinitely;

  List<DocumentMenuDto>? listMenu;

  Future<void> fetchDocumentIncomeData(IncomeDocumentsBody incomeDocumentBody) async {
    try {
      setState(() {
        _isLoading = true;
        listDocumentIncome = [];
      });
      final response = await DocumentService.getDocumentIncome(
        data: IncomeDocumentsBody(page: incomeDocumentBody.page, limit: incomeDocumentBody.limit),
      );
      setState(() {
        listDocumentIncome = response.list;
        countDocumentIncome = response.total ?? 0;
        listMenu?[0].count = response.total;
        totalCount = response.total ?? 0;
        // listMenu?[0].count = allCount();
      });
    } catch (error) {
      log('Error task $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchDocumentSendData(IncomeDocumentsBody incomeDocumentBody) async {
    try {
      setState(() {
        _isLoading = true;
        listDocumentIncome = [];
      });
      final response = await DocumentService().getDocumentSend(
        data: IncomeDocumentsBody(page: incomeDocumentBody.page, limit: incomeDocumentBody.limit),
      );
      setState(() {
        listDocumentIncome = response.list;
        countDocumentSend = response.total ?? 0;
        listMenu?[1].count = response.total;
        totalCount = response.total ?? 0;
        // listMenu?[0].count = allCount();
        log('Response task Send: ${response.list}');
      });
    } catch (error) {
      log('Error task $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchDocumentRegistrationData(IncomeDocumentsBody incomeDocumentBody) async {
    try {
      setState(() {
        listDocumentResolution = [];
        listDocumentIncome = [];
        _isLoading = true;
        totalCount = 0;
        startCount = -1;
        pageIndex = 0;
      });
      final response = await DocumentService.getDocumentRegistration(
        data: IncomeDocumentsBody(page: incomeDocumentBody.page, limit: incomeDocumentBody.limit),
      );
      setState(() {
        listDocumentResolution = response.list;
        countDocumentRegistration = response.total ?? 0;
        listMenu?[2].count = response.total;
        totalCount = response.total ?? 0;
        // listMenu?[0].count = allCount();
      });
    } catch (error) {
      log('Error task $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchDocumentResolutionData(IncomeDocumentsBody incomeDocumentBody) async {
    try {
      setState(() {
        listDocumentResolution = [];
        _isLoading = true;
      });
      final response = await DocumentService.getDocumentResolution(
        data: IncomeDocumentsBody(page: incomeDocumentBody.page, limit: incomeDocumentBody.limit),
      );
      setState(() {
        listDocumentResolution = response.list;
        countDocumentResolution = response.total ?? 0;
        listMenu?[3].count = response.total;
        totalCount = response.total ?? 0;
        // listMenu?[0].count = allCount();
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
  void didChangeDependencies() {
    super.didChangeDependencies();

    listMenu = [
      DocumentMenuDto(1, context.tr('incoming'), 0),
      DocumentMenuDto(2, context.tr('outgoing'), 0),
      DocumentMenuDto(3, context.tr('chancellery'), 0),
      DocumentMenuDto(4, context.tr('control'), 0),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        titleSpacing: 0,
        elevation: 1,
        leadingWidth: 50,
        centerTitle: true,
        title: const Text(
          'Barcha hujjatlar',
          style: TextStyle(fontSize: 20, color: AppColors.white),
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: LinearProgress(
        isLoading: _isLoading,
        child: Column(children: [
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 6),
              child: ListView.builder(
                itemCount: listMenu?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      selectIndex = index;
                      startCount = 0;
                      endCount = 20;
                      pageIndex = 0;

                      if (selectIndex == 0) {
                        fetchDocumentIncomeData(IncomeDocumentsBody(page: pageIndex, limit: limit));
                      }
                      if (selectIndex == 1) {
                        fetchDocumentSendData(IncomeDocumentsBody(page: pageIndex, limit: limit));
                      }
                      if (selectIndex == 2) {
                        fetchDocumentRegistrationData(IncomeDocumentsBody(page: pageIndex, limit: limit));
                      }
                      if (selectIndex == 3) {
                        fetchDocumentResolutionData(IncomeDocumentsBody(page: pageIndex, limit: limit));
                      }
                    },
                    child: MenuCategory(
                      name: listMenu?[index].name ?? '',
                      count: listMenu?[index].count ?? 0,
                      index: index,
                      selectedIndex: selectIndex,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 4.0,
                    mainAxisExtent: 150,
                  ),
                  itemCount: getListCount(),
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        if (selectIndex == 0 || selectIndex == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DocumentItemDetail(
                                documentIncomeDto: listDocumentIncome?[index],
                                selectedIndex: selectIndex,
                              ),
                            ),
                          );
                        }
                        if (selectIndex == 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DocumentItemDetail(
                                documentResolutionDto: listDocumentResolution?[index],
                                selectedIndex: selectIndex,
                              ),
                            ),
                          );
                        }
                      },
                      child: DocumentItem(
                        regNumber: getRegNumber(index),
                        date: getDate(index),
                        documentTypeName: getDocumentType(index),
                        statusName: getStatusName(index),
                        universalDocumentId: getUniversalDocumentId(index),
                      ),
                    );
                  }),
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
      ),
    );
  }

  // int allCount() {
  //   int s = 0;
  //   listMenu?[0].count = 0;
  //   try {
  //     for (int i = 0; i < listMenu!.length; i++) {
  //       s += listMenu![i].count!;
  //     }
  //     return s;
  //   } catch (e) {
  //     log(e);
  //   }
  //   return 0;
  // }

  @override
  void initState() {
    ///devonxona
    if (widget.typeDocument == 0) {
      fetchDocumentRegistrationData(IncomeDocumentsBody(page: pageIndex, limit: limit));
      selectIndex = 2;
    }

    ///kiruvchi
    if (widget.typeDocument == 1) {
      fetchDocumentIncomeData(IncomeDocumentsBody(page: pageIndex, limit: limit));
      selectIndex = 0;
    }

    ///nazorat
    if (widget.typeDocument == 2) {
      fetchDocumentResolutionData(IncomeDocumentsBody(page: pageIndex, limit: limit));
      selectIndex = 3;
    }

    ///chiquvchi
    if (widget.typeDocument == 3) {
      fetchDocumentSendData(IncomeDocumentsBody(page: pageIndex, limit: limit));
      selectIndex = 1;
    }

    super.initState();
  }

  int? getListCount() {
    if (selectIndex == 0 || selectIndex == 1) {
      return listDocumentIncome?.length;
    }
    if (selectIndex == 2 || selectIndex == 3) {
      return listDocumentResolution?.length;
    }
    return null;
  }

  String getRegNumber(int index) {
    if (selectIndex == 0) {
      return listDocumentIncome?[index].regNumber ?? '';
    }
    if (selectIndex == 1) {
      return listDocumentIncome?[index].prefix ?? '';
    }
    if (selectIndex == 3) {
      return listDocumentResolution?[index].regNumber ?? '';
    }
    return '';
  }

  String getDate(int index) {
    if (selectIndex == 0 || selectIndex == 1) {
      return listDocumentIncome?[index].date ?? '';
    }
    if (selectIndex == 2) {
      return listDocumentResolution?[index].incomeDate ?? '';
    }
    if (selectIndex == 3) {
      return listDocumentResolution?[index].incomingDate ?? '';
    }
    return '';
  }

  String getDocumentType(int index) {
    if (selectIndex == 0 || selectIndex == 1) {
      return listDocumentIncome?[index].documentTypeName ?? '';
    }
    if (selectIndex == 2) {
      return listDocumentResolution?[index].incomeTypeName ?? '';
    }
    if (selectIndex == 3) {
      return listDocumentResolution?[index].documentId.toString() ?? '';
    }
    return '';
  }

  String getStatusName(int index) {
    if (selectIndex == 0 || selectIndex == 1) {
      return listDocumentIncome?[index].statusName ?? '';
    }
    if (selectIndex == 2) {
      return listDocumentResolution?[index].statusName ?? '';
    }
    if (selectIndex == 3) {
      return listDocumentResolution?[index].statusName ?? '';
    }
    return '';
  }

  String getUniversalDocumentId(int index) {
    if (selectIndex == 0 || selectIndex == 1) {
      return listDocumentIncome?[index].universalDocumentId.toString() ?? '';
    }
    if (selectIndex == 2) {
      return listDocumentResolution?[index].incomeRegNumber ?? '';
    }
    if (selectIndex == 3) {
      return listDocumentResolution?[index].universalDocumentId.toString() ?? '';
    }
    return '';
  }

  onRefresh() {
    if (selectIndex == 0) {
      fetchDocumentIncomeData(IncomeDocumentsBody(page: pageIndex, limit: limit));
    }
    if (selectIndex == 1) {
      fetchDocumentSendData(IncomeDocumentsBody(page: pageIndex, limit: limit));
    }
    if (selectIndex == 2) {
      fetchDocumentRegistrationData(IncomeDocumentsBody(page: pageIndex, limit: limit));
    }
    if (selectIndex == 3) {
      fetchDocumentResolutionData(IncomeDocumentsBody(page: pageIndex, limit: limit));
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
        fetchDocumentIncomeData(IncomeDocumentsBody(page: pageIndex, limit: limit));
      }
      if (selectIndex == 1) {
        fetchDocumentSendData(IncomeDocumentsBody(page: pageIndex, limit: limit));
      }
      if (selectIndex == 2) {
        fetchDocumentRegistrationData(IncomeDocumentsBody(page: pageIndex, limit: limit));
      }
      if (selectIndex == 3) {
        fetchDocumentResolutionData(IncomeDocumentsBody(page: pageIndex, limit: limit));
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
        fetchDocumentIncomeData(IncomeDocumentsBody(page: pageIndex, limit: limit));
      }
      if (selectIndex == 1) {
        fetchDocumentSendData(IncomeDocumentsBody(page: pageIndex, limit: limit));
      }
      if (selectIndex == 2) {
        fetchDocumentRegistrationData(IncomeDocumentsBody(page: pageIndex, limit: limit));
      }
      if (selectIndex == 3) {
        fetchDocumentResolutionData(IncomeDocumentsBody(page: pageIndex, limit: limit));
      }
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

class MenuCategory extends StatelessWidget {
  final String name;
  final int count;
  final int index;
  final int selectedIndex;

  const MenuCategory({super.key, required this.name, required this.count, required this.index, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: selectedIndex == index ? AppColors.menuSelected : AppColors.menuUnselected,
            ),
            height: 117,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: IntrinsicWidth(
                    child: Row(children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: selectedIndex == index ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(color: AppColors.countDocument, borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 0.0),
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ])),
              ),
            )));
  }
}
