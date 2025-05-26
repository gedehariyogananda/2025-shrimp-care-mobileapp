import 'package:shrimp_care_mobileapp/data/disease_shrimp.dart';
import 'package:shrimp_care_mobileapp/features/disease/models/detail_disease.dart';

DetailDisease? getDiseaseById(String diseaseId) {
  try {
    return diseaseList.firstWhere((disease) => disease.id == diseaseId);
  } catch (e) {
    return null; // Tidak ditemukan
  }
}
