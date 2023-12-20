/// id_ : "050e5c13-a778-4aef-a81e-d5866f0eeb27"
/// name : "giao luu vo thuat"
/// location : "DH SU PHAM"
/// type_ : 0
/// status : 0
/// players : ["5f9ecf2d-b79b-4f32-b709-701e3010801f","88e0b1b2-97cb-4bfa-bfec-c1a4f47dace9","984c727a-1cfd-4ac4-84c2-efa4e9c328d4","5367ba2b-1c83-4d33-832a-9036ed2667a1","3519f8b4-8fe0-4a1b-92d1-1be11c7157c5"]
/// created_at : "2023-11-10T09:48:20.430698"
/// updated_at : null

class MatchModel {
  MatchModel({
      String? id, 
      String? name, 
      String? location, 
      int? type,
      int? status,
      List<String>? players, 
      String? createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _name = name;
    _location = location;
    _type = type;
    _status = status;
    _players = players;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  MatchModel.fromJson(dynamic json) {
    _id = json['id_'];
    _name = json['name'];
    _location = json['location'];
    _type = json['type_'];
    _status = json['status'];
    _players = json['players'] != null ? json['players'].cast<String>() : [];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _name;
  String? _location;
  int? _type;
  int? _status;
  List<String>? _players;
  String? _createdAt;
  dynamic _updatedAt;
MatchModel copyWith({  String? id,
  String? name,
  String? location,
  int? type,
  int? status,
  List<String>? players,
  String? createdAt,
  dynamic updatedAt,
}) => MatchModel(  id: id ?? _id,
  name: name ?? _name,
  location: location ?? _location,
  type: type ?? _type,
  status: status ?? _status,
  players: players ?? _players,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get location => _location;
  num? get type => _type;
  num? get status => _status;
  List<String>? get players => _players;
  String? get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_'] = _id;
    map['name'] = _name;
    map['location'] = _location;
    map['type_'] = _type;
    map['status'] = _status;
    map['players'] = _players;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}