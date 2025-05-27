import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  DiagnosisEntity? _diagnosis;
  DiagnosisEntity? get diagnosis => _diagnosis;

  List<DiagnosisEntity> _diagnosisHistory = [];
  List<DiagnosisEntity> get diagnosisHistory => _diagnosisHistory;

  List<DiagnosisEntity> _allDiagnosisHistory = [];
  List<DiagnosisEntity> get allDiagnosisHistory => _allDiagnosisHistory;

  DateTime selectedDate = DateTime.now();
  DateTime get getSelectedDate => selectedDate;

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
      notifyListeners();
      _isLoading = false;
    } catch (e) {
      _diagnoses = [];
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<DiagnosisEntity?> getDiagnosisById(int id) async {
    try {
      _diagnosis = await _diagnosisService.getDiagnosisById(id);
      notifyListeners();
      return _diagnosis;
    } catch (e) {
      _diagnosis = null;
      notifyListeners();
      return null;
    }
  }

  Future<List<DiagnosisEntity>> fetchDiagnosisHistory() async {
    _isLoading = true;
    notifyListeners();
    try {
      _diagnosisHistory = await _diagnosisService.getDiagnosisHistory();
      _isLoading = false;
      notifyListeners();
      return _diagnosisHistory;
    } catch (e) {
      _diagnosisHistory = [];
      _isLoading = false;
      notifyListeners();
      return _diagnosisHistory;
    }
  }

  Future<List<DiagnosisEntity>> fetchAllDiagnosisHistory() async {
    _isLoading = true;
    notifyListeners();
    try {
      final startDate = DateFormat('yyyy-MM-01').format(selectedDate);
      final endDate = DateFormat('yyyy-MM-01').format(
        DateTime(selectedDate.year, selectedDate.month + 1),
      );
      _allDiagnosisHistory = await _diagnosisService.getAllDiagnosisHistory(
        startDate: DateTime.parse(startDate),
        endDate: DateTime.parse(endDate),
      );
      _isLoading = false;
      notifyListeners();
      return _allDiagnosisHistory;
    } catch (e) {
      _allDiagnosisHistory = [];
      _isLoading = false;
      notifyListeners();
      return _allDiagnosisHistory;
    }
  }

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
      await fetchAllDiagnosisHistory();
    } catch (e) {
      onError?.call(e.toString());
    }
  }
}
