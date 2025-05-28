import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

Widget formDropdown({
  required String title,
  bool isRequired = false,
  required List<String> items,
  required String hintText,
  required IconData leadingIcon,
  IconData trailingIcon = Icons.arrow_drop_down,
  ValueChanged<String?>? onChanged,
  String? selectedValue,
}) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            title,
            style: MyTextStyle.text16.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (isRequired)
            const Text(
              ' *',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
        ],
      ),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(leadingIcon, color: MyColor.formInputBorder, size: 20),
            const SizedBox(width: 14),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedValue,
                  hint: Text(
                    hintText,
                    style: TextStyle(
                      color: MyColor.secondary,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Inter',
                      fontSize: 15,
                    ),
                  ),
                  items: items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
