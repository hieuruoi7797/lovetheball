import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_record/widgets_common/loading.dart';

import '../../../public/public_methods.dart';

class MatchBloc {
  final _repository = Repository();
  final _matchCreator = PublishSubject<Response>();
  final _statusBehaviors = BehaviorSubject<String>();
  final _userName = PublishSubject<String>();
  final _playersList = PublishSubject<List<PlayerModel>>();

  Stream<Response> get createMatchRes => _matchCreator.stream;

  Stream<String> get status => _statusBehaviors.stream;

  Stream<String> get userName => _userName.stream;

  Stream<List<PlayerModel>> get playerList => _playersList.stream;

  changeStatus(String statusChange) async {
    _statusBehaviors.sink.add(statusChange);
  }

  getPlayerList({
    required BuildContext context,
  }) async {
    Response response;
     response = await _repository.getPlayers(
        context: context,);
     List<dynamic> listPlayerRes = jsonDecode(response.body)['data'] as List;
     List<PlayerModel> listPlayers = [];
    for (int i = 0; i < 5; i++){
      listPlayers.add(PlayerModel.fromJson(listPlayerRes[i]));
    }
    print("LIST: ${listPlayers.length}");
    _playersList.sink.add(listPlayers);
  }

  createMatch({
    required BuildContext context,
    required String name,
    required String location,
    required int type,
    required List<String> players,
  }) async {
    Response response = await _repository.createMatch(
        context: context,
        name: name,
        location: location,
        type: type,
        players: players);
    _matchCreator.sink.add(response);
  }

  Future<void> getPlayerSavedName(BuildContext context) async{
    PlayerModel? playerSaved ;
    dynamic savedPlayerFile = await PublicMethod().readContentPlayer();
    if (savedPlayerFile is PlayerModel){
      playerSaved = savedPlayerFile;
      _userName.sink.add(playerSaved.name);
      await Future.delayed(Duration.zero,(){
        getPlayerList(context: context);
      });
      return;
    }else if (savedPlayerFile == "Error"){
      if (context.mounted) DialogWidget().showFailDialog(context, "LOADING FILE FAIL");
      return;
    }

  }

  dispose() {
    _matchCreator.close();
    _statusBehaviors.close();
  }
}

final matchBloc = MatchBloc();
