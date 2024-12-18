import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';

class CorporateItem extends StatelessWidget {
  final String title;
  final String yurDepName;
  final String departmentName;
  final String position;
  final String phone;
  final String innerPhone;

  const CorporateItem({
    super.key,
    required this.title,
    required this.yurDepName,
    required this.departmentName,
    required this.position,
    required this.phone,
    required this.innerPhone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        child: Row(
          children: [
            // Container(
            //   width: 19,
            //   decoration: const BoxDecoration(
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(16),
            //       bottomLeft: Radius.circular(16)
            //     ),
            //     color: AppColors.important_in_task_item,
            //   ),
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
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
                      yurDepName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      departmentName,
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
                      visible: position.isNotEmpty,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: position,
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 5),
                        Text(
                          phone,
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
                    const SizedBox(
                      height: 8,
                    ),
                    Visibility(
                      visible: innerPhone.isNotEmpty,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: context.tr('inner_phone'),
                              style: const TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            TextSpan(
                              text: innerPhone,
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
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
}
