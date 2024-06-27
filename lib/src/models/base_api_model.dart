/// data : "string"
/// count : 0
/// message : {"msg_code":"string","msg_name":"string","status_code":0}

class BaseApiModel {
  BaseApiModel({
    this.data,
    this.count,
    this.message,
  });

  BaseApiModel.fromJson(Map json) {
    data = json['data']??"";
    count = json['count']?? 0;
    message = json['message'] ?? {};
  }

  dynamic data;
  dynamic count;
  dynamic message;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['count'] = count;
    map['message'] = message;
    return map;
  }
}