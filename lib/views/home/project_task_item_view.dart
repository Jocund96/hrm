import 'package:flutter/material.dart';
import 'package:mobile_ung/core/const/app_const.dart';

class ProjectTaskItemView extends StatelessWidget {
  final String date;
  final String title;
  final String body;

  const ProjectTaskItemView({super.key, required this.date, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 5.0,
            ),
            Column(
              children: [
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12.0), // Adjust this if needed
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            SizedBox(
              height: 24,
              width: 24,
              child: Image.asset(
                AppConst.message,
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Divider(
          thickness: 0.3,
          color: Colors.grey[400],
          height: 5,
        ),
      ],
    );
  }
}
