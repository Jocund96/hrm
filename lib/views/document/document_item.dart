import 'package:flutter/material.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';

class DocumentItem extends StatelessWidget {
  final String? regNumber;
  final String? documentTypeName;
  final String? statusName;
  final String? date;
  final String? universalDocumentId;

  const DocumentItem({
    super.key,
    required this.regNumber,
    required this.documentTypeName,
    required this.statusName,
    required this.date,
    required this.universalDocumentId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    regNumber!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Card(
                    color: AppColors.sendInTaskItem,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '$statusName',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '№ $universalDocumentId',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    formatDate(date),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: documentTypeName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(String? date) {
    if (date != null && date.length >= 10) {
      return date.substring(0, 10);
    }

    return 'N/A';
  }
}
