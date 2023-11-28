import 'stat_model.dart';

class StatChangesModel {
  StatChangesModel({
    this.hasChange,
    required this.stats,
  });

  StatChangesModel.fromJson(dynamic json) {
    hasChange = json['has_change'];
    stats = json['stats'] != null
        ? Stats.fromJson(json['stats'])
        : Stats(matchId: '<match_id>',playerId: '<player_id>');
  }

  bool? hasChange;
  Stats stats = Stats(matchId: '<match_id>',playerId: '<player_id>');

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['has_change'] = hasChange;
    map['stats'] = stats.toJson();
      return map;
  }
}
