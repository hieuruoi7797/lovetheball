/// title : "Mật khẩu phải có ít nhất 8 ký tự"
/// isChecked : false

class CheckInputModel {
  CheckInputModel({
      String? title, 
      bool? isChecked,}){
    _title = title;
    _isChecked = isChecked;
}

  CheckInputModel.fromJson(dynamic json) {
    _title = json['title'];
    _isChecked = json['isChecked'];
  }
  String? _title;
  bool? _isChecked;
CheckInputModel copyWith({  String? title,
  bool? isChecked,
}) => CheckInputModel(  title: title ?? _title,
  isChecked: isChecked ?? _isChecked,
);
  String? get title => _title;
  bool? get isChecked => _isChecked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['isChecked'] = _isChecked;
    return map;
  }

}