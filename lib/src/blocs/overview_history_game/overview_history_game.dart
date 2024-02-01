
import 'package:flutter/material.dart';

import '../../../constants/constant_values.dart';
import '../../app.dart';

class OverviewHistoryGame {
    bool selectToggle =false;
    int selectValue =0;
    List<dynamic> listIconMatch =[
      SVG_LAYUP,
      SVG_ASSIST,
      SVG_3POINT,
      SVG_MID_RANGE_SHOT,
      SVG_REBOUND
    ];
    void checkSelectToggle(int index){
      selectValue = index;

      if(selectToggle==true){
        selectToggle=false;
      }
      if(selectToggle==false){
        selectToggle =true;
      }
      print('da click');
      print(selectValue);
      print(selectToggle);
    }
    goToDetail(){
      Navigator.pushNamed(navigatorKey.currentContext!, "/overview_history_game");
    }
}
final  historyGame = OverviewHistoryGame();