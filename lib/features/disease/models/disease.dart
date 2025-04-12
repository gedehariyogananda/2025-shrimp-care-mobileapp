class Disease {
  String? id;
  String? nameDisease;
  String? imageDisease;
  String? descriptionDisease;
  int? riskLevel;

  Disease({this.nameDisease, this.imageDisease, this.riskLevel});

  Disease.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameDisease = json['name_disease'];
    imageDisease = json['image_disease'];
    riskLevel = json['risk_level'];
    descriptionDisease = json['definition_disease'] ?? "Tidak ada deskripsi";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name_disease'] = nameDisease;
    data['image_disease'] = imageDisease;
    data['risk_level'] = riskLevel;
    data['definition_disease'] = descriptionDisease;
    return data;
  }
}
