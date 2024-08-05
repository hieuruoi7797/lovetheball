import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/src/app.dart';

import '../../ui/quick_match/quick_match_screen.dart';

class QuickMatchBloc{
  bool _checkRememberAction = false;
  int _numberCountSelect =0;
  int _totalListData =0;
  int _indexTab =0;
  Map<String, dynamic> modelFriend = {
    "responseCode": "1",
    "responseText": "List friend.",
    "responseBody": [
      {"user_id": "5", "user_name": "Xinh Ngô"},
      {"user_id": "3", "user_name": "Nguyễn Thị Vân Anh"},
      {"user_id": "7", "user_name": "Minh An"},
      {"user_id": "9", "user_name": "Hoàng Anh"},
      {"user_id": "10", "user_name": "Phạm Hiếu"},
      {"user_id": "11", "user_name": "Hiếu Trần"},
      {"user_id": "12", "user_name": "Phạm Trang"},
      {"user_id": "15", "user_name": "Daniel Kang"}
    ],
    "responseTotalResult":  8// Total result is 3 here becasue we have 3 categories in responseBody.
  };
  Map<String, dynamic> modelTeams = {
    "responseCode": "1",
    "responseText": "List teams.",
    "responseBody": [
      {"teams_id": "1", "teams_name": "MMM"},
      {"teams_id": "2", "teams_name": "SuperHero"},
      {"teams_id": "3", "teams_name": "I AM KING"},
      {"teams_id": "4", "teams_name": "I AM QUEEN"},
      {"teams_id": "5", "teams_name": "ssss"}
    ],
    "responseTotalResult": 5 // Total result is 3 here becasue we have 3 categories in responseBody.
  };
  List _lsFriends = [];
  List _lsTeams =[];

  void onFriendsSelected(bool selected, user_id) {
    if (selected == true) {
      _lsFriends.add(user_id);
      _lsAddFriendsBehavior.sink.add(_lsFriends);
    } else {
      _lsFriends.remove(user_id);
      _lsAddFriendsBehavior.sink.add(_lsFriends);
    }
  }
  void onTeamsSelected(bool selected, teams_id) {
    if (selected == true) {
      _lsTeams.add(teams_id);
      _addTeamsBehavior.sink.add(_lsTeams);
    } else {
      _lsTeams.remove(teams_id);
      _addTeamsBehavior.sink.add(_lsTeams);
    }
  }


  final _checkRememberActionBehavior = BehaviorSubject<bool>();
  Stream<bool> get checkRememberActionBehavior => _checkRememberActionBehavior.stream;
  bool get checkRememberAction => _checkRememberAction;
  final _lsAddFriendsBehavior = BehaviorSubject<List>();
  Stream<List> get lsAddFriendsBehavior => _lsAddFriendsBehavior.stream;
  List get lsFriends => _lsFriends;
  final _addTeamsBehavior = BehaviorSubject<List>();
  Stream<List> get addTeamsBehavior => _addTeamsBehavior.stream;
  List get lsTeams => _lsTeams;
  void setCheckRememberAction(bool? value)=> _checkRememberActionBehavior.sink.add(_checkRememberAction=value!);
  int get numberSelect => _numberCountSelect;
  final _countSelectBehavior = BehaviorSubject<int>();
  Stream<int> get countSelectBehavior => _countSelectBehavior.stream;
  int get totalListData => _totalListData;
  final _totalListDataBehavior = BehaviorSubject<int>();
  Stream<int> get totalListDataBehavior => _totalListDataBehavior.stream;
  int get indexTab => _indexTab;
  final _indexTabBehavior = BehaviorSubject<int>();
  Stream<int> get indexTabBehavior => _indexTabBehavior.stream;
  void checkTab(int? index){
    _indexTabBehavior.sink.add(_indexTab=index!);
    if(_indexTab==0){
      quickMatchBloc.setNumberCount(quickMatchBloc.lsTeams.length);
      quickMatchBloc.setTotal(quickMatchBloc.modelTeams["responseTotalResult"]);
    }else{
      quickMatchBloc.setNumberCount(quickMatchBloc.lsTeams.length);
      quickMatchBloc.setTotal(quickMatchBloc.modelTeams["responseTotalResult"]);
    }
  }
  void setNumberCount(int? value){
      if(_indexTab==0){
        _countSelectBehavior.sink.add(_numberCountSelect=_lsFriends.length!);
      }else{
        _countSelectBehavior.sink.add(_numberCountSelect=_lsTeams.length!);
      }

  }
  void setTotal(int? total){
    if(_indexTab==0){
      _totalListDataBehavior.sink.add(_totalListData = modelFriend['responseTotalResult']);
    }else{
      _totalListDataBehavior.sink.add(_totalListData = modelTeams['responseTotalResult']);
    }
  }

}
final  quickMatchBloc= QuickMatchBloc();