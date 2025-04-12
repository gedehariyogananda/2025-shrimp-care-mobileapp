import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

class AlertSnackbar {
  static void showSuccessSnackbar(BuildContext context, String message) {
    _showSnackbar(
      context: context,
      title: "Berhasil!",
      message: message,
      backgroundColor: const Color(0xffF1F6F3),
      leftBarColor: Colors.green,
      iconColor: Colors.green,
      duration: const Duration(seconds: 2),
      mainButton: null,
    );
  }

  static void showInfoSnackbar(BuildContext context, String message) {
    _showSnackbar(
      context: context,
      title: "Information!",
      message: message,
      backgroundColor: const Color(0xffF1F6F3),
      leftBarColor: Colors.blue,
      iconColor: Colors.blue,
      duration: const Duration(seconds: 3),
    );
  }

  static void showErrorSnackbar(BuildContext context, String message) {
    _showSnackbar(
      context: context,
      title: "Ada Kesalahan!",
      message: message,
      backgroundColor: const Color(0xffFAF0ED),
      leftBarColor: Colors.red,
      iconColor: Colors.red,
      duration: const Duration(seconds: 3),
    );
  }

  static void _showSnackbar({
    required BuildContext context,
    required String title,
    required String message,
    required Color backgroundColor,
    required Color leftBarColor,
    required Color iconColor,
    required Duration duration,
    Widget? mainButton,
  }) {
    Flushbar(
      titleText: Text(
        title,
        style: MyTextStyle.text12.copyWith(color: Colors.black),
      ),
      messageText: Text(
        message,
        style: MyTextStyle.text10.copyWith(color: Colors.grey),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      positionOffset: 50,
      backgroundColor: backgroundColor,
      animationDuration: const Duration(milliseconds: 500),
      messageColor: Colors.black,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: iconColor,
      ),
      leftBarIndicatorColor: leftBarColor,
      borderRadius: BorderRadius.circular(10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      mainButton: mainButton,
      isDismissible: true,
      duration: duration,
    ).show(context);
  }
}
