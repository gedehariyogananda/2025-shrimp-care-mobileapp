import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/config/dio_client.dart';
import 'package:shrimp_care_mobileapp/features/_auth/services/register_service.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterService _registerService =
      RegisterService(dioClient: DioClient());

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
    required String phone,
    required String job,
    VoidCallback? onSuccess,
    Function(String error)? onError,
  }) async {
    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        name.isEmpty ||
        phone.isEmpty ||
        job.isEmpty) {
      onError?.call('Semua field harus diisi!');
      return;
    }

    if (password != confirmPassword) {
      onError?.call('Password dan konfirmasi password tidak cocok!');
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _registerService.register(
          email: email, password: password, name: name, phone: phone, job: job);

      onSuccess?.call();
    } catch (e) {
      onError?.call(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
