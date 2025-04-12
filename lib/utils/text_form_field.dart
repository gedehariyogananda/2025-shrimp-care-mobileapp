import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

Widget customFormInput({
  required String title,
  required String hintText,
  required IconData icon,
  bool isRequired = false,
  FocusNode? focusNode,
  TextEditingController? controller,
  bool forPhoneNumber = false,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isHovered = false;

      focusNode ??= FocusNode();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Focus(
            focusNode: focusNode,
            onFocusChange: (_) => setState(() {}),
            child: TextFormField(
              keyboardType: forPhoneNumber
                  ? TextInputType.phone
                  : TextInputType.text,
              controller: controller,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: MyColor.secondary,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Inter',
                  fontSize: 15,
                ),
                prefixIcon: MouseRegion(
                  onEnter: (_) => setState(() => isHovered = true),
                  onExit: (_) => setState(() => isHovered = false),
                  child: Icon(
                    icon,
                    color: (focusNode!.hasFocus || isHovered)
                        ? MyColor.primary
                        : MyColor.formInputBorder,
                    size: 20,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: MyColor.formInputBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: MyColor.primary),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
