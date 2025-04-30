import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shrimp_care_mobileapp/config/dio_client.dart';
import 'package:shrimp_care_mobileapp/features/auth/providers/token_provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/models/diagnosis.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/services/diagnosis_service.dart';

class DiagnosisProvider extends ChangeNotifier {
  final DiagnosisService _diagnosisService =
      DiagnosisService(dioClient: DioClient(), tokenProvider: TokenProvider());

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Diagnosis> _diagnosis = [];
  List<Diagnosis> get diagnosis => _diagnosis;

  List<Diagnosis> _allDiagnosis = [];
  List<Diagnosis> get allDiagnosis => _allDiagnosis;

  List<ResultDiagnosis> _resultDiagnosis = [];
  List<ResultDiagnosis> get resultDiagnosis => _resultDiagnosis;

  DateTime selectedDate = DateTime.now();
  DateTime get getSelectedDate => selectedDate;

  setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void changeMonth(
    int increment,
    BuildContext context, {
    Function(String error)? onError,
  }) async {
    DateTime newDate = DateTime(
      selectedDate.year,
      selectedDate.month + increment,
    );

    if (newDate.isAfter(DateTime.now())) {
      onError?.call("Tidak bisa memilih bulan di masa depan!");
      return;
    }

    setSelectedDate(newDate);

    try {
      await fetchDiagnosisBySelectedDate();
    } catch (e) {
      onError?.call(e.toString());
    }
  }

  Future<void> fetchDiagnosis({
    String? startDate,
    String? endDate,
    int? setLimit = 1000,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      print("📡 Fetching diagnosis...");
      final diagnosis = await _diagnosisService.getHistoryDiagnosis(
        startDate: startDate,
        endDate: endDate,
        setLimit: setLimit,
      );

      print("✅ Received diagnosis response");

      if (diagnosis.isNotEmpty) {
        _diagnosis = diagnosis;
      } else {
        _diagnosis = [];
      }

      print("diagnosis $_diagnosis");
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchResultDiagnosis({
    String? diagnosisId,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final resultDiagnosis =
          await _diagnosisService.getResultDiagnosis(diagnosisId: diagnosisId!);

      if (resultDiagnosis.isNotEmpty) {
        _resultDiagnosis = resultDiagnosis;
      } else {
        _resultDiagnosis = [];
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllDiagnosis({
    String? startDate,
    String? endDate,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final allDiagnosis = await _diagnosisService.getHistoryDiagnosis(
        startDate: startDate,
        endDate: endDate,
        setLimit: 1000,
      );

      if (allDiagnosis.isNotEmpty) {
        _allDiagnosis = allDiagnosis;
      } else {
        _allDiagnosis = [];
      }

      print("all diagnosis $allDiagnosis");

      var length = allDiagnosis.length;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDiagnosisBySelectedDate() async {
    final startDate = DateFormat('yyyy-MM-01').format(selectedDate);
    final endDate = DateFormat('yyyy-MM-01').format(
      DateTime(selectedDate.year, selectedDate.month + 1),
    );

    await fetchAllDiagnosis(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
