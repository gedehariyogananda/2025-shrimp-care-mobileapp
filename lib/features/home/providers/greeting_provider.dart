import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/base/constant/app_constant.dart';
import 'package:shrimp_care_mobileapp/features/auth/providers/token_provider.dart';

class GreetingProvider extends ChangeNotifier {
  final TokenProvider _tokenProvider = TokenProvider();
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

  Future<String?> nameGreeting() async {
    String? nameUser =
        await _tokenProvider.getDataLocal(AppConstants.keySharedPrefName);

    _isLoading = true;
    notifyListeners();

    try {
      if (nameUser == null) {
        return '-';
      } else {
        _isLoading = false;
        notifyListeners();
        return nameUser;
      }
    } catch (e) {
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
