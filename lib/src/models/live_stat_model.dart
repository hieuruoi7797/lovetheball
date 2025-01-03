import 'package:splat_mobile/src/models/player_model.dart';

class LiveStatModel {
  String statName;
  PlayerModel player;
  String timeStamp;
    LiveStatModel({
      required this.statName,
      required this.player,
      required this.timeStamp
  });
}