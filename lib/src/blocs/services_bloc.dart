import 'package:splat_mobile/public/public_methods.dart';
import 'package:rxdart/rxdart.dart';


class ServiceBloc{
  bool isLoading = false;

  final _isLoading = PublishSubject<bool>();

  Stream<bool> get getLoadingStatus => _isLoading.stream;

  changeLoadingStatus(){
    isLoading = !isLoading;
    _isLoading.add(isLoading);
  }

}

final serviceBloc = ServiceBloc();