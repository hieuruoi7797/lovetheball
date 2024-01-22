import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:splat_record/src/app.dart';
import 'package:splat_record/src/models/player_model.dart';
import 'package:splat_record/src/resources/repository.dart';

import '../../../constants/public_values.dart';

class UserBloc {




  ///Create a player and save user info in storage
  createPlayer({
    required String name,
    required String email,
    required String password,
  }) async {
    Response? response =
    await repository.createUser(name: name, email: email, password: password);
    if (response != null) {
     _playerCreatedSuccess(response);
    } else {
    }
    }

  dispose() {
  }

  _playerCreatedSuccess(Response response) {
    // Response? checkingTokenRes = await repository.testToken();
    // if (checkingTokenRes != null) {
    //
    // }
      Navigator.pop(navigatorKey.currentContext!);
  }

  Future<void> login({required String email, required String pw}) async{
    Response? response = await repository.login(email: email, pw: pw);
    if (response != null){
      String accessToken = jsonDecode( response.body)["access_token"];
      await storage.write(key: 'access_token', value: accessToken);
      Response? checkingTokenRes = await repository.testToken();
      if (checkingTokenRes != null){
        publicValues.userNow = PlayerModel.fromJson(jsonDecode(checkingTokenRes.body));
        Navigator.pushNamed(navigatorKey.currentContext!, '/home');
      }
    }
  }
}


  final userBloc = UserBloc();
