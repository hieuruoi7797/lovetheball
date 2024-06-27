import 'dart:async';

import 'package:rxdart/rxdart.dart';

class TimerCounterBloc{
  late Timer _timer;
  int _secondCount = 60;
  int get secondCount => _secondCount;
  final _timerCounterBehavior = BehaviorSubject<int>();
  Stream<int> get timerCounterBehavior => _timerCounterBehavior.stream;

  void setCountDown(){
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      if (_secondCount == 0) {
        _timer.cancel();
      } else {
        _timerCounterBehavior.sink.add(_secondCount-=1);
      }

    });
  }
  void dispose(){
    _timerCounterBehavior.sink.add(_secondCount=0);
    _timer.cancel();
  }

}
TimerCounterBloc timerBloc = TimerCounterBloc();