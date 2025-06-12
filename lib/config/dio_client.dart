import 'package:dio/dio.dart';
import 'package:shrimp_care_mobileapp/base/constant/app_constant.dart';
import 'package:shrimp_care_mobileapp/config/api_server.dart';
import 'package:shrimp_care_mobileapp/features/auth/providers/token_provider.dart';

class DioClient {
  late Dio dio;
  String? _authToken;

  DioClient() {
    dio = Dio(BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      connectTimeout: const Duration(seconds: AppConstants.timeoutConnection),
      receiveTimeout: const Duration(seconds: AppConstants.timeoutConnection),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        _authToken =
            await TokenProvider().getDataLocal(AppConstants.keySharedPrefToken);
        if (_authToken != null) {
          options.headers['Authorization'] = 'Bearer $_authToken';
        }

        return handler.next(options);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));
  }
}
