class Price {
  Price({
      this.hour, 
      this.day, 
      this.week, 
      this.month, 
      this.year,});

  Price.fromJson(dynamic json) {
    hour = json['hour'];
    day = json['day'];
    week = json['week'];
    month = json['month'];
    year = json['year'];
  }
  String? hour;
  String? day;
  String? week;
  String? month;
  String? year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hour'] = hour;
    map['day'] = day;
    map['week'] = week;
    map['month'] = month;
    map['year'] = year;
    return map;
  }

}