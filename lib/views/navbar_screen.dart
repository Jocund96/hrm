import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_ung/views/home/home_screen.dart';
import 'package:mobile_ung/views/login/profile_screen.dart';
import '../core/const/app_const.dart';
import '../core/theme/app_colors.dart';
import '../dto/user/user.dto.dart';
import '../main.dart';
import 'corporate/corporate_screen.dart';
import 'document/document_screen.dart';
import 'login/login_screen.dart';
import 'project/project_screen.dart';
import 'task/task_screen.dart';

class NavbarScreen extends StatefulWidget {
  final int initialTab;

  const NavbarScreen({super.key, this.initialTab = 0});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> with SingleTickerProviderStateMixin<NavbarScreen> {
  late int activeIndex = 0;
  late TabController tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String userName = '';

  @override
  void initState() {
    activeIndex = widget.initialTab;
    tabController = TabController(length: 5, vsync: this, initialIndex: widget.initialTab);

    tabController.addListener(() {
      setState(() {
        activeIndex = tabController.index;
      });
    });
    getName();
    super.initState();
  }

  Future<void> getName() async {
    UserDto? employee = await prefs.getEmployee();
    userName = employee?.username ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            titleSpacing: 0,
            elevation: 0,
            leadingWidth: 50,
            leading: IconButton(
              highlightColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              icon: const Icon(Icons.menu, color: AppColors.mainColor),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
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
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                  children: const [
                    HomeScreen(),
                    DocumentScreen(),
                    ProjectScreen(),
                    TaskScreen(),
                    CorporateScreen(),
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.mainColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.bottomBg,
            unselectedItemColor: Colors.white,
            currentIndex: activeIndex,
            onTap: (index) {
              setState(() {
                activeIndex = index;
                tabController.index = index; // This line is important
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(width: 35, activeIndex == 0 ? AppConst.homeActive : AppConst.home, fit: BoxFit.cover),
                label: context.tr('home'),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(width: 28, activeIndex == 1 ? AppConst.documentActive : AppConst.document, fit: BoxFit.cover),
                label: context.tr('document'),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(width: 28, activeIndex == 2 ? AppConst.projectActive : AppConst.project, fit: BoxFit.cover),
                label: context.tr('projects'),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(width: 25, activeIndex == 3 ? AppConst.taskActive : AppConst.task, fit: BoxFit.cover),
                label: context.tr('task'),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(width: 25, activeIndex == 4 ? AppConst.cooperativeActive : AppConst.cooperative, fit: BoxFit.cover),
                label: context.tr('cooperative'),
              ),
            ],
          ),
          drawer: Drawer(
            backgroundColor: AppColors.mainColor,
            width: 300.w,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 10.h),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppConst.user))),
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Text(userName, style: const TextStyle(fontSize: 16, color: AppColors.white)),
                        SizedBox(height: 8.h),
                        const Text('', style: TextStyle(fontSize: 13, color: AppColors.white)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 15.h, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30.h),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ProfileScreen()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    AppConst.profile,
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text(
                                    context.tr(
                                      'about_profile',
                                    ),
                                    style: const TextStyle(fontSize: 13, color: AppColors.white),
                                  ),
                                  Image.asset(
                                    AppConst.arrowRight,
                                    width: 7,
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Image.asset(AppConst.password, width: 20, height: 20,),
                          //       Text(context.tr('Parolni tahrirlash',), style: const TextStyle(fontSize: 13, color: AppColors.white),),
                          //       Image.asset(AppConst.arrow_right, width: 7, height: 12,),
                          //     ],
                          //   ),
                          // ),
                          /* SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(AppConst.profile, width: 20, height: 20,),
                                  Text(context.tr('Dastur versiyasi',), style: const TextStyle(fontSize: 13, color: AppColors.white),),
                                  Image.asset(AppConst.arrow_right, width: 7, height: 12,),
                                ],
                              ),*/
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(context.tr('change_language')),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: const Text("O'zbekcha"),
                                          onTap: () async {
                                            await context.setLocale(const Locale('uz', 'UZ'));
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: const Text('Ўзбекча'),
                                          onTap: () async {
                                            await context.setLocale(const Locale('uz', 'Cyrl-UZ'));
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: const Text('Русский'),
                                          onTap: () async {
                                            await context.setLocale(const Locale('ru', 'RU'));
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: const Text('English'),
                                          onTap: () async {
                                            await context.setLocale(const Locale('en', 'US'));
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    AppConst.translate,
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text(
                                    context.tr(
                                      'change_language',
                                    ),
                                    style: const TextStyle(fontSize: 13, color: AppColors.white),
                                  ),
                                  Image.asset(
                                    AppConst.arrowRight,
                                    width: 7,
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(context.tr('confirm_logout')),
                                  content: Text(context.tr('exit_question')),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(context.tr('cancel')),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await prefs.removeToken();
                                        await prefs.removeEmployee();
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                                        );
                                      },
                                      child: Text(context.tr(
                                        'exit',
                                      )),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    AppConst.exit,
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text(
                                    context.tr(
                                      'exit',
                                    ),
                                    style: const TextStyle(fontSize: 13, color: AppColors.red),
                                  ),
                                  Image.asset(
                                    AppConst.arrowRightRed,
                                    width: 7,
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.mainColor,
                      height: 25.h,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 17.3.h, left: 20),
                child: const Text(
                  'Created by Dataprizma',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: AppColors.white),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
