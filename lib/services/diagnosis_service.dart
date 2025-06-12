import 'package:shrimp_care_mobileapp/config/database.dart';
import 'package:shrimp_care_mobileapp/features/disease/models/rule.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/repositories/diagnosis_detail_repository.dart';
import 'package:shrimp_care_mobileapp/features/diagnosis/repositories/diagnosis_repository.dart';

class DiagnosisServices {
  final DiagnosisRepository _diagnosisRepository;
  final DiagnosisDetailRepository _detailDiagnosisRepository;

  DiagnosisServices(this._diagnosisRepository, this._detailDiagnosisRepository);

  Future<int?> forwardChaining(List<String> selectedSymptomCodes) async {
    final rules = [
      Rule(diseaseId: "Pe1", symptoms: ["Ge1", "Ge2", "Ge4"]),
      Rule(diseaseId: "Pe2", symptoms: ["Ge5", "Ge6", "Ge7", "Ge8"]),
      Rule(diseaseId: "Pe3", symptoms: ["Ge9", "Ge11"]),
      Rule(diseaseId: "Pe4", symptoms: ["Ge6", "Ge7", "Ge8", "Ge12"]),
      Rule(diseaseId: "Pe5", symptoms: ["Ge11", "Ge13", "Ge14"]),
      Rule(diseaseId: "Pe6", symptoms: ["Ge2", "Ge15"]),
      Rule(diseaseId: "Pe7", symptoms: ["Ge17", "Ge18"]),
      Rule(diseaseId: "Pe8", symptoms: ["Ge4", "Ge19", "Ge20"]),
    ];

    try {
      final selected = selectedSymptomCodes;
      Map<String, double> matchPercentage = {};

      for (final rule in rules) {
        final matched = rule.symptoms.where((s) => selected.contains(s)).length;
        final percentage = matched / rule.symptoms.length * 100;

        if (matched > 0) {
          matchPercentage[rule.diseaseId] = percentage;
        }
      }

      if (matchPercentage.isEmpty) {
        return null;
      }

      final sorted = matchPercentage.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      final topPercentage = sorted.first.value;
      final topDiseases =
          sorted.where((e) => e.value == topPercentage).toList();

      String explain = '';
      if (topPercentage >= 85) {
        explain = "Sangat besar kemungkinan";
      } else if (topPercentage >= 60) {
        explain = "Cukup besar kemungkinan";
      } else if (topPercentage >= 40) {
        explain = "Kemungkinan sedang";
      } else {
        explain = "Kemungkinan rendah";
      }

      final diagnosisId = await _diagnosisRepository.store(
        diseaseId: topDiseases.first.key,
        percentage: topPercentage,
        explain: explain,
      );

      for (var entry in topDiseases) {
        final percentage = entry.value;

        await _detailDiagnosisRepository.store(
          diagnosisId: diagnosisId!,
          diseaseId: entry.key,
          percentage: percentage,
        );
      }

      return diagnosisId;
    } catch (e) {
      return null;
    }
  }

  Future<List<DetailDiagnosisEntity>> getDetailDiagnosis(
      int diagnosisId) async {
    try {
      return await _detailDiagnosisRepository.getByDiagnosisId(diagnosisId);
    } catch (e) {
      return [];
    }
  }

  Future<DiagnosisEntity?> getDiagnosisById(int id) async {
    try {
      return await _diagnosisRepository.getById(id);
    } catch (e) {
      return null;
    }
  }

  Future<List<DiagnosisEntity>> getDiagnosisHistory() async {
    try {
      return await _diagnosisRepository.getHistory();
    } catch (e) {
      return [];
    }
  }

  Future<List<DiagnosisEntity>> getAllDiagnosisHistory({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      return await _diagnosisRepository.getAllHistory(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      return [];
    }
  }
}
