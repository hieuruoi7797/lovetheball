class BasketballMatchSettingModel {
  int? format;
  int? numbersOfRound;
  int? timeOfEachRound;
  int? timeOfSubRound;
  int? cutOffPoints;
  int? threePointsValue;
  bool? enableFreeThrow;
  int? personalFoulsLimit;

  BasketballMatchSettingModel({
    this.format,
    this.numbersOfRound,
    this.timeOfEachRound,
    this.timeOfSubRound,
    this.cutOffPoints,
    this.threePointsValue,
    this.enableFreeThrow,
    this.personalFoulsLimit,
    });

  BasketballMatchSettingModel.fromJson(Map json){
    format = json['format_'];
    numbersOfRound = json['numbers_of_round'];
    timeOfEachRound = json['time_of_each_round'];
    timeOfSubRound = json['time_of_sub_round'];
    cutOffPoints = json['cut_off_points'];
    threePointsValue = json['three_point_points'];
    enableFreeThrow = json['enable_free_throw'];
    personalFoulsLimit = json['personal_fouls_limit'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['format_'] = format;
    map['numbers_of_round'] = numbersOfRound;
    map['time_of_each_round'] = timeOfEachRound;
    map['time_of_sub_round'] = timeOfSubRound;
    map['cut_off_points'] = cutOffPoints;
    map['three_point_points'] = threePointsValue;
    map['enable_free_throw'] = enableFreeThrow;
    map['personal_fouls_limit'] = personalFoulsLimit;
    return map;
  }
  ///FREE_MATCH = 0
  //     NORMAL_5X5_MATCH = 1
  //     NORMAL_3X3_MATCH = 2
  //     PRO_5X5_MATCH = 3
  //     PRO_3X3_MATCH = 4
}