import 'package:shrimp_care_mobileapp/base/constant/app_constant.dart';
import 'package:shrimp_care_mobileapp/config/dio_client.dart';
import 'package:shrimp_care_mobileapp/exception/error_handler.dart';
import 'package:shrimp_care_mobileapp/features/_auth/models/profile.dart';
import 'package:shrimp_care_mobileapp/features/_auth/providers/token_provider.dart';

class LoginService {
  final DioClient dioClient;
  final TokenProvider tokenProvider;

  LoginService({
    required this.dioClient,
    required this.tokenProvider,
  });

  Future login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await dioClient.dio.post("/auth/login", data: {
        'email': email,
        'password': password,
        'remember_me': true,
      });

      final token = res.data['data']['token'];
      tokenProvider.setToken(AppConstants.keySharedPrefToken, token);

      final profile = await dioClient.dio.get(
        '/user/profile',
      );

      final dataUser = Profile.fromJson(profile.data['data']);

      tokenProvider.setToken(AppConstants.keySharedPrefUserId, dataUser.id);
      tokenProvider.setToken(AppConstants.keySharedPrefName, dataUser.name);
    } catch (e) {
      errorHandler(error: e);
      rethrow;
    }
  }
}
