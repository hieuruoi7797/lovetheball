import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../public/public_methods.dart';

class MatchBloc {
  final _repository = Repository();
  final _matchCreator = PublishSubject<Response>();
  final _statusBehaviors = BehaviorSubject<String>();
  final _userName = PublishSubject<String>();

  Stream<Response> get createMatchRes => _matchCreator.stream;

  Stream<String> get status => _statusBehaviors.stream;

  Stream<String> get userName => _userName.stream;

  changeStatus(String statusChange) async {
    _statusBehaviors.sink.add(statusChange);
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

  Future<String> getPlayerSavedName() async{
    PlayerModel playerSaved = await PublicMethod().readContentPlayer();
    _userName.sink.add(playerSaved.name);
    return playerSaved.name;
  }

  dispose() {
    _matchCreator.close();
    _statusBehaviors.close();
  }
}

final matchBloc = MatchBloc();
