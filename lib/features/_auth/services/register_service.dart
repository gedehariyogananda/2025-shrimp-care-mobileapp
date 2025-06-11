import 'package:shrimp_care_mobileapp/base/constant/app_constant.dart';
import 'package:shrimp_care_mobileapp/exception/error_handler.dart';
import 'package:shrimp_care_mobileapp/features/_auth/providers/token_provider.dart';

class RegisterService {
  final TokenProvider tokenProvider;

  RegisterService({
    required this.tokenProvider,
  });

  Future register({
    required String name,
    required String job,
    required String age,
  }) async {
    try {
      tokenProvider.setToken(AppConstants.keySharedPrefName, name);
      tokenProvider.setToken(AppConstants.keySharedPrefJob, job);
      tokenProvider.setToken(AppConstants.keySharedPrefAge, age);
    } catch (e) {
      errorHandler(error: e);
      rethrow;
    }
  }
}
