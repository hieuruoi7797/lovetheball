
import 'package:flutter/material.dart';

import '../../../constants/constant_values.dart';
import '../../app.dart';

class OverviewHistoryGame {
    bool selectToggle =false;
    int selectValue =0;
    List<dynamic> listIconMatch =[
      layup,
      assist,
      three_points,
      mid_range,
      rebound
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