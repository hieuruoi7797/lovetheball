/// email : "xinhkg00@gmail.com"
/// password : "12345"

class InfoLoginModel {
  InfoLoginModel({
      String? email, 
      String? password,}){
    _email = email;
    _password = password;
}

  InfoLoginModel.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
  }
  String? _email;
  String? _password;
InfoLoginModel copyWith({  String? email,
  String? password,
}) => InfoLoginModel(  email: email ?? _email,
  password: password ?? _password,
);
  String? get email => _email;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['password'] = _password;
    return map;
  }

}