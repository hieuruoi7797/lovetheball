import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:splat_record/src/models/match_model.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_record/widgets_common/dialogs.dart';

import '../../../public/public_methods.dart';

class MatchBloc {
  final _repository = Repository();
  final _matchCreatorPublish = BehaviorSubject<Response>();
  final _userInfoPublish = BehaviorSubject<PlayerModel>();
  final _matchNameBehavior = BehaviorSubject<String>();
  final _matchIdBehavior = BehaviorSubject<String>();
  final _addedPlayersBehavior = BehaviorSubject<List<PlayerModel>>();
  final _morePlayersPublish = PublishSubject<List<PlayerModel>>();
  final _listAdding = BehaviorSubject<List<int>>();
  final _userInMatchBehavior = BehaviorSubject<bool>();
  final _listMatches = BehaviorSubject<List<MatchModel>>();
  final _listMatchesPreview = BehaviorSubject<List<MatchModel>>();
  bool _userInMatch = false;
  PlayerModel? playerInfo;
  List<PlayerModel> playersListAdded = [];
  List<PlayerModel> playersListMore = [];
  List<MatchModel> matchesListAll = [];
  List<int> listAddingIndexes = [-1];
  MatchModel matchRunning = MatchModel();


  Stream<Response> get createMatchRes => _matchCreatorPublish.stream;

  Stream<PlayerModel> get userName => _userInfoPublish.stream;

  Stream<List<PlayerModel>> get addedPlayersList => _addedPlayersBehavior.stream;

  Stream<List<PlayerModel>> get morePlayersList => _morePlayersPublish.stream;

  Stream<List<int>> get listAdding => _listAdding.stream;

  Stream<String> get matchNameBehavior => _matchNameBehavior.stream;

  Stream<String> get matchIdBehavior => _matchIdBehavior.stream;

  Stream<bool> get userInMatchBehavior => _userInMatchBehavior.stream;

  Stream<List<MatchModel>> get listMatches => _listMatches;

  Stream<List<MatchModel>> get listMatchesPreview => _listMatchesPreview;

  bool get userInMatch => _userInMatch;

  changeStatus(String statusChange) async {}

  getPlayerList(
      {required BuildContext context, bool? isAdding, String? matchId}) async {
    Response response;
    response = await _repository.getPlayers(matchId: matchId);
    List<dynamic> listPlayerRes = jsonDecode(response.body)['data'] as List;
    List<PlayerModel> listPlayers = [];
    ///CHECK USER IF THEY ARE IN ANY MATCH
    for(int i = 0 ; i < listPlayerRes.length; i++){
      if (playerInfo!.id == listPlayerRes[i]['id_']){
        if (listPlayerRes[i]['in_match'] != null){
          //TO FISISH A MATCH
          // _repository.gameOnApiProvider.finishMatch(matchId: listPlayerRes[i]['in_match']);
          _userInMatch = true;
        }else{
          _userInMatch = false;
        }
      }
    }
    if (userInMatch == false){
      if (isAdding == true) {

        ///get 5 players in the last of the result list to add on More Players List
        for (int i = 5; i < 15; i++) {
          listPlayers.add(PlayerModel.fromJson(listPlayerRes[i]));
        }
        _morePlayersPublish.sink.add(listPlayers);
      }
      ///get ALL players of an Match (macthId) in the result list
      else if (matchId != null) {
        playersListAdded.clear();
        for (int i = 0; i < listPlayerRes.length; i++) {
          listPlayers.add(PlayerModel.fromJson(listPlayerRes[i]));
        }
        playersListAdded.addAll(listPlayers);
      }
      ///get 5 players start of the result list to add on default added players
      else {
        listPlayerRes.removeWhere((element) => (element['in_match'] != null));
        listPlayerRes.removeWhere((element) => (element['id_'] == playerInfo!.id));
        for (int i = 0; i < 5; i++) {
          listPlayers.add(PlayerModel.fromJson(listPlayerRes[i]));
        }
        if (playerInfo != null && !listPlayers.contains(playerInfo)){
          listPlayers.add(playerInfo!);
        }
        _addedPlayersBehavior.sink.add(listPlayers);
      }
    }
    _userInMatchBehavior.sink.add(userInMatch);
  }

  createMatch({
    required BuildContext context,
    required String name,
  }) async {
    List<String> listPlayersString = [];
    if (name.isNotEmpty){
      for (var element in playersListAdded) {
        listPlayersString.add(element.id);
      }
      Response response = await _repository.createMatch(
          context: context,
          name: name,
          location: "DH SU PHAM",
          type: 0,
          players: listPlayersString);
      _matchCreatorPublish.sink.add(response);
      if (response.statusCode == 201) {
        if (context.mounted) {
          String matchId = jsonDecode(response.body)['data'][0]['id_'];
          await getPlayerList(context: context, matchId: matchId);
          _addedPlayersBehavior.sink.add(playersListAdded);
          _matchNameBehavior.sink.add(name);
          _matchIdBehavior.sink.add(matchId);
          await Future.delayed(Duration.zero, () {
            DialogWidget()
                .showResultDialog(context,
                isSuccess: true, content: "Tạo game thành công!")
                .then((value) => Navigator.pushNamed(context, '/game_on'));
          });
        }
      }
      _matchCreatorPublish.sink.add(response);
    }else{
      DialogWidget().showMessageDialog(context, content: "Vui lòng nhập tên trận đấu");
    }

  }

  getMatchesList(BuildContext context) async {
    matchesListAll = [];
    // _listMatchesPreview.sink.add(null);
    Response matchesListRes = await _repository.getMatchesList(context);
    if (matchesListRes.statusCode == 200){
      Map bodyRes = jsonDecode(matchesListRes.body);
      (bodyRes['data'] as List).forEach((element) {
        element['created_at'] = '${DateTime.parse(element['created_at']).day}/${DateTime.parse(element['created_at']).month}/${DateTime.parse(element['created_at']).year}';
        matchesListAll.add(MatchModel.fromJson(element));
        if (element['status'] != 0) {
          print("FOUND: ");
          matchRunning = MatchModel.fromJson(element);
        }
      });

    }else{

    }
    _listMatchesPreview.sink.add([
      matchRunning,
      matchesListAll[matchesListAll.length-1]
    ]);
    _listMatches.sink.add(matchesListAll);

  }

  Future<void> getPlayerSaved(BuildContext context) async {
    PlayerModel? playerSaved;
    dynamic savedPlayerFile = await PublicMethod().readContentPlayer();
    if (savedPlayerFile is PlayerModel) {
      playerSaved = savedPlayerFile;
      playerInfo = playerSaved;
      _userInfoPublish.sink.add(playerInfo ?? playerSaved);
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
    } else {
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

final matchBloc = MatchBloc();
