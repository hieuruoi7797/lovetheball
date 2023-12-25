import 'package:rxdart/rxdart.dart';
import 'package:splat_record/src/app.dart';
import 'package:splat_record/src/blocs/match/match_bloc.dart';

class HomeBloc {
  int _pageIndexInt = 1;

  final _pageIndexBehavior = BehaviorSubject<int>();

  Stream<int> get pageIndex => _pageIndexBehavior.stream;

  HomeBloc() {
    _pageIndexBehavior.sink.add(_pageIndexInt);
  }

  void onTabPageIndex(int index){
    _pageIndexInt = index;
    _pageIndexBehavior.sink.add(_pageIndexInt);
    if (index == 2){
      matchBloc.getMatchesList(navigatorKey.currentContext!);
    }else if (index == 1){
      matchBloc.getPlayerList(context: navigatorKey.currentContext!);
    }
  }
}

final homeBloc = HomeBloc();