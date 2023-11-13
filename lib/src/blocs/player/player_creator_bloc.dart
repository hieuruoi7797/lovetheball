import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_record/public/public_methods.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/src/resources/repository.dart';
import 'package:splat_record/widgets_common/dialogs.dart';

class PlayerCreatorBloc {
  final _repository = Repository();
  final _playerCreator = PublishSubject<Response>();
  final _statusBehaviors = BehaviorSubject<String>();

  Stream<Response> get createPlayerRes => _playerCreator.stream;

  Stream<String> get status => _statusBehaviors.stream;

  bool _isDisposed = false;

  Future<String> changeStatus(String statusChanged) async {
    _statusBehaviors.add('landed');
    return statusChanged;
  }

  Future<void> getPlayerSaved(BuildContext context) async{
    dynamic playerSaved = await PublicMethod().readContentPlayer();
    if (playerSaved is PlayerModel && playerSaved.name.isNotEmpty){
      if (context.mounted) Navigator.of(context).pushNamed('/home');
      return;
    }else if (playerSaved == 'Error'){
      return;
    }
  }

  createPlayer({
    required BuildContext context,
    required String name,
  }) async {
    Response response =
    await _repository.createPlayer(context: context, name: name);
    if (response.statusCode == 201) {
      _playerCreator.sink.add(response);
      if (context.mounted) _playerCreatedSuccess(context,response);
    } else {
        _playerCreator.sink.add(response);
      () => _playerCreatedFail(context);

    }
    }

  dispose() {
    _isDisposed = true;
    _playerCreator.close();
    _statusBehaviors.close();
  }

  Future<void> _playerCreatedSuccess(BuildContext context,Response response) async {
    _statusBehaviors.add('player_create_success');
    Map jsonResponseBody = jsonDecode(response.body)['data'][0];
    await PublicMethod().writeContentPlayerFile(jsonResponseBody);
    if (context.mounted) Navigator.of(context).pushNamed('/home');
  }

  Future<void> _playerCreatedFail(BuildContext context) async{
    _statusBehaviors.add('player_create_fail');
  }
}


  final playerBloc = PlayerCreatorBloc();
