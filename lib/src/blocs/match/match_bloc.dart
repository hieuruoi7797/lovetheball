import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/src/app.dart';
import 'package:splat_mobile/src/blocs/game_on/game_on_bloc.dart';
import 'package:splat_mobile/src/blocs/home_bloc/home_bloc.dart';
import 'package:splat_mobile/src/models/match_model.dart';
import 'package:splat_mobile/src/models/player_model.dart';
import 'package:splat_mobile/src/resources/repository.dart';
import 'package:splat_mobile/widgets_common/dialogs.dart';


class MatchBloc {
  final _matchCreatorPublish = BehaviorSubject<Response>();
  final _matchNameBehavior = BehaviorSubject<String>();
  final _matchIdBehavior = BehaviorSubject<String>();
  final _addedPlayersBehavior = BehaviorSubject<List<PlayerModel>>();
  final _morePlayersPublish = PublishSubject<List<PlayerModel>>();
  final _listAdding = BehaviorSubject<List<int>>();
  final _userInMatchBehavior = BehaviorSubject<bool>();
  final _listMatches = BehaviorSubject<List<MatchModel>>();
  final _listMatchesPreview = BehaviorSubject<List<MatchModel>>();
  bool _userInMatchCheck = false;
  List<PlayerModel> addingPlayersList = [];
  List<PlayerModel> playersListMore = [];
  List<MatchModel> matchesListAll = [];
  List<int> listAddingIndexes = [-1];
  MatchModel matchRunning = MatchModel();
  String matchRunningId = '';

  Stream<Response> get createMatchRes => _matchCreatorPublish.stream;

  Stream<List<PlayerModel>> get addedPlayersList => _addedPlayersBehavior.stream;

  Stream<List<PlayerModel>> get morePlayersList => _morePlayersPublish.stream;

  Stream<List<int>> get listAdding => _listAdding.stream;

  Stream<String> get matchNameBehavior => _matchNameBehavior.stream;

  Stream<String> get matchIdBehavior => _matchIdBehavior.stream;

  Stream<bool> get userInMatchBehavior => _userInMatchBehavior.stream;

  Stream<List<MatchModel>> get listMatches => _listMatches;

  Stream<List<MatchModel>> get listMatchesPreview => _listMatchesPreview;

  bool get userInMatch => _userInMatchCheck;

  changeStatus(String statusChange) async {}

  getPlayerList(
       BuildContext context,{ bool? isAdding, String? matchId}) async {
    Response response;
    response = await repository.getPlayers(matchId: matchId);
    List<dynamic> listPlayerRes = jsonDecode(response.body)['data'] as List;
    List<PlayerModel> listPlayers = [];
    for(int i = 0 ; i < listPlayerRes.length; i++){

      ///ADD ALL players into players list
      listPlayers.add(PlayerModel.fromJson(listPlayerRes[i]));

      ///CHECK USER IF THEY ARE IN ANY MATCH
      if (homeBloc.nowUserInfo!.id == listPlayerRes[i]['id_']){
        if (listPlayerRes[i]['in_match'] != null){
          matchRunningId = listPlayerRes[i]['in_match'];
          _matchIdBehavior.sink.add(matchRunningId);
          //TO FISISH A MATCH
          // _repository.gameOnApiProvider.finishMatch(matchId: listPlayerRes[i]['in_match']);
          _userInMatchCheck = true;
        }else{
          _userInMatchCheck = false;
        }
      }

    }
    _userInMatchBehavior.sink.add(userInMatch);
    // if (userInMatch == false){
      if (isAdding == true) {
        ///get lasted players in the result list to add on More Players List
        List<PlayerModel> availableList = listPlayers;
        if (availableList.length > 5) {
          _morePlayersPublish.sink.add(availableList.sublist(6,listPlayers.length));
        }else{
          _morePlayersPublish.sink.add([]);
        }
      }
      ///get ALL players of an Match (macthId) in the result list
      else if (matchId != null) {
        addingPlayersList.clear();
        addingPlayersList.addAll(listPlayers);
        _morePlayersPublish.sink.add(addingPlayersList);
      }
      ///get 5 players start of the result list to add on default added players
      else {
        listPlayerRes.removeWhere((element) => (element['in_match'] != null));
        listPlayerRes.removeWhere((element) => (element['id_'] == homeBloc.nowUserInfo!.id));
        if (listPlayers.length > 5){
          _addedPlayersBehavior.sink.add(listPlayers.sublist(0,6));
        }else{
          _addedPlayersBehavior.sink.add(listPlayers);
        }
      }
    // }
  }

