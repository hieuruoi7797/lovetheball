import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/public/widget_item/overlay_entry_sample.dart';
import 'package:splat_mobile/src/app.dart';
import 'package:splat_mobile/src/models/basketball_match_setting_model.dart';
import 'package:splat_mobile/src/resources/match_api_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MatchSettingBloc {
  OverlayEntry? overlayEntry;
  bool matchTypeVisible = false;
  List<String> matchTypesList = [
    "3v3",
    "4v4",
    "5v5",
  ];
  bool _checkRememberPass = false;


  final _choosingMatchTypeIndex = BehaviorSubject<int>();
  final _checkRememberBehavior = BehaviorSubject<bool>();
  final _pickingMatchTitle = BehaviorSubject<String>();

  final _settingMatch = BehaviorSubject<BasketballMatchSettingModel>();



  Stream<int> get choosingMatchTypeIndex => _choosingMatchTypeIndex.stream;
  Stream<bool> get checkRememberBehavior => _checkRememberBehavior.stream;
  Stream<String> get pickingMatchTitle => _pickingMatchTitle.stream;


  Stream<BasketballMatchSettingModel> get settingMatch => _settingMatch.stream;

  bool get checkRememberPass => _checkRememberPass;


  MatchApiProvider matchApiProvider = MatchApiProvider();


  void showOverlayEntry(BuildContext context,GlobalKey entryKey) {
    RenderBox renderBox = entryKey.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    if (matchTypeVisible == false){
      overlayEntry = OverlayEntry(
          builder: (context) => OverlayEntryBuilder(
            offset: offset,
            size: size,
            showingList: matchTypesList,
            onPickAnItem: (index) => pickATypeOfMatch(index),)
      );
      Overlay.of(context).insert(overlayEntry!);
      matchTypeVisible = true;
    }else{
      matchTypeVisible = false;
      overlayEntry?.remove();
    }
  }

  pickATypeOfMatch(int index) {
    _choosingMatchTypeIndex.add(index);
    matchTypeVisible = false;
    overlayEntry?.remove();
  }

  changeNumberOfQuarter({required int num}){
    BasketballMatchSettingModel nowSetting = _settingMatch.value;
    nowSetting.numbersOfRound = num;
    _settingMatch.add(nowSetting);
  }

  Future<void> changeMinutesPerQuarter({required String symbol}) async {
    BasketballMatchSettingModel nowSetting = _settingMatch.value;
    switch (symbol){
      case "-":{
        if ( (nowSetting.timeOfEachRound??0) > 0){
          nowSetting.timeOfEachRound = (nowSetting.timeOfEachRound ?? 1) - 1;
        }
      }
      case "+":{
        nowSetting.timeOfEachRound = (nowSetting.timeOfEachRound ?? 0) + 1;
      }
    }
    _settingMatch.add(nowSetting);
  }

  void setDefaultValue() {
    _choosingMatchTypeIndex.add(0);

    _pickingMatchTitle.add("");

    _settingMatch.add(BasketballMatchSettingModel(
      format: 2,
      numbersOfRound: 1,
      timeOfEachRound: 3,
      timeOfSubRound: 3,
      cutOffPoints: 3,
      enableFreeThrow: true,
    ));
  }

  pickAMatchTitle(BuildContext context,{required String title}){
    final localizations = AppLocalizations.of(context);
    BasketballMatchSettingModel nowSetting = _settingMatch.value;
    if (overlayEntry?.mounted == true) {
      matchTypeVisible = false;
      overlayEntry?.remove();
    };
    if (title == localizations!.standard_3){
      nowSetting.format = 2;
    }else if (title == localizations.standard_5){
      nowSetting.format = 1;
    }else if (title == localizations.custom_match){
      nowSetting.format = 0;
    }
    _settingMatch.add(nowSetting);
    _pickingMatchTitle.add(title);
  }

  Future<void> getMatchSetting() async {
    await matchApiProvider.getMatchSetting(context: navigatorKey.currentContext!);
  }

  void changeNumberOfOT({required String symbol}) {
    BasketballMatchSettingModel nowSetting = _settingMatch.value;

    switch (symbol){
      case "-":{
        if ((nowSetting.timeOfSubRound??0) > 0){
          nowSetting.timeOfSubRound = (nowSetting.timeOfSubRound ?? 1) - 1;
        }
      }
      case "+":{
        nowSetting.timeOfSubRound = (nowSetting.timeOfSubRound ?? 0) + 1;
      }
    }
    _settingMatch.add(nowSetting);
  }

  void setCheckRemember(bool? value) =>
      _checkRememberBehavior.sink.add(_checkRememberPass=value!);

  void changePointsToWin({required String symbol}) {
    BasketballMatchSettingModel nowSetting = _settingMatch.value;

    switch (symbol){
      case "-":{
        if ((nowSetting.cutOffPoints??0) > 0){
          nowSetting.cutOffPoints = (nowSetting.cutOffPoints ?? 1) - 1;
        }
      }
      case "+":{
        nowSetting.cutOffPoints = (nowSetting.cutOffPoints ?? 1) + 1;
      }
    }
    _settingMatch.add(nowSetting);
  }

  void changeEnableFreeThrow(bool bool) {
    BasketballMatchSettingModel nowSetting = _settingMatch.value;
    nowSetting.enableFreeThrow = bool;
    _settingMatch.add(nowSetting);
  }


  Future<void> sendMatch() async {
    BasketballMatchSettingModel nowSetting = _settingMatch.value;
    if (_pickingMatchTitle.value.isNotEmpty){
      Map body = {
        "name": _pickingMatchTitle.value,
        "match_type": 0,
        "type_": 1,
        "settings": nowSetting.toJson()
      };
      Response apiRes = await MatchApiProvider().postMatchSetting(body: body);
      if (apiRes.statusCode == 201){
        if (navigatorKey.currentState!.context.mounted){
          Navigator.pushNamed(navigatorKey.currentState!.context, Routes.LOBBY);
        }
      }
    }else{
      return;
    }

  }

}

MatchSettingBloc matchSettingBloc = MatchSettingBloc();