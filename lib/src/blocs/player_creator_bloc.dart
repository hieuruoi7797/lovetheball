import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_record/src/resources/repository.dart';
import 'package:splat_record/widgets_common/loading.dart';

class PlayerCreatorBloc {
  final _repository = Repository();
  final _playerCreator = PublishSubject<Response>();
  final _statusBehaviors = BehaviorSubject<String>();

  Stream<Response> get createPlayerRes => _playerCreator.stream;
  Stream<String> get status => _statusBehaviors.stream;

  Future<String> changeStatus(String statusChanged) async {
    _statusBehaviors.add('landed');
    return statusChanged;
  }

  createPlayer({
    required BuildContext context,
    required String name,
  }) async {
    Response response = await _repository.createPlayer(context: context, name: name);
    if (response.statusCode == 200){
      _statusBehaviors.add('player_create_success');
      _playerCreator.sink.add(response);
    }else{
      _statusBehaviors.add('player_create_fail');
      _playerCreator.sink.add(response);
    }
  }

  dispose() {
    _playerCreator.close();
    _statusBehaviors.close();
  }

  Future<void>? statusHandler(BuildContext context, AsyncSnapshot<String> snapshot) async {
    print("STATUS STREAM: ${snapshot.data}");
    switch (snapshot.data) {
      case "player_create_success":
        {
          playerBloc.dispose();
          context.mounted ? Navigator.pushReplacementNamed(context, '/home'):null;
        }
      case "player_create_fail":
        {
          Response responseFail = await _playerCreator.stream.last;
          String message = responseFail.body.toString();
          return Future.delayed(Duration.zero, () => DialogWidget().showFailDialog(context, "FAIL")
        );
        }
    }


  }


}

final playerBloc = PlayerCreatorBloc();