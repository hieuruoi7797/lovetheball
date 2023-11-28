import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_record/widgets_common/dialogs.dart';

import '../../../public/public_methods.dart';

class MatchCreatingBloc {
  final _repository = Repository();
  final _matchCreatorPublish = BehaviorSubject<Response>();
  final _userNamePublish = PublishSubject<String>();
  final _matchNameBehavior = BehaviorSubject<String>();
  final _addedPlayersBehavior = BehaviorSubject<List<PlayerModel>>();
  final _morePlayersPublish = PublishSubject<List<PlayerModel>>();
  final _listAdding = BehaviorSubject<List<int>>();
  List<PlayerModel> playersListAdded = [];
  List<PlayerModel> playersListMore = [];
  List<int> listAddingIndexes = [-1];

  Stream<Response> get createMatchRes => _matchCreatorPublish.stream;


  Stream<String> get userName => _userNamePublish.stream;

  Stream<List<PlayerModel>> get addedPlayersList => _addedPlayersBehavior.stream;

  Stream<List<PlayerModel>> get morePlayersList => _morePlayersPublish.stream;

  Stream<List<int>> get listAdding => _listAdding.stream;

  Stream<String> get matchNameBehavior => _matchNameBehavior.stream;

  changeStatus(String statusChange) async {
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
        _morePlayersPublish.sink.add(listPlayers);
      }
      return;
    } else {
      for (int i = 0; i < 5; i++) {
        listPlayers.add(PlayerModel.fromJson(listPlayerRes[i]));
        _addedPlayersBehavior.sink.add(listPlayers);
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
    _matchCreatorPublish.sink.add(response);
    if (response.statusCode == 201) {
      if (context.mounted) {
        _addedPlayersBehavior.sink.add(playersListAdded);
        _matchNameBehavior.sink.add(name);
        await DialogWidget().showResultDialog(context,
            isSuccess: true, content: "Tạo game thành công!").then((value) =>
            Navigator.pushNamed(context, '/game_on')
        );
      }
    }
    _matchCreatorPublish.sink.add(response);
  }

  Future<void> getPlayerSavedName(BuildContext context) async {
    PlayerModel? playerSaved;
    dynamic savedPlayerFile = await PublicMethod().readContentPlayer();
    if (savedPlayerFile is PlayerModel) {
      playerSaved = savedPlayerFile;
      _userNamePublish.sink.add(playerSaved.name);
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
  }

  Future<void> showAddingPlayersBottom(BuildContext context) async {
    listAddingIndexes.clear();
    _listAdding.sink.add(listAddingIndexes);
    DialogWidget().showAddingPlayerBottom(context);
    await getPlayerList(context: context, isAdding: true);
    }

  addPlayersTap(BuildContext context, int index, {bool? changeStatus}) {
    if (changeStatus == true) {
      listAddingIndexes.add(index);
      playersListAdded.add(playersListMore[index]);
    } else{
      listAddingIndexes.remove(index);
      playersListAdded.remove(playersListMore[index]);
    }
    _listAdding.sink.add(listAddingIndexes);
    // Navigator.pop(context);
  }

  removePlayerTap(int index, BuildContext context, String nameOfGame) async {
    String result = await DialogWidget().showMessageDialog(context,
        content:
            "Bạn có chắc chắn xoá ${playersListAdded[index].name} khỏi $nameOfGame?");
    if (result == "Y") {
      playersListAdded.remove(playersListAdded[index]);
      _addedPlayersBehavior.sink.add(playersListAdded);
    } else {}
  }

  void confirmAddPlayer(BuildContext context) {
    _addedPlayersBehavior.sink.add(playersListAdded);
    Navigator.pop(context);
  }
}

final matchBloc = MatchCreatingBloc();
