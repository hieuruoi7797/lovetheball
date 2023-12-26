import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_record/public/public_methods.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/src/resources/repository.dart';

class CreatingUserBloc {
  final _playerCreator = PublishSubject<Response>();
  final _statusBehaviors = BehaviorSubject<String>();

  Stream<Response> get createPlayerRes => _playerCreator.stream;

  Stream<String> get status => _statusBehaviors.stream;

  Future<String> changeStatus(String statusChanged) async {
    _statusBehaviors.add('landed');
    return statusChanged;
  }

  Future<void> getPlayerSaved(BuildContext context) async{
    dynamic playerSaved = await PublicMethod().readContentPlayer();

    ///if the storage have saved user information already, push to HomeScreen.
    if (playerSaved is PlayerModel && playerSaved.name.isNotEmpty){
      if (context.mounted) Navigator.of(context).pushNamed('/home');
      return;
    }
    ///else stay in User Creating Screen
    else if (playerSaved == 'Error'){
      return;
    }
  }

  ///Create a player and save user info in storage
  createPlayer({
    required BuildContext context,
    required String name,
  }) async {
    Response response =
    await repository.createPlayer(context: context, name: name);
    if (response.statusCode == 201) {
      _playerCreator.sink.add(response);
      if (context.mounted) _playerCreatedSuccess(context,response);
    } else {
        _playerCreator.sink.add(response);
      () => _playerCreatedFail(context);

    }
    }

  dispose() {
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


  final playerBloc = CreatingUserBloc();
