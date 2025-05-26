import 'package:shrimp_care_mobileapp/base/repository/base_repository.dart';
import 'package:shrimp_care_mobileapp/config/database.dart';

class DiagnosisRepository extends BaseRepository {
  DiagnosisRepository(AppDatabase db) : super(db);

  Future<int?> store({
    required String diseaseId,
    required double percentage,
    required String explain,
  }) {
    final data = DiagnosisCompanion.insert(
        diseaseId: diseaseId, percentage: percentage, explain: explain);
    return db.into(db.diagnosis).insert(data);
  }
}
