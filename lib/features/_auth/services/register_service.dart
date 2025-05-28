import 'package:shrimp_care_mobileapp/config/dio_client.dart';
import 'package:shrimp_care_mobileapp/exception/error_handler.dart';

class RegisterService {
  final DioClient dioClient;

  RegisterService({
    required this.dioClient,
  });

  Future register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String job,
  }) async {
    try {
      await dioClient.dio.post("/users", data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'employment': job,
      });
    } catch (e) {
      errorHandler(error: e);
      rethrow;
    }
  }
}
