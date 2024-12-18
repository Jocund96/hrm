import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';
import 'package:mobile_ung/views/project/project__list_screen.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 25),

            // control
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProjectListScreen(
                            selectedIndex: 1,
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Card(
                  color: AppColors.darkBlue,
                  elevation: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Image.asset('assets/images/settings.png', height: 29, color: Colors.white),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(context.tr('project_management').toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16, // Font size
                                fontWeight: FontWeight.bold,
                                color: Colors.white // Font weight
                                )),
                      ]),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),

            /// report
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProjectListScreen(
                            selectedIndex: 2,
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Card(
                  color: AppColors.darkRed,
                  elevation: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Image.asset(
                          'assets/images/chart-arcs.png',
                          height: 29,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(context.tr('project_report').toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16, // Font size
                                fontWeight: FontWeight.bold,
                                color: Colors.white // Font weight
                                )),
                      ]),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),

            /// monitoring
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProjectListScreen(
                            selectedIndex: 3,
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Card(
                  color: AppColors.lightBlue,
                  elevation: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Image.asset(
                          'assets/images/chart-donut.png',
                          height: 29,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(context.tr('project_monitoring').toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16, // Font size
                                fontWeight: FontWeight.bold,
                                color: Colors.white // Font weight
                                )),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
