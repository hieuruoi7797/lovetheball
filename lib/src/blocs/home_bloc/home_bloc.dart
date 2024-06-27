import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/constants/public_values.dart';
import 'package:splat_mobile/public/public_methods.dart';
import 'package:splat_mobile/src/app.dart';
import 'package:splat_mobile/src/blocs/match/match_bloc.dart';
import 'package:splat_mobile/src/models/player_model.dart';

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
      // matchBloc.getPlayerList(navigatorKey.currentContext!);
    }
  }

  void getUserSaved(BuildContext context) async {
    nowUserInfo = await PublicMethods.getNowUser();
  }

}

final homeBloc = HomeBloc();