import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

Widget separationLine() {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 1,
          color: MyColor.secondary,
        ),
      ),
      const SizedBox(width: 8),
      Text(
        'atau',
        style: MyTextStyle.text14.copyWith(
          color: MyColor.secondary,
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Container(
          height: 1,
          color: MyColor.secondary,
        ),
      ),
    ],
  );
}
