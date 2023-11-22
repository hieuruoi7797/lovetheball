import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_record/src/blocs/match/match_creating_bloc.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/src/models/stat_model.dart';
import 'package:splat_record/src/resources/repository.dart';

class GameOnBloc {
  List<PlayerModel> listPlayers = [];

  final _repository = Repository();
  final _twoPointerQuantity = PublishSubject<int>();
  final _nowPickIndex = BehaviorSubject<int>();

  int twoPointerQuantityInt = 0;
  int pickedInt = 0;

  Stream<int> get nowPickIndex => _nowPickIndex.stream;

  Stream<int> get twoPointerQuantity => _twoPointerQuantity.stream;

  GameOnBloc() {
  matchBloc.addedPlayersList.listen((event) => updateListPlayers(event));
  }

  dispose() {
    _twoPointerQuantity.close();
  }

  increase(String statType) {
    switch (statType) {
      case "2-Pointer":
        twoPointerQuantityInt++;
        _twoPointerQuantity.sink.add(twoPointerQuantityInt);
    }
  }

  decrease(String s) {
    switch (s) {
      case "2-Pointer":
        if (twoPointerQuantityInt > 0) {
          twoPointerQuantityInt--;
          _twoPointerQuantity.sink.add(twoPointerQuantityInt);
        }
    }
  }

  void updateListPlayers(List<PlayerModel> list) {
    listPlayers = list;
    _nowPickIndex.sink.add(pickedInt);
  }

  pickPlayer(int index) {
    pickedInt = index;
    updateListPlayers(listPlayers);
  }
}
