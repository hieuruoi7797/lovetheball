
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/src/blocs/home_bloc/home_bloc.dart';
import 'package:splat_mobile/src/blocs/match/match_bloc.dart';
import 'package:splat_mobile/src/models/player_model.dart';
import 'package:splat_mobile/src/models/stat_model.dart';
import 'package:splat_mobile/src/resources/repository.dart';
import 'package:splat_mobile/widgets_common/dialogs.dart';

import '../../../constants/constant_values.dart';
import '../../models/stats_change_model.dart';

class GameOnBloc {
  List<PlayerModel> listPlayers = [];
  List<StatChangesModel> listStatChange = [];

  final _nowPlayerStatPublish = BehaviorSubject<Stats>();
  final _pickedPlayerIndex = BehaviorSubject<int>();
  final _pickedStatIndex = BehaviorSubject<int>();

  int pickedPlayerInt = 0;
  int pickedStatInt = 0;
  String matchId = '';

  bool? isFistEmit;

  Stream<int> get pickStatIndex => _pickedStatIndex.stream;

  Stream<int> get pickPlayerIndex => _pickedPlayerIndex.stream;

  Stream<Stats> get pickedPlayerStatPublish => _nowPlayerStatPublish.stream;


  GameOnBloc() {
    matchBloc.matchIdBehavior.listen((event) => matchId = event);
    matchBloc.addedPlayersList.listen((event) => updateListPlayers(event));
  }

  void finishMatch(BuildContext context) {
    DialogWidget().showMessageDialog(context , content: "Bạn muốn kết thúc trận đấu?").then((value)
     async {
      if(value == 'Y'){
        await repository.finishMatch(matchId: matchId).then((Response response) {
          if (jsonDecode(response.data)['status_code'] == 200){
            matchBloc.getMatchesList(context);
            Navigator.pushNamedAndRemoveUntil(context, '/home',
                ModalRoute.withName('/'));
            dispose("");
          }else{
            DialogWidget().showMessageDialog(context, content: (jsonDecode(response.data)['message']));
          }
        });
      }else{
        // Navigator.pop(context);
      }
    });
  }

  dispose(dynamic data) {
    repository.disconnect();
    repository.close();
    _pickedStatIndex.add(0);
    _nowPlayerStatPublish.add(Stats(matchId: '', playerId: ''));
    listStatChange = [];
    listPlayers = [];
    // matchBloc.getPlayerList(context: navigatorKey.currentContext!);
  }

  increase() {
    // String statType = '';
    // if (pickedStatInt == 0){
    //   statType = LAYUP;
    // } else if (pickedStatInt == 1) {
    //   statType = ASSIST;
    // } else if (pickedStatInt == 2) {
    //   statType = TWO;
    // } else if (pickedStatInt == 3) {
    //   statType = THREE;
    // }
    switch (pickedStatInt) {
      case 0:
        listStatChange[pickedPlayerInt].stats.layUp = listStatChange[pickedPlayerInt].stats.layUp! + 1;
        _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
      case 1:
        listStatChange[pickedPlayerInt].stats.assit = listStatChange[pickedPlayerInt].stats.assit! + 1;
        _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
      case 2:
        listStatChange[pickedPlayerInt].stats.twoPointsShoot = listStatChange[pickedPlayerInt].stats.twoPointsShoot! + 1;
        _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
      case 3:
        listStatChange[pickedPlayerInt].stats.threePointsShoot = listStatChange[pickedPlayerInt].stats.threePointsShoot! + 1;
        _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);

    }
    emitChangesSocket(isFirstEmit: false);
  }

  decrease() {
    switch (pickedStatInt) {
      case 2:
        if (listStatChange[pickedPlayerInt].stats.twoPointsShoot! > 0) {
          listStatChange[pickedPlayerInt].stats.twoPointsShoot =
              listStatChange[pickedPlayerInt].stats.twoPointsShoot! - 1;
          _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
        }
      case 3:
        if (listStatChange[pickedPlayerInt].stats.threePointsShoot! > 0) {
          listStatChange[pickedPlayerInt].stats.threePointsShoot =
              listStatChange[pickedPlayerInt].stats.threePointsShoot! - 1;
          _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
        }
      case 1:
        if (listStatChange[pickedPlayerInt].stats.assit! > 0) {
          listStatChange[pickedPlayerInt].stats.assit =
              listStatChange[pickedPlayerInt].stats.assit! - 1;
          _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
        }
      case 0:
        if (listStatChange[pickedPlayerInt].stats.layUp! > 0) {
          listStatChange[pickedPlayerInt].stats.layUp =
              listStatChange[pickedPlayerInt].stats.layUp! - 1;
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
    repository.socketConnect();
    if (isFirstEmit == true) {
      body = {
        "first_emit": true,
        "stats_changes": [
          {
            "has_change": false,
            "stats": {
              "match_id": matchId,
              "player_id": homeBloc.nowUserInfo!.id,
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
    repository.emitSocket('changes', body: body);
  }

  pickPlayer(int index) {
    pickedPlayerInt = index;
    updateListPlayers(listPlayers);
  }

  void updateStats(dynamic data) {
    print("RECEIVED: $data");
    List<Stats> statsList = [];
    List socketListRes = data as List;
    for (var element in socketListRes) {
      statsList.add(Stats.fromJson(element));
    }
    if (listStatChange.isNotEmpty) {
      for (int i = 0; i < statsList.length; i++) {
        listStatChange[i].stats = statsList[i];
        if (i == pickedPlayerInt){
          _nowPlayerStatPublish.sink.add(listStatChange[pickedPlayerInt].stats);
        }
    }

    }
  }

  pickStat(String s) {
    switch(s) {
      case layup:
        {
          _pickedStatIndex.sink.add(0);
          pickedStatInt = 0;
        }
      case assist: {
        _pickedStatIndex.sink.add(1);
        pickedStatInt = 1;
      }
      case mid_range: {
        _pickedStatIndex.sink.add(2);
        pickedStatInt = 2;
      }
      case three_points:  {
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

final GameOnBloc gameOnBloc = GameOnBloc();

