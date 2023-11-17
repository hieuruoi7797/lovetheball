import 'package:rxdart/rxdart.dart';
import 'package:splat_record/src/models/stat_model.dart';
import 'package:splat_record/src/resources/repository.dart';

class GameOnBloc {
  final _repository = Repository();
  final _twoPointerQuantity = PublishSubject<int>();

  int twoPointerQuantityInt = 0;

  Stream<int> get twoPointerQuantity => _twoPointerQuantity.stream;

  dispose() {
    _twoPointerQuantity.close();
  }

  increase(String statType) {
    switch(statType){
      case "2-Pointer":
        twoPointerQuantityInt++;
        _twoPointerQuantity.sink.add(twoPointerQuantityInt);
    }
  }

  decrease(String s) {
    switch(s){
      case "2-Pointer":
        if (twoPointerQuantityInt > 0) {
          twoPointerQuantityInt--;
          _twoPointerQuantity.sink.add(twoPointerQuantityInt);
        }
    }
  }
}

final gameOnBloc = GameOnBloc();