import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/config/dio_client.dart';
import 'package:shrimp_care_mobileapp/features/disease/models/detail_disease.dart';
import 'package:shrimp_care_mobileapp/features/disease/models/disease.dart';
import 'package:shrimp_care_mobileapp/features/disease/services/disease_service.dart';

class DiseaseProvider extends ChangeNotifier {
  final DiseaseService _diseaseService = DiseaseService(DioClient());
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Disease> _diseases = [];
  List<Disease> get diseases => _diseases;

  DetailDisease _selectedDisease = DetailDisease();
  DetailDisease get selectedDisease => _selectedDisease;

  List<Symptoms> _allSymptoms = [];
  List<Symptoms> get allSymptoms => _allSymptoms;

  // final List<String> _selectedSymptoms = [];
  // List<String> get selectedSymptoms => _selectedSymptoms;

  String _searchSymptoms = '';
  String get searchSymptoms => _searchSymptoms;

  String _prefixSort = '';
  String get prefixSort => _prefixSort;

  String _search = '';
  String get search => _search;

  void resetParams() {
    _prefixSort = '';
    _search = '';
  }

  void setSearch(String search) {
    _search = search;
    fetchDiseaseAll();
  }

  void setSearchSymtomps(String search) {
    _searchSymptoms = search;
    fetchSymtomps();
  }

  void setPrefixSort(String prefixSort) {
    _prefixSort = prefixSort;
    fetchDiseaseAll();
  }

  Future<void> fetchDiseases({
    int setLimit = 10000,
    bool withGteRiskLevel = false,
    String prefixSort = "",
    String search = "",
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final diseases = await _diseaseService.getDiseasesHomePage(
        setLimit: setLimit,
        prefixSort: prefixSort,
        search: search,
        withGteRiskLevel: withGteRiskLevel,
      );

      if (diseases.isNotEmpty) {
        _diseases = diseases;
      } else {
        _diseases = [];
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

  void fetchDiseaseHomePage() {
    fetchDiseases(
      setLimit: 2,
      withGteRiskLevel: true,
      prefixSort: '-risk_level',
    );
  }

  void fetchDiseaseAll() {
    fetchDiseases(
      setLimit: 10000,
      prefixSort: prefixSort,
      search: search,
    );
  }

  Future<void> fetchDiseasesById(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final disease = await _diseaseService.getDiseasesById(id);
      _selectedDisease = disease;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
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
      print('_allSymptoms: $_allSymptoms');
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
