import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/config/database.dart';
import 'package:shrimp_care_mobileapp/data/symptomp_shrimp.dart';
import 'package:shrimp_care_mobileapp/features/disease/models/disease.dart';
import 'package:shrimp_care_mobileapp/services/diagnosis_service.dart';

class DiagnosaProvider extends ChangeNotifier {
  final DiagnosisServices _diagnosisService;

  DiagnosaProvider(DiagnosisServices diagnosisService)
      : _diagnosisService = diagnosisService;

  List<Symptoms> _symptoms = [];
  List<Symptoms> get symptoms => _symptoms;

  String _currentSearch = "";
  String get currentSearch => _currentSearch;

  List<String> _selectedSymptomCodes = [];
  List<String> get selectedSymptomCodes => _selectedSymptomCodes;

  List<DetailDiagnosisEntity> _diagnoses = [];
  List<DetailDiagnosisEntity> get diagnoses => _diagnoses;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void getAllSymptoms() {
    _symptoms = List.from(symptomsShrimp);
    _currentSearch = "";
    notifyListeners();
  }

  void setSearchSymtomps(String search) {
    if (search.isEmpty) {
      _symptoms = symptomsShrimp;
    } else {
      _symptoms = symptomsShrimp
          .where((symptom) => (symptom.nameSymptoms?.toLowerCase() ?? '')
              .contains(search.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void toggleSymptomCode(String code) {
    if (_selectedSymptomCodes.contains(code)) {
      _selectedSymptomCodes.remove(code);
    } else {
      _selectedSymptomCodes.add(code);
    }
    notifyListeners();
  }

  void resetSymptoms() {
    _selectedSymptomCodes.clear();
    notifyListeners();
  }

  Future<dynamic> setDiagnosis({
    Function(String error)? onError,
  }) async {
    try {
      final result =
          await _diagnosisService.forwardChaining(_selectedSymptomCodes);
      if (result == null) {
        return null;
      }
      print("Diagnosis berhasil: $result");

      return result;
    } catch (e) {
      onError?.call("Terjadi kesalahan saat melakukan diagnosis: $e");
    }
  }

  Future<DetailDiagnosisEntity?> fetchDiagnoses({
    required int diagnosisId,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      _diagnoses = await _diagnosisService.getDetailDiagnosis(diagnosisId);
      print("Diagnoses fetched: ${_diagnoses.length}");
      print("Diagnoses: $_diagnoses");
      notifyListeners();
      _isLoading = false;
    } catch (e) {
      print("Error fetching diagnoses: $e");
      _diagnoses = [];
      _isLoading = false;
      notifyListeners();
    }
  }
}
