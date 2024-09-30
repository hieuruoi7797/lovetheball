import 'dart:developer';

import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/src/models/player_model.dart';

class LobbyBloc {
  BehaviorSubject<List<PlayerModel>> _listPendingPlayers = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<List<PlayerModel>> _listTeamPlayersOne = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<List<PlayerModel>> _listSubPlayersOne = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<List<PlayerModel>> _listTeamPlayersTwo = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<List<PlayerModel>> _listSubPlayersTwo = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<PlayerModel?> _nowAddingPlayer = BehaviorSubject<PlayerModel?>();

 final List<PlayerModel> _listPendingDumb = [
   PlayerModel(id: '1',name: "Tran Trung Hieu"),
   PlayerModel(id: '4',name: "Viet Hoang Nguyen"),
   PlayerModel(id: '6',name: "Nguyễn Sơn"),
 ];

 List<PlayerModel> get listPendingDumb => _listPendingDumb;


 Stream<PlayerModel?> get getAddingPlayer => _nowAddingPlayer.stream;
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
    _nowAddingPlayer = BehaviorSubject<PlayerModel?>();

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

 Future<void> changeAddingEnable({int? index}) async {
     if (index != null){
       if (_listPendingPlayers.value[index].id == _nowAddingPlayer.value?.id ){
         _nowAddingPlayer.add(null);
         log("disable");
       }else{
         _nowAddingPlayer.add(_listPendingPlayers.value[index]);
         log(_nowAddingPlayer.value?.name??'');
       }

     }else{
       _nowAddingPlayer.add(null);
     }
   // }

 }

  addToMainPlayersList(int index, {required String teamKey}) async {
   PlayerModel? nowAddingPlayer = _nowAddingPlayer.value;
   List<PlayerModel> mainList = teamKey == "TEAM_1" ? _listTeamPlayersOne.value : _listTeamPlayersTwo.value;
   List<PlayerModel> pendingList = _listPendingPlayers.hasValue ? _listPendingPlayers.value : [];
   pendingList.removeWhere((e){
     return (e.id ==  nowAddingPlayer?.id);
   });
   _nowAddingPlayer.hasValue ?  mainList[index] = (_nowAddingPlayer.value!) : null;
   teamKey == "TEAM_1" ?
      _listTeamPlayersOne.add(mainList) :
      _listTeamPlayersTwo.add(mainList);
   _listPendingPlayers.add(pendingList);
  }

  dispose() async{
    initData();
   _nowAddingPlayer.close();
   _listPendingPlayers.close();
   _listTeamPlayersOne.close();
   _listTeamPlayersTwo.close();
  }

  addToSubPlayersList(int index, {required String subTeamKey}) {
    PlayerModel? nowAddingPlayer = _nowAddingPlayer.value;
    List<PlayerModel> subList = subTeamKey == "SUB_1" ? _listSubPlayersOne.value : _listSubPlayersTwo.value;
    List<PlayerModel> pendingList = _listPendingPlayers.hasValue ? _listPendingPlayers.value : [];
    pendingList.removeWhere((e){
      return (e.id ==  nowAddingPlayer?.id);
    });
    _nowAddingPlayer.hasValue ?  subList[index] = (_nowAddingPlayer.value!) : null;
    subTeamKey == "SUB_1" ?
    _listSubPlayersOne.add(subList) :
    _listSubPlayersTwo.add(subList);
    _listPendingPlayers.add(pendingList);

  }
}

final lobbyBloc = LobbyBloc();