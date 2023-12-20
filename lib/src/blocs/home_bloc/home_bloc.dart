import 'package:rxdart/rxdart.dart';

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
  }
}

final homeBloc = HomeBloc();