import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showRightButton;
  final IconData? iconButton;
  final VoidCallback? onRightButtonPressed;

  CustomAppBar({
    required this.title,
    this.showRightButton = false,
    this.iconButton,
    this.onRightButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColor.primary,
      centerTitle: true,
      title: Text(
        title,
        style: MyTextStyle.text18.copyWith(color: Colors.white),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      leading: showRightButton ? const SizedBox.shrink() : null,
      actions: showRightButton
          ? [
              IconButton(
                icon: Icon(iconButton, color: Colors.white),
                onPressed: onRightButtonPressed,
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
