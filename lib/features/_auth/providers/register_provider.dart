import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/features/_auth/providers/token_provider.dart';
import 'package:shrimp_care_mobileapp/features/_auth/services/register_service.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterService _registerService =
      RegisterService(tokenProvider: TokenProvider());

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> register({
    required String name,
    required String age,
    required String job,
    VoidCallback? onSuccess,
    Function(String error)? onError,
  }) async {
    if (name.isEmpty || age.isEmpty || job.isEmpty) {
      onError?.call('Semua field harus diisi!');
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _registerService.register(age: age, name: name, job: job);

      onSuccess?.call();
    } catch (e) {
      onError?.call(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
