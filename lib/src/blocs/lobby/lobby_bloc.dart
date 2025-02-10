import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/public/modal/modal_lobby.dart';
import 'package:splat_mobile/src/app.dart';
import 'package:splat_mobile/src/models/player_model.dart';

import '../../../public/dialog/dialog_notification.dart';
import '../../resources/repository.dart';
import '../../resources/show_dialog.dart';

class LobbyBloc {
  BehaviorSubject<List<PlayerModel>> _listPendingPlayers = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<List<PlayerModel>> listTeamPlayersOne = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<List<PlayerModel>> listSubPlayersOne = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<List<PlayerModel>> listTeamPlayersTwo = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<List<PlayerModel>> listSubPlayersTwo = BehaviorSubject<List<PlayerModel>>();
  BehaviorSubject<PlayerModel?> _nowSwappingPlayer = BehaviorSubject<PlayerModel?>();
  final BehaviorSubject<bool?> _pendingListExpanded = BehaviorSubject<bool?>();
  String nowSwappingFromTeam = "";
  String nowSwappingToTeam = "";
  String _lobbyId ='';
  String get lobbyId => _lobbyId;
  String _lobbyName ='';
  String get lobbyName => _lobbyName;
  final lobbyIdBehavior = BehaviorSubject<String>();
  List<LobbyModel> _lobbies = [];
  List<LobbyModel>  get lobbies => _lobbies;
  BehaviorSubject<List<LobbyModel>> listLobbyBehavior = BehaviorSubject<List<LobbyModel>>();

  setListLobby(List<LobbyModel> ls){
    listLobbyBehavior.sink.add(_lobbies=ls);
  }
  setLobbyId(String value){
    lobbyIdBehavior.sink.add(_lobbyId=value);
  }
  setLobbyName(String value){
    _lobbyName = value;
  }
 final List<PlayerModel> _listPendingDumb = [
   PlayerModel(id: '1',name: "Tran Trung Hieu"),
   PlayerModel(id: '4',name: "Viet Hoang Nguyen"),
   PlayerModel(id: '6',name: "Nguyễn Sơn"),
 ];

 List<PlayerModel> get listPendingDumb => _listPendingDumb;


 Stream<PlayerModel?> get getAddingPlayer => _nowSwappingPlayer.stream;
 Stream<List<PlayerModel>> get getListPendingPlayers => _listPendingPlayers.stream;
 Stream<List<PlayerModel>> get getListTeamOnePlayers => listTeamPlayersOne.stream;
 Stream<List<PlayerModel>> get getListSubOnePlayers => listSubPlayersOne.stream;
 Stream<List<PlayerModel>> get getListTeamTwoPlayers => listTeamPlayersTwo.stream;
 Stream<List<PlayerModel>> get getListSubTwoPlayers => listSubPlayersTwo.stream;
 Stream<bool?> get pendingListExpanded => _pendingListExpanded.stream;

 LobbyBloc();

 void initData(){

    _listPendingPlayers = BehaviorSubject<List<PlayerModel>>();
    listTeamPlayersOne = BehaviorSubject<List<PlayerModel>>();
    listSubPlayersOne = BehaviorSubject<List<PlayerModel>>();
    listTeamPlayersTwo = BehaviorSubject<List<PlayerModel>>();
    listSubPlayersTwo = BehaviorSubject<List<PlayerModel>>();
    _nowSwappingPlayer = BehaviorSubject<PlayerModel?>();

   _listPendingPlayers.add([
     PlayerModel(id: '1',name: "Tran Trung Hieu"),
     PlayerModel(id: '4',name: "Viet Hoang Nguyen"),
     PlayerModel(id: '6',name: "Nguyễn Sơn"),
     PlayerModel(id: '7',name: "Nguyễn Hoàng"),
     PlayerModel(id: '8',name: "Phạm Hiếu"),
   ]
   );
   listTeamPlayersOne.add([
     PlayerModel(id: '01', name: "Blaze"),
     PlayerModel(id: '02', name: "Storm"),
     PlayerModel(id: '03', name: "Echo"),
     PlayerModel(id: '04', name: "Shadow"),
     PlayerModel(id: '05', name: "Frost"),
   ]);
   listTeamPlayersTwo.add([
     PlayerModel(id: '06', name: "Hunter"),
     PlayerModel(id: '07', name: "Phoenix"),
     PlayerModel(id: '08', name: "Rogue"),
     PlayerModel(id: '09', name: "Viper"),
     PlayerModel(id: '10', name: "Nova"),
   ]);
   listSubPlayersOne.add([
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
   ]);
   listSubPlayersTwo.add([
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
     PlayerModel(id: '000',name: "unknown"),
   ]);

   _pendingListExpanded.add(false);
 }

 void setListPendingPlayers(List<PlayerModel> listPlayers){
   _listPendingPlayers.add(listPlayers);
 }

 Future<void> changeAddingEnable(PlayerModel? editingPlayer, String nowSwappingTeam,
     {bool? disableExpandedPendingList}) async {
    if (disableExpandedPendingList == true) {
      _pendingListExpanded.value == true ?
      setPendingListExpanded():null;
    }
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
   List<PlayerModel> mainList = addingTeam == Constants.TEAM_A ? listTeamPlayersOne.value : listTeamPlayersTwo.value;
   _nowSwappingPlayer.hasValue ?  mainList[index] = (_nowSwappingPlayer.value!) : null;
   addingTeam == Constants.TEAM_A ?
      listTeamPlayersOne.add(mainList) :
      listTeamPlayersTwo.add(mainList);
   lobbyBloc.changeAddingEnable(null,"");
 }

  dispose() async{
    initData();
   _nowSwappingPlayer.close();
   _listPendingPlayers.close();
   listTeamPlayersOne.close();
   listTeamPlayersTwo.close();
  }

