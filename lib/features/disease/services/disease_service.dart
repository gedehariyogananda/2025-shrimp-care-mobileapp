import 'package:shrimp_care_mobileapp/config/dio_client.dart';
import 'package:shrimp_care_mobileapp/exception/error_handler.dart';
import 'package:shrimp_care_mobileapp/features/disease/models/detail_disease.dart';
import 'package:shrimp_care_mobileapp/features/disease/models/disease.dart';

class DiseaseService {
  final DioClient dioClient;

  DiseaseService(this.dioClient);

  Future<List<Disease>> getDiseasesHomePage() async {
    try {
      final res = await dioClient.dio.get(
          '/diseases?page=1&limit=2&risk_level[gte]=4&sort=-risk_level&fields=id,definition_disease,name_disease,image_disease,risk_level');

      final data = res.data['data'] as List;
      if (data.isEmpty) {
        return [];
      }

      List<Disease> diseases = data.map((e) => Disease.fromJson(e)).toList();
      return diseases;
    } catch (e) {
      errorHandler(error: e);
      rethrow;
    }
  }

  Future<DetailDisease> getDiseasesById(String id) async {
    try {
      final res = await dioClient.dio.get('/diseases/$id');

      if (res.data['data'] == null) {
        return DetailDisease();
      }

      DetailDisease disease = DetailDisease.fromJson(res.data['data']);
      return disease;
    } catch (e) {
      errorHandler(error: e);
      rethrow;
    }
  }
}
