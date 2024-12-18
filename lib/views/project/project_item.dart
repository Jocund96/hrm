import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';

import '../../../core/const/app_const.dart';

class ProjectItem extends StatelessWidget {
  final String title;
  final String description;
  final String leader;
  final String dateRange;
  final String status;

  const ProjectItem({
    super.key,
    required this.title,
    required this.description,
    required this.leader,
    required this.dateRange,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        child: Row(
          children: [
            Container(
              width: 19,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                color: AppColors.importantInTaskItem,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: Image.asset(
                            AppConst.cOwner,
                            width: 18,
                            height: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: leader.isNotEmpty,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${context.tr('leader')}: ',
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            TextSpan(
                              text: leader,
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          height: 14,
                          width: 14,
                          child: Image.asset(
                            AppConst.clock,
                            width: 14,
                            height: 14,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          dateRange,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.timeInTaskItem,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /*   Card(
                          color: AppColors.important_in_task_item,
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(getStatusDocument(),
                                style: TextStyle(fontSize: 12, color: AppColors.white, fontWeight: FontWeight.w300,)),
                          ),
                        ),
                        SizedBox(width: 10),*/
                        Card(
                          color: getStatusColor(),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                            child: Text(getStatusDocument(context),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w300,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getStatusDocument(BuildContext context) {
    if (status == 'CREATED') {
      return context.tr('created');
    }
    if (status == 'FINISHED') {
      return context.tr('finished');
    }
    if (status == 'PROCESS') {
      return context.tr('process');
    }
    if (status == 'SIGN_NEED') {
      return context.tr('sign_need');
    }
    if (status == 'EXPIRED_FINISHED') {
      return context.tr('expired_finished');
    }
    if (status == 'EXPIRED') {
      return context.tr('expired');
    }
    if (status == 'SEEN') {
      return context.tr('seen');
    }

    return '';
  }

  Color getStatusColor() {
    if (status == 'CREATED') {
      return AppColors.importantInTaskItem;
    }
    if (status == 'FINISHED') {
      return AppColors.sendInTaskItem;
    }
    if (status == 'PROCESS') {
      return AppColors.importantInTaskItem;
    }
    if (status == 'SIGN_NEED') {
      return AppColors.importantInTaskItem;
    }
    if (status == 'EXPIRED_FINISHED') {
      return AppColors.sendInTaskItem;
    }
    if (status == 'EXPIRED') {
      return AppColors.importantInTaskHigh;
    }

    return AppColors.sendInTaskItem;
  }
}
