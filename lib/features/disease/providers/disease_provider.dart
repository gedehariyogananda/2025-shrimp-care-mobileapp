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

  Future<void> fetchDiseases() async {
    _isLoading = true;
    notifyListeners();

    try {
      final diseases = await _diseaseService.getDiseasesHomePage();
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
}
