import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_record/src/blocs/match/match_creating_bloc.dart';
import 'package:splat_record/src/models/full_stat_model.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/src/models/stat_model.dart';
import 'package:splat_record/src/resources/repository.dart';

import '../../../constants/constant_values.dart';
import '../../models/stats_change_model.dart';

class GameOnBloc {
  List<PlayerModel> listPlayers = [];
  List<StatChangesModel> listStatChange = [];

  final _repository = Repository();
  final _nowPlayerStatPublish = PublishSubject<Stats>();
  final _nowPickIndex = BehaviorSubject<int>();

  int pickedInt = 0;
  String matchId = '';

  Stream<int> get nowPickIndex => _nowPickIndex.stream;

  Stream<Stats> get pickedPlayerStatPublish => _nowPlayerStatPublish.stream;

  GameOnBloc() {
  matchBloc.addedPlayersList.listen((event) => updateListPlayers(event));
  }

  dispose() {
    _nowPlayerStatPublish.close();
  }

  increase(String statType) {
    switch (statType) {
      case TWO:
        listStatChange[pickedInt].stats.twoPointsShoot = listStatChange[pickedInt].stats.twoPointsShoot! + 1;
        _nowPlayerStatPublish.sink.add(listStatChange[pickedInt].stats);
      case THREE:
        listStatChange[pickedInt].stats.threePointsShoot = listStatChange[pickedInt].stats.threePointsShoot! + 1;
        _nowPlayerStatPublish.sink.add(listStatChange[pickedInt].stats);
      case ASSIST:
        listStatChange[pickedInt].stats.assit = listStatChange[pickedInt].stats.assit! + 1;
        _nowPlayerStatPublish.sink.add(listStatChange[pickedInt].stats);
    }
    emitChangesSocket(isFirstEmit: false);
  }

  decrease(String s) {
    switch (s) {
      case TWO:
        if (listStatChange[pickedInt].stats.twoPointsShoot! > 0) {
          listStatChange[pickedInt].stats.twoPointsShoot =
              listStatChange[pickedInt].stats.twoPointsShoot! - 1;
          _nowPlayerStatPublish.sink.add(listStatChange[pickedInt].stats);
        }
      case THREE:
        if (listStatChange[pickedInt].stats.threePointsShoot! > 0) {
          listStatChange[pickedInt].stats.threePointsShoot =
              listStatChange[pickedInt].stats.threePointsShoot! - 1;
          _nowPlayerStatPublish.sink.add(listStatChange[pickedInt].stats);
        }
      case ASSIST:
        if (listStatChange[pickedInt].stats.assit! > 0) {
          listStatChange[pickedInt].stats.assit =
              listStatChange[pickedInt].stats.assit! - 1;
          _nowPlayerStatPublish.sink.add(listStatChange[pickedInt].stats);
        }
    }
    emitChangesSocket(isFirstEmit: false);
  }

  void updateListPlayers(List<PlayerModel> list) {
    listPlayers = list;
    _nowPickIndex.sink.add(pickedInt);
    for (PlayerModel e in listPlayers){
      listStatChange.add(
          StatChangesModel(
              hasChange: false,
              stats: Stats(
                playerId: e.id,
                matchId: '<UNKNOWN>'
              )));
    }
    _nowPlayerStatPublish.sink.add(listStatChange[pickedInt].stats);

    //Connect to Socket and emit the first event
    _repository.gameOnApiProvider.socketConnect();
    // _repository.gameOnApiProvider.emitSocket('changes', body: {
    //   "first_emit": true,
    //   "stats_changes": [
    //     {
    //       "has_change": false,
    //       "stats": {
    //         "match_id": "<match_id>",
    //         "player_id": "<player_id>",
    //         "lay_up": 0,
    //         "assit": 0,
    //         "two_points_shoot": 0,
    //         "three_points_shoot": 0,
    //         "rebound": 0,
    //         "block": 0,
    //         "steal": 0,
    //         "personal_foul": 0,
    //         "turn_over": 0,
    //         "dunk": 0
    //       }
    //     }
    //   ]
    // });
    _repository.gameOnApiProvider.socket.on('event', (data) => print("RECEIVED $data"));
    emitChangesSocket(isFirstEmit: true);
  }

  void emitChangesSocket({bool? isFirstEmit}){
    Map body = {};
    if (isFirstEmit == true){
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
    }else{
      List<Map> listStatsMap = [];
      for (var element in listStatChange) {
        if (listStatChange.indexOf(element) == pickedInt){
          element.hasChange = true;
        }else{
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
    pickedInt = index;
    updateListPlayers(listPlayers);
  }
}
