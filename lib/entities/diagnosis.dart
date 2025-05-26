import 'package:drift/drift.dart';

@DataClassName('DiagnosisEntity')
class Diagnosis extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get diseaseId => text().withLength(min: 1, max: 50)();
  RealColumn get percentage => real()();
  TextColumn get explain => text().withLength(min: 1, max: 500)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
