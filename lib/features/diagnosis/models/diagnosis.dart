class Diagnosis {
  String? id;
  String? userId;
  String? bestDiseaseId;
  String? bestPercentageDisease;
  String? createdAt;
  String? nameDisease;

  Diagnosis({
    this.id,
    this.userId,
    this.bestDiseaseId,
    this.bestPercentageDisease,
    this.createdAt,
    this.nameDisease,
  });

  Diagnosis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bestDiseaseId = json['best_disease_id'] ?? "Tidak ada id penyakit";
    bestPercentageDisease = json['best_percentage_disease'] ?? "0.0";
    createdAt = json['created_at'];
    nameDisease = json['disease']?['name_disease'] ?? "Tidak ada nama penyakit";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['best_disease_id'] = bestDiseaseId;
    data['best_percentage_disease'] = bestPercentageDisease;
    data['created_at'] = createdAt;
    data['name_disease'] = nameDisease;
    return data;
  }
}

class ResultDiagnosis {
  String? id;
  String? diagnosisId;
  String? diseaseId;
  String? percentage;
  String? nameDisease;

  ResultDiagnosis({
    this.id,
    this.diagnosisId,
    this.diseaseId,
    this.percentage,
    this.nameDisease,
  });

  ResultDiagnosis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diagnosisId = json['diagnosis_id'];
    diseaseId = json['disease_id'];
    percentage = json['percentage'];
    nameDisease = json['disease']['name_disease'];
  }
}
