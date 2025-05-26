import 'package:flutter/material.dart';
import 'package:shrimp_care_mobileapp/data/disease_shrimp.dart';
import 'package:shrimp_care_mobileapp/features/disease/models/detail_disease.dart';

class DiseasesProvider extends ChangeNotifier {
  List<DetailDisease> _diseases = [];
  List<DetailDisease> get diseases => _diseases;

  List<DetailDisease> _highRiskDisease = [];
  List<DetailDisease> get highRiskDisease => _highRiskDisease;

  DetailDisease _detailDisease = DetailDisease();
  DetailDisease get detailDisease => _detailDisease;

  String _currentSearch = "";
  String get currentSearch => _currentSearch;

  String _currentSort = "";
  String get currentSort => _currentSort;

  void getHighRiskDisease() {
    _highRiskDisease =
        diseaseList.where((disease) => disease.riskLevel == 5).take(2).toList();
    notifyListeners();
  }

  void getAllDisease() {
    _diseases = List.from(diseaseList);
    _currentSearch = "";
    _currentSort = "";
    notifyListeners();
  }

  void getById(String id) {
    _detailDisease = diseaseList.firstWhere((disease) => disease.id == id,
        orElse: () => DetailDisease());
    notifyListeners();
  }

  void setSearch(String search) {
    _currentSearch = search;
    _applyFilterSort();
    notifyListeners();
  }

  void setSort(String sort) {
    _currentSort = sort;
    _applyFilterSort();
    notifyListeners();
  }

  void _applyFilterSort() {
    List<DetailDisease> filtered = [];

    if (_currentSearch.isEmpty) {
      filtered = List.from(diseaseList);
    } else {
      filtered = diseaseList.where((disease) {
        final name = disease.nameDisease?.toLowerCase() ?? '';
        return name.contains(_currentSearch.toLowerCase());
      }).toList();
    }

    if (_currentSort.isNotEmpty) {
      if (_currentSort == "risk_level") {
        filtered.sort((a, b) => (a.riskLevel ?? 0).compareTo(b.riskLevel ?? 0));
      } else if (_currentSort == "-risk_level") {
        filtered.sort((a, b) => (b.riskLevel ?? 0).compareTo(a.riskLevel ?? 0));
      }
    }

    _diseases = filtered;
    notifyListeners();
  }
}
