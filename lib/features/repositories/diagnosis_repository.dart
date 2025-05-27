import 'package:drift/drift.dart';
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

  Future<DiagnosisEntity?> getById(int id) {
    return (db.select(db.diagnosis)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<DiagnosisEntity>> getHistory() {
    return (db.select(db.diagnosis)
          ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.createdAt),
          ])
          ..limit(2))
        .get();
  }

  Future<List<DiagnosisEntity>> getAllHistory({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return (db.select(db.diagnosis)
          ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.createdAt),
          ])
          ..where((tbl) =>
              tbl.createdAt.isBiggerOrEqualValue(startDate) &
              tbl.createdAt.isSmallerOrEqualValue(endDate)))
        .get();
  }
}
