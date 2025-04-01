import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

Widget attentionCard({
  required bool isAlertDanger,
  required IconData icon,
  String? title,
  required String description,
  VoidCallback? onTap,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: isAlertDanger ? const Color(0xFFFFE4E7) : const Color(0xFFCFE9E6),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isAlertDanger ? const Color(0xFFF43F5E) : Colors.black,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) ...[
                Text(
                  title!,
                  softWrap: true,
                  style: MyTextStyle.text12.copyWith(
                    color:
                        isAlertDanger ? const Color(0xFFF43F5E) : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
              ],
              Text(
                description,
                softWrap: true,
                style: MyTextStyle.text12.copyWith(
                  color: isAlertDanger ? const Color(0xFFF43F5E) : Colors.black,
                ),
              ),
            ],
          ),
        ),
        if (onTap != null) ...[
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isAlertDanger ? const Color(0xFFF43F5E) : Colors.black,
            ),
          ),
        ],
      ],
    ),
  );
}
