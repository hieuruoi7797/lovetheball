class PlayerModel {
  PlayerModel({
    required this.id,
    required this.name,
    this.gender,
    this.birthDate,
    this.email,
    this.phone,
    this.status,
    this.inMatch,
    this.createdAt,
    this.updatedAt,
  });

  PlayerModel.fromJson(Map json) {
    id = json['id_'];
    name = json['name'];
    gender = json['gender'] ?? 0;
    birthDate = json['birth_date'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    status = json['status'] ?? false;
    inMatch = json['in_match'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
  }

  String id = '';
  String name = '';
  int? gender;
  String? birthDate;
  String? email;
  String? phone;
  bool? status;
  String? inMatch;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_'] = id;
    map['name'] = name;
    map['gender'] = gender;
    map['birth_date'] = birthDate;
    map['email'] = email;
    map['phone'] = phone;
    map['status'] = status;
    map['in_match'] = inMatch;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
