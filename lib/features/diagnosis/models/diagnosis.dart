import 'package:shrimp_care_mobileapp/config/api_server.dart';

class Diagnosis {
  String? id;
  String? userId;
  String? bestDiseaseId;
  String? bestPercentageDisease;
  String? createdAt;
  String? nameDisease;
  String? imageDisease;

  Diagnosis({
    this.id,
    this.userId,
    this.bestDiseaseId,
    this.bestPercentageDisease,
    this.createdAt,
    this.nameDisease,
    this.imageDisease,
  });

  Diagnosis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bestDiseaseId = json['best_disease_id'] ?? "Tidak ada id penyakit";
    bestPercentageDisease = json['best_percentage_disease'] ?? "0.0";
    createdAt = json['created_at'];
    final disease = json['disease'];
    nameDisease = disease != null
        ? disease['name_disease'] ?? "Tidak ada nama penyakit"
        : "Tidak ada nama penyakit";
    imageDisease = disease != null && disease['image_disease'] != null
        ? "${ApiUrl.storageUrl}${disease['image_disease']}"
        : "https://cdn-icons-png.flaticon.com/512/1040/1040204.png";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['best_disease_id'] = bestDiseaseId;
    data['best_percentage_disease'] = bestPercentageDisease;
    data['created_at'] = createdAt;
    data['name_disease'] = nameDisease;
    data['image_disease'] = imageDisease;
    return data;
  }
}

class ResultDiagnosis {
  String? id;
  String? diagnosisId;
  String? diseaseId;
  String? percentage;
  String? nameDisease;
  String? imageDisease;

  ResultDiagnosis({
    this.id,
    this.diagnosisId,
    this.diseaseId,
    this.percentage,
    this.nameDisease,
    this.imageDisease,
  });

  ResultDiagnosis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diagnosisId = json['diagnosis_id'];
    diseaseId = json['disease_id'];
    percentage = json['percentage'];
    nameDisease = json['disease']['name_disease'];
    imageDisease = "${ApiUrl.storageUrl}" + json['disease']['image_disease'];
  }
}
