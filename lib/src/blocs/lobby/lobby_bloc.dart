import 'dart:developer';

import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/src/models/player_model.dart';

class LobbyBloc {
 final _listPendingPlayers = BehaviorSubject<List<PlayerModel>>();
 final _listTeamOnePlayers = BehaviorSubject<List<PlayerModel>>();
 final _listSubOnePlayers = BehaviorSubject<List<PlayerModel>>();
 final _listTeamTwoPlayers = BehaviorSubject<List<PlayerModel>>();
 final _listSubTwoPlayers = BehaviorSubject<List<PlayerModel>>();
 final _nowAddingPlayer = BehaviorSubject<PlayerModel?>();

 List<PlayerModel> listPendingNow = [
   PlayerModel(id: '12',name: "Tran Trung Hieu"),
   PlayerModel(id: '12',name: "Tran Trung Hieu"),
   PlayerModel(id: '12',name: "Tran Trung Hieu"),
   PlayerModel(id: '12',name: "Viet Hoang Nguyen"),
   PlayerModel(id: '12',name: "Tran Trung Hieu"),
   PlayerModel(id: '12',name: "Nguyễn Sơn"),
   PlayerModel(id: '12',name: "Nguyễn Sơn"),
   PlayerModel(id: '12',name: "Pham Trung Hieu"),
   PlayerModel(id: '12',name: "Nguyễn Sơn"),
   PlayerModel(id: '12',name: "Nguyễn Sơn"),
   PlayerModel(id: '12',name: "Tran Trung Hieu"),
   PlayerModel(id: '12',name: "Nguyễn Sơn"),
 ];

 Stream<PlayerModel?> get getAddingPlayer => _nowAddingPlayer.stream;
 Stream<List<PlayerModel>> get getListPendingPlayers => _listPendingPlayers.stream;
 Stream<List<PlayerModel>> get getListTeamOnePlayers => _listTeamOnePlayers.stream;
 Stream<List<PlayerModel>> get getListSubOnePlayers => _listSubOnePlayers.stream;
 Stream<List<PlayerModel>> get getListTeamTwoPlayers => _listTeamTwoPlayers.stream;
 Stream<List<PlayerModel>> get getListSubTwoPlayers => _listSubTwoPlayers.stream;

 LobbyBloc(){
   setListPendingPlayers(listPendingNow);
   _listTeamOnePlayers.add(listPendingNow.sublist(0,3));
   _listTeamTwoPlayers.add(listPendingNow.sublist(4,7));
 }

 void setListPendingPlayers(List<PlayerModel> listPlayers){
   _listPendingPlayers.add(listPlayers);
 }

 Future<void> changeAddingEnable({int? index}) async {
   // if (set != null){
   //   _addingEnable.add(set);
   // }else{
   //   bool addingNow =  _addingEnable.value;
   //   _addingEnable.add(!addingNow);
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
}

final lobbyBloc = LobbyBloc();