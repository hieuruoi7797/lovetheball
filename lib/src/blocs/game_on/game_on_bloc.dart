import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_record/src/blocs/match/match_creating_bloc.dart';
import 'package:splat_record/src/models/full_stat_model.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/src/models/stat_model.dart';
import 'package:splat_record/src/resources/repository.dart';

import '../../../constants/constant_values.dart';

class GameOnBloc {
  List<PlayerModel> listPlayers = [];
  List<FullStatModel> listPlayersStat = [];

  final _repository = Repository();
  final _nowPlayerStatPublish = PublishSubject<FullStatModel>();
  final _nowPickIndex = BehaviorSubject<int>();

  int pickedInt = 0;

  Stream<int> get nowPickIndex => _nowPickIndex.stream;

  Stream<FullStatModel> get pickedPlayerStatPublish => _nowPlayerStatPublish.stream;

  GameOnBloc() {
  matchBloc.addedPlayersList.listen((event) => updateListPlayers(event));
  }

  dispose() {
    _nowPlayerStatPublish.close();
  }

  increase(String statType) {
    switch (statType) {
      case TWO:
        listPlayersStat[pickedInt].twoPointer = listPlayersStat[pickedInt].twoPointer + 1;
        _nowPlayerStatPublish.sink.add(listPlayersStat[pickedInt]);
      case THREE:
        listPlayersStat[pickedInt].threePointer = listPlayersStat[pickedInt].threePointer + 1;
        _nowPlayerStatPublish.sink.add(listPlayersStat[pickedInt]);
      case ASSIST:
        listPlayersStat[pickedInt].assist = listPlayersStat[pickedInt].assist + 1;
        _nowPlayerStatPublish.sink.add(listPlayersStat[pickedInt]);
    }
  }

  decrease(String s) {
    switch (s) {
      case TWO:
        if (listPlayersStat[pickedInt].twoPointer > 0) {
          listPlayersStat[pickedInt].twoPointer =
              listPlayersStat[pickedInt].twoPointer - 1;
          _nowPlayerStatPublish.sink.add(listPlayersStat[pickedInt]);
        }
      case THREE:
        if (listPlayersStat[pickedInt].threePointer > 0) {
          listPlayersStat[pickedInt].threePointer =
              listPlayersStat[pickedInt].threePointer - 1;
          _nowPlayerStatPublish.sink.add(listPlayersStat[pickedInt]);
        }
      case ASSIST:
        if (listPlayersStat[pickedInt].assist > 0) {
          listPlayersStat[pickedInt].assist =
              listPlayersStat[pickedInt].assist - 1;
          _nowPlayerStatPublish.sink.add(listPlayersStat[pickedInt]);
        }
    }
  }

  void updateListPlayers(List<PlayerModel> list) {
    listPlayers = list;
    _nowPickIndex.sink.add(pickedInt);
    for (PlayerModel e in listPlayers){
      listPlayersStat.add(FullStatModel(playerId: e.id));
    }
    _nowPlayerStatPublish.sink.add(listPlayersStat[pickedInt]);
  }

  pickPlayer(int index) {
    pickedInt = index;
    updateListPlayers(listPlayers);
  }
}
