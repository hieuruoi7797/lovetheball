import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_record/constants/public_values.dart';
import 'package:splat_record/public/public_methods.dart';
import 'package:splat_record/src/app.dart';
import 'package:splat_record/src/blocs/match/match_bloc.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/widgets_common/dialogs.dart';

class HomeBloc {
  int _pageIndexInt = 1;
  PlayerModel? nowUserInfo;


  final _pageIndexBehavior = BehaviorSubject<int>();
  final _userInfoBehavior = BehaviorSubject<PlayerModel>();


  Stream<int> get pageIndex => _pageIndexBehavior.stream;
  Stream<PlayerModel> get userInfo => _userInfoBehavior.stream;


  HomeBloc() {
    _pageIndexBehavior.sink.add(_pageIndexInt);
  }

  void onTabPageIndex(int index){
    _pageIndexInt = index;
    _pageIndexBehavior.sink.add(_pageIndexInt);
    if (index == 2){
      matchBloc.getMatchesList(navigatorKey.currentContext!);
    }else if (index == 1){
      matchBloc.getPlayerList(navigatorKey.currentContext!);
    }
  }

  Future<void> getUserSaved(BuildContext context) async {
    PlayerModel userSaved = publicValues.userNow;
      nowUserInfo = userSaved;
      _userInfoBehavior.sink.add(userSaved);
      return;

  }

}

final homeBloc = HomeBloc();