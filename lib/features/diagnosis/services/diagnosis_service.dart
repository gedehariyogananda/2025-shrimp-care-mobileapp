import 'package:shrimp_care_mobileapp/base/constant/app_constant.dart';
import 'package:shrimp_care_mobileapp/config/dio_client.dart';
import 'package:shrimp_care_mobileapp/exception/error_handler.dart';
import 'package:shrimp_care_mobileapp/features/auth/providers/token_provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/models/diagnosis.dart';

class DiagnosisService {
  final DioClient dioClient;
  final TokenProvider tokenProvider;

  DiagnosisService({
    required this.dioClient,
    required this.tokenProvider,
  });

  Future<List<Diagnosis>> getHistoryDiagnosis({
    String? startDate,
    String? endDate,
    int? setLimit = 1000,
  }) async {
    try {
      final userId =
          await tokenProvider.getDataLocal(AppConstants.keySharedPrefUserId);

      final queryParams = {
        'user_id[eq]': userId,
        'sort': '-created_at',
        'page': 1,
        'limit': setLimit,
        'embed': 'disease',
        'fields':
            'id,user_id,best_disease_id,best_percentage_disease,created_at',
        'disease.fields': 'name_disease',
      };

      print('Query ParamsS: $queryParams');

      if (startDate != null) {
        queryParams['created_at[gte]'] = startDate;
      }

      if (endDate != null) {
        queryParams['created_at[lt]'] = endDate;
      }

      final res = await dioClient.dio.get(
        '/diagnosis',
        queryParameters: queryParams,
      );
      
      print('response: ${res.toString()}');

      final data = res.data['data'] as List;
      if (data.isEmpty) {
        return [];
      }

      List<Diagnosis> historyDiagnosis =
          data.map((e) => Diagnosis.fromJson(e)).toList();
      return historyDiagnosis;
    } catch (e) {
      errorHandler(error: e);
      rethrow;
    }
  }
}
