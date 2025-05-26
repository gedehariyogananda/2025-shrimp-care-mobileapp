import 'package:shrimp_care_mobileapp/base/repository/base_repository.dart';
import 'package:shrimp_care_mobileapp/config/database.dart';
import 'package:shrimp_care_mobileapp/entities/detail_diagnosis.dart';

class DiagnosisDetailRepository extends BaseRepository {
  DiagnosisDetailRepository(AppDatabase db) : super(db);

  Future<int?> store({
    required int diagnosisId,
    required String diseaseId,
    required double percentage,
  }) {
    final data = DetailDiagnosisCompanion.insert(
        diagnosisId: diagnosisId, diseaseId: diseaseId, percentage: percentage);

    return db.into(db.detailDiagnosis).insert(data);
  }

  Future<List<DetailDiagnosisEntity>> getByDiagnosisId(int diagnosisId) async {
    return await (db.select(db.detailDiagnosis)
          ..where((tbl) => tbl.diagnosisId.equals(diagnosisId)))
        .get();
  }
}
