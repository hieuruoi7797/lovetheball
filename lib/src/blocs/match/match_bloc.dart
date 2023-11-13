import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_record/widgets_common/dialogs.dart';

import '../../../public/public_methods.dart';

class MatchBloc {
  final _repository = Repository();
  final _matchCreator = PublishSubject<Response>();
  final _statusBehaviors = BehaviorSubject<String>();
  final _userName = PublishSubject<String>();
  final _addedPlayersList = PublishSubject<List<PlayerModel>>();
  final _morePlayersList = PublishSubject<List<PlayerModel>>();
  List<PlayerModel> playersListAdded = [];
  List<PlayerModel> playersListMore = [];

  Stream<Response> get createMatchRes => _matchCreator.stream;

  Stream<String> get status => _statusBehaviors.stream;

  Stream<String> get userName => _userName.stream;

  Stream<List<PlayerModel>> get addedPlayersList => _addedPlayersList.stream;

  Stream<List<PlayerModel>> get morePlayersList => _morePlayersList.stream;

  changeStatus(String statusChange) async {
    _statusBehaviors.sink.add(statusChange);
  }

  getPlayerList({required BuildContext context, bool? isAdding}) async {
    Response response;
    response = await _repository.getPlayers(
      context: context,
    );
    List<dynamic> listPlayerRes = jsonDecode(response.body)['data'] as List;
    List<PlayerModel> listPlayers = [];
    if (isAdding == true) {
      for (int i = 5; i < 15; i++) {
        listPlayers.add(PlayerModel.fromJson(listPlayerRes[i]));
        _morePlayersList.sink.add(listPlayers);
      }
      return;
    } else {
      for (int i = 0; i < 5; i++) {
        listPlayers.add(PlayerModel.fromJson(listPlayerRes[i]));
        _addedPlayersList.sink.add(listPlayers);
      }
      return;
    }
  }

  createMatch({
    required BuildContext context,
    required String name,
  }) async {
    List<String> listPlayersString = [];
    playersListAdded.forEach((element) {
      listPlayersString.add(element.id);
    });
    Response response = await _repository.createMatch(
        context: context,
        name: name,
        location: "DH SU PHAM",
        type: 0,
        players: listPlayersString);
    _matchCreator.sink.add(response);
    if (response.statusCode == 201) {
      if (context.mounted) {
        await DialogWidget().showResultDialog(context,
            isSuccess: true, content: "Tạo game thành công!");
      }
    }
    _matchCreator.sink.add(response);
  }

  Future<void> getPlayerSavedName(BuildContext context) async {
    PlayerModel? playerSaved;
    dynamic savedPlayerFile = await PublicMethod().readContentPlayer();
    if (savedPlayerFile is PlayerModel) {
      playerSaved = savedPlayerFile;
      _userName.sink.add(playerSaved.name);
      await Future.delayed(Duration.zero, () {
        getPlayerList(context: context);
      });
      return;
    } else if (savedPlayerFile == "Error") {
      if (context.mounted) {
        DialogWidget().showFailDialog(context, "LOADING FILE FAIL");
      }
      return;
    }
  }

  dispose() {
    _matchCreator.close();
    _statusBehaviors.close();
  }

  Future<void> showAddingPlayersBottom(BuildContext context) async {
    if (context.mounted) DialogWidget().showAddingPlayerBottom(context);
    await getPlayerList(context: context, isAdding: true);
  }

  addPlayersTap(BuildContext context) {}

  removePlayerTap(int index, BuildContext context, String nameOfGame) async {
    String result = await DialogWidget().showMessageDialog(context,
        content:
            "Bạn có chắc chắn xoá ${playersListAdded[index].name} khỏi $nameOfGame?");
    if (result == "Y") {
      playersListAdded.remove(playersListAdded[index]);
      _addedPlayersList.sink.add(playersListAdded);
    } else {}
  }
}

final matchBloc = MatchBloc();
