import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/constants/public_values.dart';
import 'package:splat_mobile/public/app_global.dart';
import 'package:splat_mobile/public/dialog/dialog_notification.dart';
import 'package:splat_mobile/public/public_methods.dart';
import 'package:splat_mobile/src/app.dart';
import 'package:splat_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:splat_mobile/src/blocs/match/match_bloc.dart';
import 'package:splat_mobile/src/models/player_model.dart';
import 'package:splat_mobile/src/resources/show_dialog.dart';

class HomeBloc {

  int _pageIndexInt = 1;
  bool showAddingPopup = false;
  bool canPop = false;
  PlayerModel? nowUserInfo;
  Offset? fabOffset;
  Offset? scaffoldOffset;


  final _pageIndexBehavior = BehaviorSubject<int>();
  final _userInfoBehavior = BehaviorSubject<PlayerModel>();
  final _openedAddingPopup = BehaviorSubject<bool>();
  final _popScopeBehavior = BehaviorSubject<bool>();



  Stream<int> get pageIndex => _pageIndexBehavior.stream;
  Stream<bool> get openedAddingPopup => _openedAddingPopup.stream;
  Stream<PlayerModel> get userInfo => _userInfoBehavior.stream;
  Stream<bool> get popScopeBehavior => _popScopeBehavior.stream;


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
    // appGlobal.setAvatarFile(nowUserInfo?.avatar.toString()??"");
    appGlobal.createFileFromString(nowUserInfo);
  }

  openAddingPopup({required GlobalKey renderKey}) {
    RenderBox? renderBox = renderKey.currentContext?.findRenderObject() as RenderBox;
    fabOffset = renderBox.localToGlobal(Offset.zero);
    showAddingPopup = !showAddingPopup;
    _openedAddingPopup.add(showAddingPopup);
  }

  showBackDialog(BuildContext context) {
    show.dialog(dialogWidget: AddDialog.cupertinoDialogTwoBtn(
        context: context,
        content: 'Are you sure you want to leave this page?',
        onPressedCancel: (){
          Navigator.pop(context);
          canPop= false;
          _popScopeBehavior.add(canPop);
        },
        onPressedOK: (){
          authenticationBloc.logout();
          canPop= true;
          _popScopeBehavior.add(canPop);
        }));
  }

}

final homeBloc = HomeBloc();