import 'dart:developer';

import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/src/models/player_model.dart';

class LobbyBloc {
  BehaviorSubject<List<PlayerModel>> _listPendingPlayers = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<List<PlayerModel>> _listTeamPlayersOne = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<List<PlayerModel>> _listSubPlayersOne = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<List<PlayerModel>> _listTeamPlayersTwo = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<List<PlayerModel>> _listSubPlayersTwo = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<PlayerModel?> _nowSwappingPlayer = BehaviorSubject<PlayerModel?>();
  String nowSwappingFromTeam = "";
  String nowSwappingToTeam = "";
 final List<PlayerModel> _listPendingDumb = [
   PlayerModel(id: '1',name: "Tran Trung Hieu"),
   PlayerModel(id: '4',name: "Viet Hoang Nguyen"),
   PlayerModel(id: '6',name: "Nguyễn Sơn"),
 ];

 List<PlayerModel> get listPendingDumb => _listPendingDumb;


 Stream<PlayerModel?> get getAddingPlayer => _nowSwappingPlayer.stream;
 Stream<List<PlayerModel>> get getListPendingPlayers => _listPendingPlayers.stream;
 Stream<List<PlayerModel>> get getListTeamOnePlayers => _listTeamPlayersOne.stream;
 Stream<List<PlayerModel>> get getListSubOnePlayers => _listSubPlayersOne.stream;
 Stream<List<PlayerModel>> get getListTeamTwoPlayers => _listTeamPlayersTwo.stream;
 Stream<List<PlayerModel>> get getListSubTwoPlayers => _listSubPlayersTwo.stream;

 LobbyBloc();

 void initData(){

    _listPendingPlayers = BehaviorSubject<List<PlayerModel>>();
    _listTeamPlayersOne = BehaviorSubject<List<PlayerModel>>();
    _listSubPlayersOne = BehaviorSubject<List<PlayerModel>>();
    _listTeamPlayersTwo = BehaviorSubject<List<PlayerModel>>();
    _listSubPlayersTwo = BehaviorSubject<List<PlayerModel>>();
    _nowSwappingPlayer = BehaviorSubject<PlayerModel?>();

   _listPendingPlayers.add([
     PlayerModel(id: '1',name: "Tran Trung Hieu"),
     PlayerModel(id: '4',name: "Viet Hoang Nguyen"),
     PlayerModel(id: '6',name: "Nguyễn Sơn"),
     PlayerModel(id: '7',name: "Nguyễn Hoàng"),
     PlayerModel(id: '8',name: "Phạm Hiếu"),
   ]
   );
   _listTeamPlayersOne.add([
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
   ]);
   _listTeamPlayersTwo.add([
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
   ]);
   _listSubPlayersOne.add([
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
   ]);
   _listSubPlayersTwo.add([
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
   ]);
 }

 void setListPendingPlayers(List<PlayerModel> listPlayers){
   _listPendingPlayers.add(listPlayers);
 }

 Future<void> changeAddingEnable(PlayerModel? editingPlayer, String nowSwappingTeam) async {
       if ( (_nowSwappingPlayer.hasValue && editingPlayer?.id == _nowSwappingPlayer.value?.id) ||
            editingPlayer?.id == "000"){
         _nowSwappingPlayer.add(null);
         log("disable");
       }else{
         _nowSwappingPlayer.add(editingPlayer);
        nowSwappingFromTeam = nowSwappingTeam;
        log(_nowSwappingPlayer.value?.name??'');
       }

   // }

 }

  addToMainPlayersList(int index, {required String addingTeam}) {
   PlayerModel? nowAddingPlayer = _nowSwappingPlayer.value;
   ///REMOVE WHERE PLAYER COME FROM
   removePlayerFromOldList(id: nowAddingPlayer?.id ?? "000");
   ///GET THE TEAM WHAT IS ADDING PLAYER
   List<PlayerModel> mainList = addingTeam == Constants.TEAM_1 ? _listTeamPlayersOne.value : _listTeamPlayersTwo.value;
   _nowSwappingPlayer.hasValue ?  mainList[index] = (_nowSwappingPlayer.value!) : null;
   addingTeam == Constants.TEAM_1 ?
      _listTeamPlayersOne.add(mainList) :
      _listTeamPlayersTwo.add(mainList);
   lobbyBloc.changeAddingEnable(null,"");
 }

  dispose() async{
    initData();
   _nowSwappingPlayer.close();
   _listPendingPlayers.close();
   _listTeamPlayersOne.close();
   _listTeamPlayersTwo.close();
  }

  addToSubPlayersList(int index, {required String subTeamKey}) {
    PlayerModel? nowAddingPlayer = _nowSwappingPlayer.value;
    removePlayerFromOldList(id: nowAddingPlayer?.id ?? "000");
    List<PlayerModel> subList = subTeamKey == Constants.SUB_1 ? _listSubPlayersOne.value : _listSubPlayersTwo.value;
    _nowSwappingPlayer.hasValue ?  subList[index] = (_nowSwappingPlayer.value!) : null;
    subTeamKey == Constants.SUB_1 ?
    _listSubPlayersOne.add(subList) :
    _listSubPlayersTwo.add(subList);
    lobbyBloc.changeAddingEnable(null,"");

  }

  void removePlayerFromOldList({required String id}) {
   switch (nowSwappingFromTeam) {
     case Constants.TEAM_1:
       List<PlayerModel> teamOne = _listTeamPlayersOne.hasValue ? _listTeamPlayersOne.value : [];
       for(int i = 0; i < teamOne.length; i ++){
         if (teamOne[i].id == id){
           teamOne[i] = PlayerModel(id: '000',name: "unknown");
         }
       }
       _listTeamPlayersOne.add(teamOne);
     case Constants.TEAM_2:
       List<PlayerModel> teamTwo = _listTeamPlayersTwo.hasValue ? _listTeamPlayersTwo.value : [];
       for(int i = 0; i < teamTwo.length; i ++){
         if (teamTwo[i].id == id){
           teamTwo[i] = PlayerModel(id: '000',name: "unknown");
         }
       }
       _listTeamPlayersTwo.add(teamTwo);

     case Constants.SUB_1:
       List<PlayerModel> subOne = _listSubPlayersOne.hasValue ? _listSubPlayersOne.value : [];
       for(int i = 0; i < subOne.length; i ++){
         if (subOne[i].id == id){
           subOne[i] = PlayerModel(id: '000',name: "unknown");
         }
       }
       _listSubPlayersOne.add(subOne);

     case Constants.SUB_2:
       List<PlayerModel> subTwo = _listTeamPlayersTwo.hasValue ? _listSubPlayersTwo.value : [];
       for(int i = 0; i < subTwo.length; i ++){
         if (subTwo[i].id == id){
           subTwo[i] = PlayerModel(id: '000',name: "unknown");
         }
       }
       _listSubPlayersOne.add(subTwo);

     case Constants.TEAM_PENDING:
       List<PlayerModel> pendingList = _listPendingPlayers.hasValue ? _listPendingPlayers.value : [];
       pendingList.removeWhere((e){
         return (e.id ==  id);
       });
       _listPendingPlayers.add(pendingList);
   }

  }
}

final lobbyBloc = LobbyBloc();