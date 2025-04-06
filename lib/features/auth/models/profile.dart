class Profile {
  String? id;
  String? username;
  String? email;
  String? employment;
  String? roles;
  String? googleId;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
      this.username,
      this.email,
      this.employment,
      this.roles,
      this.googleId,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    employment = json['employment'];
    roles = json['roles'];
    googleId = json['google_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['employment'] = employment;
    data['roles'] = roles;
    data['google_id'] = googleId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
