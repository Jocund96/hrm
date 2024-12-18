import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProjectDashboardItem extends StatelessWidget {
  final String name;
  final int count;
  final int notStarted;
  final int inProgress;

  const ProjectDashboardItem({
    super.key,
    required this.name,
    required this.count,
    required this.notStarted,
    required this.inProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    // const Padding(
                    //   padding: EdgeInsets.only(right: 15),
                    Text(
                      '$count',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(alignment: Alignment.center, children: [
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: CircularProgressIndicator(
                      value: setValueProgress(notStarted, inProgress),
                      backgroundColor: Colors.yellow,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
                      strokeWidth: 12,
                    ),
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      '${setPercent(notStarted, inProgress, 1)}', // Completed percentage
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      '${setPercent(inProgress, notStarted, 2)}', // Pending percentage
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.yellow,
                      ),
                    ),
                  ]),
                ]),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr('not_started'),
                        style: const TextStyle(fontSize: 10),
                      ),
                      Text(
                        '$notStarted',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr('in_process'),
                        style: const TextStyle(fontSize: 10),
                      ),
                      Text(
                        '$inProgress',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ]),
              ),
              const SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }

  int setPercent(int a, int b, int type) {
    if (a != 0 && b != 0) {
      double c = a / (a + b) * 100;
      return c.ceil();
    }
    if (type == 1) {
      return 100;
    }
    return 0;
  }

  double setValueProgress(int a, int b) {
    if (a != 0 && b != 0) {
      double c = a / (a + b);
      return c;
    }
    return 1;
  }
}
