
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_record/src/app.dart';
import 'package:splat_record/src/blocs/match/match_creating_bloc.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/src/models/stat_model.dart';
import 'package:splat_record/src/resources/repository.dart';
import 'package:splat_record/widgets_common/dialogs.dart';

import '../../../constants/constant_values.dart';
import '../../models/stats_change_model.dart';

class GameOnBloc {
  List<PlayerModel> listPlayers = [];
  List<StatChangesModel> listStatChange = [];

  final _repository = Repository();
  final _nowPlayerStatPublish = PublishSubject<Stats>();
  final _pickedPlayerIndex = BehaviorSubject<int>();
  final _pickedStatIndex = BehaviorSubject<int>();

  int pickedPlayerInt = 0;
  int pickedStatInt = 0;
  String matchId = '';

  Stream<int> get pickStatIndex => _pickedStatIndex.stream;

  Stream<int> get pickPlayerIndex => _pickedPlayerIndex.stream;

  Stream<Stats> get pickedPlayerStatPublish => _nowPlayerStatPublish.stream;


  GameOnBloc() {
    matchBloc.matchIdBehavior.listen((event) => matchId = event);
    matchBloc.addedPlayersList.listen((event) => updateListPlayers(event));
    _repository.gameOnApiProvider.socketConnect();
    _repository.gameOnApiProvider.socket.on('get_stats', (data) => updateStats(data));
    _repository.gameOnApiProvider.socket.on('disconnect', (data) => dispose(data));
    emitChangesSocket(isFirstEmit: true);
  }

  void finishMatch() {
    DialogWidget().showMessageDialog(navigatorKey.currentContext! , content: "Bạn muốn kết thúc trận đấu?").then((value)
     async {
      if(value == 'Y'){
        await _repository.gameOnApiProvider.finishMatch(matchId: matchId).then((Response response) {
          if (jsonDecode(response.body)['status_code'] == 200){
            Navigator.pushReplacementNamed(navigatorKey.currentContext!, '/home');
          }else{
            DialogWidget().showMessageDialog(navigatorKey.currentContext!, content: (jsonDecode(response.body)['message']));
          }
        });
      }else{
        Navigator.pop(navigatorKey.currentContext!);
      }
    });
  }

  dispose(dynamic data) {
    _repository.gameOnApiProvider.socket.disconnect();
    _repository.gameOnApiProvider.socket.close();
  }

  increase() {
    String statType = '';
    if (pickedStatInt == 0){
      statType = LAYUP;
    } else if (pickedStatInt == 1) {
      statType = ASSIST;
    } else if (pickedStatInt == 2) {
      statType = TWO;
    } else if (pickedStatInt == 3) {
      statType = THREE;
    }
    switch (statType) {
      case LAYUP:
        listStatChange[pickedPlayerInt].stats.layUp = listStatChange[pickedPlayerInt].stats.layUp! + 1;
        _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
      case TWO:
        listStatChange[pickedPlayerInt].stats.twoPointsShoot = listStatChange[pickedPlayerInt].stats.twoPointsShoot! + 1;
        _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
      case THREE:
        listStatChange[pickedPlayerInt].stats.threePointsShoot = listStatChange[pickedPlayerInt].stats.threePointsShoot! + 1;
        _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
      case ASSIST:
        listStatChange[pickedPlayerInt].stats.assit = listStatChange[pickedPlayerInt].stats.assit! + 1;
        _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
    }
    emitChangesSocket(isFirstEmit: false);
  }

  decrease() {
    String statType = '';
    if (pickedStatInt == 0){
      statType = LAYUP;
    } else if (pickedStatInt == 1) {
      statType = ASSIST;
    } else if (pickedStatInt == 2) {
      statType = TWO;
    } else if (pickedStatInt == 3) {
      statType = THREE;
    }
    switch (statType) {
      case TWO:
        if (listStatChange[pickedPlayerInt].stats.twoPointsShoot! > 0) {
          listStatChange[pickedPlayerInt].stats.twoPointsShoot =
              listStatChange[pickedPlayerInt].stats.twoPointsShoot! - 1;
          _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
        }
      case THREE:
        if (listStatChange[pickedPlayerInt].stats.threePointsShoot! > 0) {
          listStatChange[pickedPlayerInt].stats.threePointsShoot =
              listStatChange[pickedPlayerInt].stats.threePointsShoot! - 1;
          _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
        }
      case ASSIST:
        if (listStatChange[pickedPlayerInt].stats.assit! > 0) {
          listStatChange[pickedPlayerInt].stats.assit =
              listStatChange[pickedPlayerInt].stats.assit! - 1;
          _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
        }
    }
    emitChangesSocket(isFirstEmit: false);
  }

  void updateListPlayers(List<PlayerModel> list) {
    listPlayers = list;
    _pickedPlayerIndex.sink.add(pickedPlayerInt);
    for (PlayerModel e in listPlayers){
      listStatChange.add(
          StatChangesModel(
              hasChange: false,
              stats: Stats(
                playerId: e.id,
                matchId: matchId
              )));
    }
    _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
    _pickedStatIndex.add(pickedStatInt);
    //Connect to Socket and emit the first event

  }

  void emitChangesSocket({bool? isFirstEmit}) {
    Map body = {};
    if (isFirstEmit == true) {
      body = {
        "first_emit": true,
        "stats_changes": [
          {
            "has_change": false,
            "stats": {
              "match_id": "<match_id>",
              "player_id": "<player_id>",
              "lay_up": 0,
              "assit": 0,
              "two_points_shoot": 0,
              "three_points_shoot": 0,
              "rebound": 0,
              "block": 0,
              "steal": 0,
              "personal_foul": 0,
              "turn_over": 0,
              "dunk": 0
            }
          }
        ]
      };
    } else {
      List<Map> listStatsMap = [];
      for (var element in listStatChange) {
        if (listStatChange.indexOf(element) == pickedPlayerInt) {
          element.hasChange = true;
        } else {
          element.hasChange = false;
        }
        listStatsMap.add(element.toJson());
      }
      body = {
        "first_emit": false,
        "stats_changes": listStatsMap
      };
    }
    _repository.gameOnApiProvider.emitSocket('changes', body: body);
  }

  pickPlayer(int index) {
    pickedPlayerInt = index;
    updateListPlayers(listPlayers);
  }

  void updateStats(dynamic data) {
    print("DATA: $data");
    List<Stats> statsList = [];
    List socketListRes = data as List;
    for (var element in socketListRes) {
      statsList.add(Stats.fromJson(element));
    }
    for (int i = 0; i < statsList.length; i++) {
      listStatChange[i].stats = statsList[i];
      if (i == pickedPlayerInt){
        _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
      }
    }
  }

  pickStat(String s) {
    switch(s) {
      case LAYUP:
        {
          _pickedStatIndex.sink.add(0);
          pickedStatInt = 0;
        }
      case ASSIST: {
        _pickedStatIndex.sink.add(1);
        pickedStatInt = 1;
      }
      case TWO: {
        _pickedStatIndex.sink.add(2);
        pickedStatInt = 2;
      }
      case THREE:  {
        _pickedStatIndex.sink.add(3);
        pickedStatInt = 3;
      }
    }
  }
}

class StatType {
  StatType({required this.typeName, required this.quantity});
  String typeName;
  int quantity;
}
