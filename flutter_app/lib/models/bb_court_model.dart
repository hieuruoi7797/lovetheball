import 'price_model.dart';
import 'attributes_model.dart';

class BbCourtModel {
  BbCourtModel({
     required this.name,
     required this.location,
     required this.type,
      this.price,
      this.attributes,});

  BbCourtModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    type = json['type'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    attributes = json['attributes'] != null ? Attributes.fromJson(json['attributes']) : null;
  }
  String? name;
  String? location;
  int? type;
  Price? price;
  Attributes? attributes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['location'] = location;
    map['type'] = type;
    if (price != null) {
      map['price'] = price!.toJson();
    }
    if (attributes != null) {
      map['attributes'] = attributes!.toJson();
    }
    return map;
  }

}