  createMatch({
    required BuildContext context,
    required String name,
  }) async {
    List<String> listPlayersString = [];
    if (name.isNotEmpty){
      for (var element in addingPlayersList) {
        listPlayersString.add(element.id);
      }
      Response response = await repository.createMatch(
          context: context,
          name: name,
          location: "DH SU PHAM",
          type: 0,
          players: listPlayersString);
      _matchCreatorPublish.sink.add(response);
      if (response.statusCode == 201) {
        if (context.mounted) {
          String matchId = jsonDecode(response.body)['data'][0]['id_'];
          await getPlayerList(context, matchId: matchId);
          matchRunning = MatchModel.fromJson(jsonDecode(response.body)['data'][0]);
          _addedPlayersBehavior.sink.add(addingPlayersList);
          _matchNameBehavior.sink.add(name);
          _matchIdBehavior.sink.add(matchRunning.id??'');
          await Future.delayed(Duration.zero, () {
            DialogWidget()
                .showResultDialog(context,
                isSuccess: true, content: "Tạo game thành công!")
                .then((value) {
                  gameOnBloc.emitChangesSocket(isFirstEmit: true);
              Navigator.pushNamed(context, '/game_on');
            });
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
    _listMatchesPreview.add([]);
    matchRunning = MatchModel();
    Response matchesListRes = await repository.getMatchesList(context);
    if (matchesListRes.statusCode == 200){
      Map bodyRes = jsonDecode(matchesListRes.body);
      (bodyRes['data'] as List).forEach((element) {
        element['created_at'] = '${DateTime.parse(element['created_at']).day}/${DateTime.parse(element['created_at']).month}/${DateTime.parse(element['created_at']).year}';
        matchesListAll.add(MatchModel.fromJson(element));
        if (element['id_'] == matchRunningId && element['status'] == 0) {
          matchRunning = MatchModel.fromJson(element);
          _matchIdBehavior.add(matchRunning.id??'');
          _matchNameBehavior.add(matchRunning.name??'');
          getPlayerList(context,matchId: matchRunningId);
        }else{
          // m
        }
      });
      _listMatchesPreview.sink.add([
        matchRunning,
        matchesListAll[matchesListAll.length-1]
      ]);
      _listMatches.sink.add(matchesListAll);
    }else{

    }


  }

  dispose() {
  }

  Future<void> showAddingPlayersBottom(BuildContext context) async {
    listAddingIndexes.clear();
    _listAdding.sink.add(listAddingIndexes);
    DialogWidget().showAddingPlayerBottom(context);
    await getPlayerList(context, isAdding: true);
  }

  addPlayersTap(BuildContext context, int index, {bool? changeStatus}) {
    if (changeStatus == true) {
      listAddingIndexes.add(index);
      addingPlayersList.add(playersListMore[index]);
    } else {
      listAddingIndexes.remove(index);
      addingPlayersList.remove(playersListMore[index]);
    }
    _listAdding.sink.add(listAddingIndexes);
    // Navigator.pop(context);
  }

  removePlayerTap(int index, BuildContext context, String nameOfGame) async {
    String result = await DialogWidget().showMessageDialog(context,
        content:
            "Bạn có chắc chắn xoá ${addingPlayersList[index].name} khỏi $nameOfGame?");
    if (result == "Y") {
      addingPlayersList.remove(addingPlayersList[index]);
      _addedPlayersBehavior.sink.add(addingPlayersList);
    } else {}
  }

  void confirmAddPlayer(BuildContext context) {
    _addedPlayersBehavior.sink.add(addingPlayersList);
    Navigator.pop(context);
  }

  goToMatch(MatchModel match) {
    if (match.status == 0) {
      repository.socketConnect('stat');
      Navigator.pushNamed(navigatorKey.currentContext!, '/game_on');
    }else{

    }
  }

  void _checkUserInMatch() {

  }

}

final matchBloc = MatchBloc();
