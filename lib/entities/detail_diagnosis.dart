import 'package:drift/drift.dart';

@DataClassName('DetailDiagnosisEntity')
class DetailDiagnosis extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get diagnosisId => integer()();
  TextColumn get diseaseId => text().withLength(min: 1, max: 50)();
  RealColumn get percentage => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
