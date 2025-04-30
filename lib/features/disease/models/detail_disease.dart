import 'package:shrimp_care_mobileapp/config/api_server.dart';

class DetailDisease {
  String? id;
  String? nameDisease;
  String? imageDisease;
  int? riskLevel;
  String? definitionDisease;
  String? symtomsDisease;
  String? causesDisease;
  String? moreInformation;
  String? preventionDisease;
  String? recomendationDisease;

  DetailDisease({
    this.id,
    this.nameDisease,
    this.imageDisease,
    this.definitionDisease,
    this.symtomsDisease,
    this.causesDisease,
    this.moreInformation,
    this.preventionDisease,
    this.recomendationDisease,
    this.riskLevel,
  });

  DetailDisease.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    nameDisease = json['name_disease'];
    imageDisease = "${ApiUrl.storageUrl}${json['image_disease']}";
    riskLevel = json['resk_level'];
    definitionDisease =
        json['information']['definition_disease'] ?? "Tidak ada definisi";
    symtomsDisease =
        json['information']['symptoms_disease'] ?? "Tidak ada gejala";
    causesDisease =
        json['information']['causes_disease'] ?? "Tidak ada penyebab";
    moreInformation = json['information']['more_information_disease'] ??
        "Tidak ada informasi lebih lanjut";
    preventionDisease =
        json['prevention']['prevention_disease'] ?? "Tidak ada pencegahan";
    recomendationDisease =
        json['prevention']['recomendation_disease'] ?? "Tidak ada rekomendasi";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_disease'] = nameDisease;
    data['risk_level'] = riskLevel;
    data['image_disease'] = imageDisease;
    data['definition_disease'] = definitionDisease;
    data['symptoms_disease'] = symtomsDisease;
    data['causes_disease'] = causesDisease;
    data['more_information_disease'] = moreInformation;
    data['prevention_disease'] = preventionDisease;
    data['recomendation_disease'] = recomendationDisease;
    return data;
  }
}
