import 'package:flutter/material.dart';
import 'package:mobile_ung/core/const/app_const.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';

import '../project/project__list_screen.dart';

class TaskCreateScreen extends StatefulWidget {
  const TaskCreateScreen({super.key});

  @override
  State<TaskCreateScreen> createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  final List<String> _items = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // appBar: AppBar(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        titleSpacing: 0,
        elevation: 1,
        leadingWidth: 50,
        centerTitle: true,
        title: const Text(
          'Topshiriq nomi',
          style: TextStyle(fontSize: 20, color: AppColors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Topshiriq nomi',
                style: TextStyle(
                    // fontWeight: FontWeight.w500,
                    color: AppColors.hintText,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: Colors.grey[200] ?? Colors.grey),
                    borderRadius: BorderRadius.circular(12)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    maxLines: 1, // controller: userNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Topshiriq nomini kiriting',
                      hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              /// rahbar
              const Text(
                'Rahbar',
                style: TextStyle(
                    // fontWeight: FontWeight.w500,
                    color: AppColors.hintText,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomDropdownButtonFormField(
                items: _items,
                hintText: 'Rahbarni tanlang',
                onChanged: (value) {
                  setState(() {});
                },
              ),

              const SizedBox(
                height: 12,
              ),
              const Text(
                'Tugash sanasi va vaqti',
                style: TextStyle(
                    // fontWeight: FontWeight.w500,
                    color: AppColors.hintText,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: Colors.grey[200] ?? Colors.grey),
                    borderRadius: BorderRadius.circular(12)),
                child: const Padding(
                  padding: EdgeInsets.only(left: 4, right: 8.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      maxLines: 1, // controller: userNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Sana',
                        hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),
              const Text(
                'Muhimlik darajasi',
                style: TextStyle(
                    // fontWeight: FontWeight.w500,
                    color: AppColors.hintText,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.importantInTaskLow,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // color: AppColors.send_in_task_item,
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Past',
                          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.sendInTaskItem,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // color: AppColors.send_in_task_item,
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'O\'rta',
                          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.importantInTaskItem,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Muhim',
                          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.importantInTaskHigh,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'O\'ta',
                          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              const Text(
                'Xodimlar',
                style: TextStyle(
                    // fontWeight: FontWeight.w500,
                    color: AppColors.hintText,
                    fontSize: 14),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/circle.png',
                    height: 60,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Expanded(
                  //child:
                  const Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          'Aliyev Alisher Sheraliyevich',
                          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Xizmat bo’limi',
                        style: TextStyle(
                            // fontWeight: FontWeight.w500,
                            color: AppColors.hintText,
                            fontSize: 14),
                      ),
                    ],
                  ),

                  const SizedBox(
                    width: 10,
                  ),
                  // ),
                  Image.asset(
                    'assets/images/checks.png',
                    height: 24,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              const Text(
                'Fayllar',
                style: TextStyle(
                    // fontWeight: FontWeight.w500,
                    color: AppColors.hintText,
                    fontSize: 14),
              ),

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Image.asset(
                  AppConst.fileUpload,
                  height: 103,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SizedBox(
                      width: 115,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          shadowColor: Colors.black,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Saqlash',
                          style: TextStyle(
                              fontSize: 14, // Font size
                              fontWeight: FontWeight.w600,
                              color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
