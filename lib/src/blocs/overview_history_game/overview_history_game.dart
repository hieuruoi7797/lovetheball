
import 'package:flutter/material.dart';

import '../../../constants/constant_values.dart';
import '../../app.dart';

class OverviewHistoryGame {
    List<dynamic> listIconMatch =[
      SVG_LAYUP,
      SVG_ASSIST,
      SVG_3POINT,
      SVG_MID_RANGE_SHOT,
      SVG_REBOUND
    ];
    goToDetail(){
      Navigator.pushNamed(navigatorKey.currentContext!, "/overview_history_game");
    }
}
final  historyGame = OverviewHistoryGame();