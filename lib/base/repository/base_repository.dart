import 'package:shrimp_care_mobileapp/config/database.dart';

abstract class BaseRepository {
  final AppDatabase db;

  BaseRepository(this.db);
}
