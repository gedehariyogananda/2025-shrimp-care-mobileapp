import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

Widget textTopCard({
  required String title,
  String seeAllText = "Lihat Semua",
  required VoidCallback onTap,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: MyTextStyle.text14
            .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
      ),
      GestureDetector(
        onTap: onTap,
        child: Text(
          seeAllText,
          style: MyTextStyle.text14
              .copyWith(color: MyColor.primary, fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}
