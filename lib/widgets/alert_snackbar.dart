import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

class AlertSnackbar {
  static void showSuccessSnackbar(BuildContext context, String message) {
    Flushbar(
      titleText: Text(
        "Success!",
        style: MyTextStyle.text12.copyWith(color: Colors.black),
      ),
      messageText: Text(
        message,
        style: MyTextStyle.text10.copyWith(color: Colors.grey),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      positionOffset: 50,
      backgroundColor: const Color(0xffF1F6F3),
      animationDuration: const Duration(seconds: 1),
      messageColor: Colors.black,
      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.green,
      ),
      duration: const Duration(seconds: 1, milliseconds: 500),
      leftBarIndicatorColor: Colors.green,
      borderRadius: BorderRadius.circular(10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    ).show(context);
  }

  static void showInfoSnackbar(BuildContext context, String message) {
    Flushbar(
      titleText: Text(
        "Information!",
        style: MyTextStyle.text12.copyWith(color: Colors.black),
      ),
      messageText: Text(
        message,
        style: MyTextStyle.text10.copyWith(color: Colors.grey),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      positionOffset: 50,
      backgroundColor: const Color(0xffF1F6F3),
      animationDuration: const Duration(seconds: 1),
      messageColor: Colors.black,
      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue,
      ),
      duration: const Duration(seconds: 1, milliseconds: 500),
      leftBarIndicatorColor: Colors.blue,
      borderRadius: BorderRadius.circular(10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    ).show(context);
  }

  static void showErrorSnackbar(BuildContext context, String message) {
    Flushbar(
      titleText: Text(
        "Error!",
        style: MyTextStyle.text12.copyWith(color: Colors.black),
      ),
      messageText: Text(
        message,
        style: MyTextStyle.text10.copyWith(color: Colors.grey),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      positionOffset: 50,
      backgroundColor: const Color(0xffFAF0ED),
      animationDuration: const Duration(seconds: 1),
      messageColor: Colors.black,
      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.red,
      ),
      duration: const Duration(seconds: 1, milliseconds: 500),
      leftBarIndicatorColor: Colors.red,
      borderRadius: BorderRadius.circular(10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    ).show(context);
  }
}
