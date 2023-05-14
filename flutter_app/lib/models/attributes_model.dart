class Attributes {
  Attributes({
      this.length, 
      this.width, 
      this.hoopHeight, 
      this.backboardSize,});

  Attributes.fromJson(dynamic json) {
    length = json['length'];
    width = json['width'];
    hoopHeight = json['hoop_height'];
    backboardSize = json['backboard_size'];
  }
  String? length;
  String? width;
  String? hoopHeight;
  String? backboardSize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['length'] = length;
    map['width'] = width;
    map['hoop_height'] = hoopHeight;
    map['backboard_size'] = backboardSize;
    return map;
  }

}