import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/public/widget_item/overlay_entry_sample.dart';
import 'package:splat_mobile/src/app.dart';
import 'package:splat_mobile/src/resources/match_api_provider.dart';

class MatchSettingBloc {
  OverlayEntry? overlayEntry;
  bool matchTypeVisible = false;
  List<String> matchTypesList = [
    "2v2",
    "3v3",
    "4v4",
    "5v5",
  ];
  bool _checkRememberPass = false;


  final _choosingMatchTypeIndex = BehaviorSubject<int>();
  final _numberOfQuarter = BehaviorSubject<int>();
  final _minutesPerQuarter = BehaviorSubject<int>();
  final _numberOfOT = BehaviorSubject<int>();
  final _pickingMatchTitle = BehaviorSubject<String>();
  final _checkRememberBehavior = BehaviorSubject<bool>();


  Stream<int> get choosingMatchTypeIndex => _choosingMatchTypeIndex.stream;
  Stream<int> get numberOfQuarter => _numberOfQuarter.stream;
  Stream<int> get minutesPerQuarter => _minutesPerQuarter.stream;
  Stream<int> get numberOfOT => _numberOfOT.stream;
  Stream<String> get pickingMatchTitle => _pickingMatchTitle.stream;
  Stream<bool> get checkRememberBehavior => _checkRememberBehavior.stream;

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
    _numberOfQuarter.add(num);
  }

  Future<void> changeMinutesPerQuarter({required String symbol}) async {
    switch (symbol){
      case "-":{
        if (_minutesPerQuarter.value > 0){
          int nowValue = _minutesPerQuarter.value - 1;
          _minutesPerQuarter.add(nowValue);
        }
      }
      case "+":{
        int nowValue = _minutesPerQuarter.value + 1;
        _minutesPerQuarter.add(nowValue);
      }
    }
  }

  void setDefaultValue() {
    _numberOfQuarter.add(1);
    _minutesPerQuarter.add(3);
    _numberOfOT.add(3);
    _choosingMatchTypeIndex.add(0);
  }

  pickAMatchTitle({required String title}){
    _pickingMatchTitle.add(title);
  }

  Future<void> getMatchSetting() async {
    await matchApiProvider.getMatchSetting(context: navigatorKey.currentContext!);
  }

  void changeNumberOfOT({required String symbol}) {
    switch (symbol){
      case "-":{
        if (_numberOfOT.value > 0){
          int nowValue = _numberOfOT.value - 1;
          _numberOfOT.add(nowValue);
        }
      }
      case "+":{
        int nowValue = _numberOfOT.value + 1;
        _numberOfOT.add(nowValue);
      }
    }
  }

  void setCheckRemember(bool? value) =>
      _checkRememberBehavior.sink.add(_checkRememberPass=value!);

}

MatchSettingBloc matchSettingBloc = MatchSettingBloc();