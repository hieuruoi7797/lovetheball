import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/src/app.dart';
import 'package:splat_mobile/src/models/player_model.dart';
import 'package:splat_mobile/src/resources/repository.dart';


import '../../../constants/public_values.dart';

class AuthenticationBloc {

  late BuildContext context;

  ///Create a player and save user info in storage
  createUser({
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
      String accessToken = jsonDecode(response.body)["access_token"];
      String refreshToken = jsonDecode(response.body)["refresh_token"];
      await storage.write(key: access_token_key, value: accessToken);
      await storage.write(key: refresh_token_key, value: refreshToken);
      Response? checkingTokenRes = await repository.testToken();
      if (checkingTokenRes != null){
        publicValues.userNow = PlayerModel.fromJson(jsonDecode(checkingTokenRes.body));
        Navigator.pushNamed(navigatorKey.currentContext!, '/home');
      }
    }
  }

  Future<void> refreshToken() async {
    Response? response = await repository.refreshToken();
    if (response != null){
      String accessToken = jsonDecode(response.body)["access_token"];
      await storage.write(key: access_token_key, value: accessToken);
      Response? checkingTokenRes = await repository.testToken();
      if (checkingTokenRes != null) {
        publicValues.userNow =
            PlayerModel.fromJson(jsonDecode(checkingTokenRes.body));
        Navigator.pushNamed(navigatorKey.currentContext!, '/home');
      }
    }
  }

  Future<void> logout() async {
    Response? response = await repository.logout();
    if (response != null){
      Navigator.pushNamed(navigatorKey.currentContext!, '/');
    }
  }
}


  final authenticationBloc = AuthenticationBloc();
