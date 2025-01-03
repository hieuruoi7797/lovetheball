import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/live_stat_model.dart';

class LiveStatBloc {
  final _liveStatsStream = BehaviorSubject<List<LiveStatModel>>();
  final _statEnable = BehaviorSubject<bool>();

  Stream<List<LiveStatModel>> get liveStatsStream => _liveStatsStream;
  Stream<bool> get statEnable => _statEnable;

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
}

final liveStatBloc = LiveStatBloc();
