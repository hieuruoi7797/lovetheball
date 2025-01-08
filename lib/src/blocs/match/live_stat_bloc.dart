import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/src/blocs/lobby/lobby_bloc.dart';
import 'package:splat_mobile/src/blocs/match/match_bloc.dart';
import 'package:splat_mobile/src/models/player_model.dart';

import '../../models/live_stat_model.dart';

class LiveStatBloc {
  final BehaviorSubject<List<LiveStatModel>> _liveStatsStream = BehaviorSubject<List<LiveStatModel>>();
  final BehaviorSubject<int> _pickingPlayerIndexTeamA = BehaviorSubject<int>();
  final BehaviorSubject<int> _pickingPlayerIndexTeamB = BehaviorSubject<int>();
  final BehaviorSubject<bool> _statAddingStatus = BehaviorSubject<bool>();
  final BehaviorSubject<PlayerModel> _pickingPlayer = BehaviorSubject<PlayerModel>();

  Stream<List<LiveStatModel>> get liveStatsStream => _liveStatsStream.stream;
  Stream<bool> get statAddingStatus => _statAddingStatus.stream;
  Stream<int> get pickingPlayerIndexTeamA => _pickingPlayerIndexTeamA.stream;
  Stream<int> get pickingPlayerIndexTeamB => _pickingPlayerIndexTeamB.stream;
  Stream<PlayerModel> get pickingPlayer => _pickingPlayer.stream;

  // PlayerModel pickingPlayer = PlayerModel(id: "000", name: "UNKNOWN");
  init(){
    _pickingPlayerIndexTeamA.add(6);
    _pickingPlayerIndexTeamB.add(6);
    _statAddingStatus.add(false);
    _liveStatsStream.add([]);
    _pickingPlayer.add(PlayerModel(id: "000", name: "UNKNOWN"));
  }

  List<Map> offensiveStatsList = [
    {
      "statName": "Ghi diem TVC",
      "icon": SvgPicture.asset("")
    },
    {
      "statName": "Ghi diem NVC",
      "icon": SvgPicture.asset("")
    },
    {
      "statName": "Ghi diem NP",
      "icon": SvgPicture.asset("")
    },
    {
      "statName": "TVC That bai",
      "icon": SvgPicture.asset("")
    },
    {
      "statName": "NVC That bai",
      "icon": SvgPicture.asset("")
    },
    {
      "statName": "NP That bai",
      "icon": SvgPicture.asset("")
    },


  ];

  List<Map> defensiveStatsList = [
    {
      "statName": "Ho tro",
      "icon": SvgPicture.asset("")
    },
    {
      "statName": "Chan",
      "icon": SvgPicture.asset("")
    },
    {
      "statName": "Pham loi",
      "icon": SvgPicture.asset("")
    },
    {
      "statName": "Bat bong",
      "icon": SvgPicture.asset("")
    },
    {
      "statName": "Cuop bong",
      "icon": SvgPicture.asset("")
    },
    {
      "statName": "Mat luot",
      "icon": SvgPicture.asset("")
    },
  ];

  void changeEnableStatus(int playerIndex, String teamName) {
    switch (teamName){
      case Constants.TEAM_A:
        if (_pickingPlayerIndexTeamA.value == playerIndex){
          _pickingPlayerIndexTeamA.add(6);
        }else{
          _pickingPlayerIndexTeamA.add(playerIndex);
          _pickingPlayerIndexTeamB.add(6);
          _pickingPlayer.add(lobbyBloc.listTeamPlayersOne.value[playerIndex]);
        }
        // if (_pickingPlayerIndexTeam1.value < 6){
        //   pickingPlayer = (lobbyBloc.listTeamPlayersOne.value)[_pickingPlayerIndexTeam1.value];
        // }
      case Constants.TEAM_B:
        if (_pickingPlayerIndexTeamB.value == playerIndex){
          _pickingPlayerIndexTeamB.add(6);
        }else{
          _pickingPlayerIndexTeamB.add(playerIndex);
          _pickingPlayerIndexTeamA.add(6);
          _pickingPlayer.add(lobbyBloc.listTeamPlayersTwo.value[playerIndex]);
        }
        // if (_pickingPlayerIndexTeam2.value < 6){
        //   pickingPlayer = (lobbyBloc.listTeamPlayersTwo.value)[_pickingPlayerIndexTeam2.value];
        // }

    }
    if (_pickingPlayerIndexTeamA.value < 6 || _pickingPlayerIndexTeamB.value < 6){
      _statAddingStatus.add(true);
    }else{
      _statAddingStatus.add(false);
    }
  }

  void addLiveStat(String statName) async {
    if (_statAddingStatus.value == true){
      List<LiveStatModel> listStatNow = _liveStatsStream.hasValue ? _liveStatsStream.value : [];
      LiveStatModel addingLiveStat = LiveStatModel(
          statName: statName,
          player: _pickingPlayer.value,
          timeStamp: DateFormat("HH:mm:ss").format(DateTime.now()));
      listStatNow.add(addingLiveStat);
      _liveStatsStream.add(listStatNow.reversed.toList());
    }
  }
}

final liveStatBloc = LiveStatBloc();
