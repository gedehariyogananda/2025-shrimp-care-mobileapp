import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/config/dio_client.dart';
import 'package:shrimp_care_mobileapp/features/auth/providers/token_provider.dart';
import 'package:shrimp_care_mobileapp/features/auth/services/login_service.dart';

class LoginProvider extends ChangeNotifier {
  final LoginService _loginService =
      LoginService(dioClient: DioClient(), tokenProvider: TokenProvider());

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> login({
    required String email,
    required String password,
    VoidCallback? onSuccess,
    Function(String error)? onError,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      onError?.call('Email and password tidak boleh kosong!');
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _loginService.login(email: email, password: password);
      onSuccess?.call();
    } catch (e) {
      onError?.call(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
