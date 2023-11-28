class Stats {
  Stats({
      required this.matchId,
      required this.playerId,
      this.layUp, 
      this.assit, 
      this.twoPointsShoot,
      this.threePointsShoot, 
      this.rebound, 
      this.block, 
      this.steal, 
      this.personalFoul, 
      this.turnOver, 
      this.dunk,}){
    twoPointsShoot ??= 0;
    threePointsShoot ??= 0;
    assit ??= 0;
  }

  Stats.fromJson(dynamic json) {
    matchId = json['match_id'];
    playerId = json['player_id'];
    layUp = json['lay_up'];
    assit = json['assit'];
    twoPointsShoot = json['two_points_shoot'];
    threePointsShoot = json['three_points_shoot'];
    rebound = json['rebound'];
    block = json['block'];
    steal = json['steal'];
    personalFoul = json['personal_foul'];
    turnOver = json['turn_over'];
    dunk = json['dunk'];
  }
  String matchId = "<match_id>";
  String playerId = "<player_id>";
  int? layUp;
  int? assit;
  int? twoPointsShoot;
  int? threePointsShoot;
  int? rebound;
  int? block;
  int? steal;
  int? personalFoul;
  int? turnOver;
  int? dunk;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['match_id'] = matchId;
    map['player_id'] = playerId;
    map['lay_up'] = layUp ?? 0;
    map['assit'] = assit ?? 0;
    map['two_points_shoot'] = twoPointsShoot ?? 0;
    map['three_points_shoot'] = threePointsShoot ?? 0;
    map['rebound'] = rebound ?? 0;
    map['block'] = block ?? 0;
    map['steal'] = steal ?? 0;
    map['personal_foul'] = personalFoul ?? 0;
    map['turn_over'] = turnOver ?? 0;
    map['dunk'] = dunk ?? 0;
    return map;
  }

}