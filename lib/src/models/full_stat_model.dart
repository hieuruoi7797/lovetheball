class FullStatModel {
  FullStatModel({
    required this.playerId,
      });

  FullStatModel.fromJson(dynamic json) {
    playerId = json['playerId'];
    twoPointer = json['2pointer'];
    threePointer = json['3pointer'];
    assist = json['assist'];
    rebound = json['rebound'];
    block = json['block'];
    steal = json['steal'];
    personalFoul = json['personalFoul'];
    turnOver = json['turnOver'];
  }
  String playerId = 'none';
  int twoPointer = 0;
  int threePointer = 0;
  int assist = 0;
  int rebound = 0;
  int block = 0;
  int steal = 0;
  int personalFoul = 0;
  int turnOver = 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['2pointer'] = twoPointer;
    map['3pointer'] = threePointer;
    map['assist'] = assist;
    map['rebound'] = rebound;
    map['block'] = block;
    map['steal'] = steal;
    map['personalFoul'] = personalFoul;
    map['turnOver'] = turnOver;
    return map;
  }

}