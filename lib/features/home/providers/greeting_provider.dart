import 'package:flutter/material.dart';

class GreetingProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi!';
    } else if (hour < 18) {
      return 'Selamat Siang!';
    } else {
      return 'Selamat Malam!';
    }
  }
}
