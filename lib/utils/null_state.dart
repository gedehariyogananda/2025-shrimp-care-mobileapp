import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

Widget nullState({
  required String nullTitle,
  String? description,
  String? buttonTitle,
  VoidCallback? onTap,
}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.info_outline,
          color: MyColor.secondary,
          size: 48.0,
        ),
        const SizedBox(height: 10),
        Text(
          nullTitle,
          style: MyTextStyle.text18.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        if (description != null) ...[
          const SizedBox(height: 7.0),
          Text(
            description!,
            style: MyTextStyle.text14.copyWith(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 10),
        if (buttonTitle != null && onTap != null) ...[
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColor.primary,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              buttonTitle!,
              style: MyTextStyle.text14.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    ),
  );
}
