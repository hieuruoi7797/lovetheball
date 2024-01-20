import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:splat_record/constants/api_paths.dart';
import 'package:splat_record/constants/constant_values.dart';
import 'package:splat_record/constants/public_values.dart';
import 'package:splat_record/src/blocs/player/user_bloc.dart';
import 'package:splat_record/widgets_common/dialogs.dart';

class AuthorizationApiProvider {
  Client client = Client();
  final _baseUrl = BASEURL;

  Future<Response?> login({
    required String email,
    required String password,
  }) async {
    Response response;
    var map = <String, dynamic>{};
    map['username'] = email;
    map['password'] = password;

    DialogWidget().showLoaderDialog();
    response = await client.post(
      Uri.parse(_baseUrl + LOGIN),
      body: map,
      headers: headerFormData,
    );
    Future.delayed(Duration.zero, () => DialogWidget().dismissLoader());
    if (response.statusCode == 200) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(jsonDecode(response.body)['error']));
      return null;
    }
  }

  Future<Response?> testToken() async {
    Response response;
    String token = userBloc.accessTokenBehavior.stream.value;
    DialogWidget().showLoaderDialog();
    response = await client.post(
      Uri.parse(_baseUrl + TEST_TOKEN),
      // body: {},
      headers: headerWithToken(token),
    );
    DialogWidget().dismissLoader();
    if (response.statusCode == 200) {
      return response;
    }else{
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(jsonDecode(response.body)['detail']));
      return null;
    }
  }

  Future<Response?> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    Response response;
    DialogWidget().showLoaderDialog();
    response = await client.post(
      Uri.parse(_baseUrl + PLAYERS),
      body: jsonEncode(<String, dynamic>{
        "name": name,
        "gender": 0,
        "birth_date": "07/07/1997",
        "email": email,
        "phone": "",
        "avartar": "",
        "password": password
      }),
      headers: headerWithoutToken,
    );
    Future.delayed(Duration.zero, () => DialogWidget().dismissLoader());
    if (response.statusCode == 201) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(ERROR_FAIL));
      return null;
    }
  }
}
