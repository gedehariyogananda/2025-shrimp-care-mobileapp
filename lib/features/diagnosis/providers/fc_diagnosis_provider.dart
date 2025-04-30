import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/config/dio_client.dart';
import 'package:shrimp_care_mobileapp/exception/app_exception.dart';
import 'package:shrimp_care_mobileapp/features/auth/providers/token_provider.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/services/diagnosis_service.dart';
import 'package:shrimp_care_mobileapp/features/disease/models/disease.dart';
import 'package:shrimp_care_mobileapp/features/disease/services/disease_service.dart';

class FcDiagnosisProvider extends ChangeNotifier {
  final DiseaseService _diseaseService = DiseaseService(DioClient());
  final DiagnosisService _diagnosisService =
      DiagnosisService(dioClient: DioClient(), tokenProvider: TokenProvider());

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _threshold = 60;
  List<String> _selectedSymptomCodes = [];

  int get threshold => _threshold;
  List<String> get selectedSymptomCodes => _selectedSymptomCodes;

  List<Symptoms> _allSymptoms = [];
  List<Symptoms> get allSymptoms => _allSymptoms;

  String _searchSymptoms = '';
  String get searchSymptoms => _searchSymptoms;

  void setSearchSymtomps(String search) {
    _searchSymptoms = search;
    fetchSymtomps();
  }

  void setThreshold(int value) {
    _threshold = value;
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
    _threshold = 60;
    notifyListeners();
  }

  Map<String, dynamic> buildDiagnosisPayload() {
    return {
      "symtoms": _selectedSymptomCodes,
      "threshold": _threshold,
    };
  }

  Future<String?> forwardChaining({
    Function(String error)? onError,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final res = await _diagnosisService.postDiagnosis(
        payload: buildDiagnosisPayload(),
      );

      _isLoading = false;
      notifyListeners();

      return res;
    } on AppExceptions catch (e) {
      print("error: ${e.message}");
      _isLoading = false;
      onError?.call(e.message!);
      notifyListeners();
      return null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      if (e is String) {
        onError?.call(e);
      } else {
        onError?.call("Terjadi kesalahan, silahkan coba lagi.");
      }
      return null;
    }
  }

  Future<void> fetchSymtomps() async {
    _isLoading = true;
    notifyListeners();

    try {
      final diseaseDiagnosis = await _diseaseService.getDiseaseDiagnosis(
        search: _searchSymptoms,
      );
      if (diseaseDiagnosis.isNotEmpty) {
        _allSymptoms = diseaseDiagnosis;
      } else {
        _allSymptoms = [];
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
}
