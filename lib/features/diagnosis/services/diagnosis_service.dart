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
    int? setLimit,
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

  Future<List<ResultDiagnosis>> getResultDiagnosis({
    required String diagnosisId,
  }) async {
    try {
      final queryParams = {
        'diagnosis_id[eq]': diagnosisId,
        'sort': '-percentage',
        'embed': 'disease',
        'fields': 'id,diagnosis_id,disease_id,percentage',
        'disease.fields': 'name_disease',
      };

      final res = await dioClient.dio.get(
        '/diagnosis-results',
        queryParameters: queryParams,
      );

      final data = res.data['data'] as List;
      if (data.isEmpty) {
        return [];
      }

      List<ResultDiagnosis> resultDiagnosis =
          data.map((e) => ResultDiagnosis.fromJson(e)).toList();
      return resultDiagnosis;
    } catch (e) {
      errorHandler(error: e);
      rethrow;
    }
  }
}