  addToSubPlayersList(int index, {required String subTeamKey}) {
    PlayerModel? nowAddingPlayer = _nowSwappingPlayer.value;
    removePlayerFromOldList(id: nowAddingPlayer?.id ?? "000");
    List<PlayerModel> subList = subTeamKey == Constants.SUB_1 ? listSubPlayersOne.value : listSubPlayersTwo.value;
    _nowSwappingPlayer.hasValue ?  subList[index] = (_nowSwappingPlayer.value!) : null;
    subTeamKey == Constants.SUB_1 ?
    listSubPlayersOne.add(subList) :
    listSubPlayersTwo.add(subList);
    lobbyBloc.changeAddingEnable(null,"");
  }

  void removePlayerFromOldList({required String id}) {
   switch (nowSwappingFromTeam) {
     case Constants.TEAM_A:
       List<PlayerModel> teamOne = listTeamPlayersOne.hasValue ? listTeamPlayersOne.value : [];
       for(int i = 0; i < teamOne.length; i ++){
         if (teamOne[i].id == id){
           teamOne[i] = PlayerModel(id: '000',name: "unknown");
         }
       }
       listTeamPlayersOne.add(teamOne);
     case Constants.TEAM_B:
       List<PlayerModel> teamTwo = listTeamPlayersTwo.hasValue ? listTeamPlayersTwo.value : [];
       for(int i = 0; i < teamTwo.length; i ++){
         if (teamTwo[i].id == id){
           teamTwo[i] = PlayerModel(id: '000',name: "unknown");
         }
       }
       listTeamPlayersTwo.add(teamTwo);

     case Constants.SUB_1:
       List<PlayerModel> subOne = listSubPlayersOne.hasValue ? listSubPlayersOne.value : [];
       for(int i = 0; i < subOne.length; i ++){
         if (subOne[i].id == id){
           subOne[i] = PlayerModel(id: '000',name: "unknown");
         }
       }
       listSubPlayersOne.add(subOne);

     case Constants.SUB_2:
       List<PlayerModel> subTwo = listTeamPlayersTwo.hasValue ? listSubPlayersTwo.value : [];
       for(int i = 0; i < subTwo.length; i ++){
         if (subTwo[i].id == id){
           subTwo[i] = PlayerModel(id: '000',name: "unknown");
         }
       }
       listSubPlayersOne.add(subTwo);

     case Constants.TEAM_PENDING:
       List<PlayerModel> pendingList = _listPendingPlayers.hasValue ? _listPendingPlayers.value : [];
       pendingList.removeWhere((e){
         return (e.id ==  id);
       });
       _listPendingPlayers.add(pendingList);
   }

  }

  movePlayerToPending(PlayerModel nowMovingPlayer, String teamKey) {
    nowSwappingFromTeam = teamKey;
    removePlayerFromOldList(id: nowMovingPlayer.id);
    List<PlayerModel> listPendingNow = _listPendingPlayers.value;
    listPendingNow.add(nowMovingPlayer);
    _listPendingPlayers.add(listPendingNow);
  }

  setPendingListExpanded() {
   bool nowExpandedStatus = _pendingListExpanded.value ?? false;
   _pendingListExpanded.add(!nowExpandedStatus);
  }

  createLobby({
    required BuildContext context,
    required String name,
    required String matchSettingId,
    required String scheduleAt,
  }) async{
    Response response = await repository.createLobby(
        context: context,
        name: name,
        matchSettingId: matchSettingId,
        scheduledAt: scheduleAt
    );
    Map<String, dynamic> result =  jsonDecode(response.body);
    List fixedData = (result['data'] as List).map((item) {
      item['name'] = Utf8Decoder().convert(item['name'].runes.toList());
      return item;
    }).toList();
    // json.decode(utf8.decode
    setLobbyId(fixedData[0]['id_']);
    setLobbyName(fixedData[0]['name']);
    print("Xinhcheck create -----${response.body}----${fixedData[0]['name']}");
  }

  deleteLobby({
    required BuildContext context,
    required String lobbyId,
  }) async{
    Response response = await repository.deleteLobby(context: context, lobbyId: lobbyId);
    print("Xinhcheck delete-----${jsonDecode(response.body)}------");
  }

  showDelLobbiesDialog(BuildContext context,{bool? isHasLobbies,String? id}) {

    if(isHasLobbies==true) {
      show.dialog(dialogWidget: AddDialog.cupertinoDialogOneBtn(
          context: context, content: 'Bạn đang là chủ của lobbies khác, Vui lòng thoát để tiếp tục'));
      deleteLobby(context: context, lobbyId: id??"");
    }else{
      show.dialog(dialogWidget: AddDialog.cupertinoDialogTwoBtn(
          context: context,
          content:'Bạn có chắc muốn rời khỏi lobby này không',
          onPressedCancel: (){
            Navigator.pop(context);
          },
          onPressedOK: ()async{
            await deleteLobby(context: context, lobbyId: lobbyId);
            Navigator.pop(context);
            Navigator.pop(context);
          }));
    }
  }

  getLobby(BuildContext context)async{
    Response response = await repository.getLobby(context: context,
        limit: '100',
        offset: '0',
        sortField: 'updated_at',
        sortOrder: 'DESC',
        fromDate: null,
        toDate: null);
    final result = jsonDecode(response.body);
    final List<LobbyModel> lsLobbies = (result['data'] as List)
        .map((item) => LobbyModel.fromJson(item))
        .toList();
    lobbies.clear();
    setListLobby(lsLobbies);
    print("Xinhcheck get lobby-----${jsonDecode(response.body)}------");
  }




}

final lobbyBloc = LobbyBloc();