import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrimp_care_mobileapp/config/database.dart';
import 'package:shrimp_care_mobileapp/features/auth/services/auth_service.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/repositories/diagnosis_detail_repository.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/repositories/diagnosis_repository.dart';

class TokenProvider extends ChangeNotifier {
  final AppDatabase _db = AppDatabase();
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  late final AuthService _authService;

  TokenProvider() {
    _authService = AuthService(
      diagnosisDetailRepository: DiagnosisDetailRepository(_db),
      diagnosisRepository: DiagnosisRepository(_db),
    );
  }

  String? name;
  String? job;
  String? age;

  void getName() {
    _pref.then((value) {
      name = value.getString('name');
      notifyListeners();
    });
  }

  void getJob() {
    _pref.then((value) {
      job = value.getString('job');
      notifyListeners();
    });
  }

  void getAge() {
    _pref.then((value) {
      age = value.getString('age');
      notifyListeners();
    });
  }

  void setToken(String keyName, dynamic key) async {
    SharedPreferences value = await _pref;

    value.setString(keyName, key);
  }

  Future<String?> getDataLocal(String key) async {
    SharedPreferences value = await _pref;

    return value.getString(key);
  }

  void logOut(BuildContext context, {VoidCallback? onSuccess}) async {
    final value = await _pref;
    value.clear();

    // clear all datas
    await _authService.clearAllData();

    onSuccess?.call();
  }
}
