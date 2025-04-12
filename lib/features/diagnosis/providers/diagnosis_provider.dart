import 'package:flutter/material.dart';
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
  }) {
    DateTime newDate = DateTime(
      selectedDate.year,
      selectedDate.month + increment,
    );

    if (newDate.isAfter(DateTime.now())) {
      onError?.call("Tidak bisa memilih bulan di masa depan!");
      return;
    }
    final startDate = '${newDate.year}-${newDate.month}-01';
    final endDate = '${newDate.year}-${newDate.month + 1}-01';

    setSelectedDate(newDate);

    try {
      fetchDiagnosis(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      onError?.call(e.toString());
    } finally {
      notifyListeners();
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
      final diagnosis = await _diagnosisService.getHistoryDiagnosis(
        startDate: startDate,
        endDate: endDate,
        setLimit: setLimit,
      );
      if (diagnosis.isNotEmpty) {
        _diagnosis = diagnosis;
      } else {
        _diagnosis = [];
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

  // Future<void> fetchdiagnosisById(String id) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     final disease = await _diagnosisService.getdiagnosisById(id);
  //     _selectedDisease = disease;
  //     _isLoading = false;
  //     notifyListeners();
  //   } catch (e) {
  //     return null;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
}
