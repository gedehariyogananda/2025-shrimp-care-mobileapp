import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

Widget customFormInput({
  required String title,
  required String hintText,
  required IconData icon,
  bool isRequired = false,
  bool isPassword = false,
  FocusNode? focusNode,
  TextEditingController? controller,
  bool forPhoneNumber = false,
}) {
  final ValueNotifier<bool> obscureTextNotifier =
      ValueNotifier<bool>(isPassword);

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
      ValueListenableBuilder<bool>(
        valueListenable: obscureTextNotifier,
        builder: (context, obscureText, _) {
          return Focus(
            focusNode: focusNode,
            child: TextFormField(
              keyboardType:
                  forPhoneNumber ? TextInputType.phone : TextInputType.text,
              controller: controller,
              obscureText: obscureText,
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
                prefixIcon: Icon(
                  icon,
                  color: (focusNode!.hasFocus)
                      ? MyColor.primary
                      : MyColor.formInputBorder,
                  size: 20,
                ),
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                          color: MyColor.formInputBorder,
                        ),
                        onPressed: () {
                          obscureTextNotifier.value = !obscureText;
                        },
                      )
                    : null,
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
          );
        },
      ),
    ],
  );
}
