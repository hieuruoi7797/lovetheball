import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:splat_mobile/constants/api_paths.dart';
import 'package:splat_mobile/constants/constant_values.dart';
import 'package:splat_mobile/public/public_methods.dart';
import 'package:splat_mobile/src/app.dart';
import 'package:splat_mobile/widgets_common/dialogs.dart';

class AuthenticationiApiProvider {
  Client client = Client();

  Future<Response?> login({
    required String inputEmail,
    required String inputPasswords,
  }) async {
    Response response;
    var map = <String, dynamic>{};
    map['username'] = inputEmail;
    map['password'] = inputPasswords;
    response = await PublicMethods().post(
        body: map,
        subUri: login_path,
        showLoader: true,
        isFormData: true,
    );

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
    response = await PublicMethods().post(
        body: {},
        subUri: test_token_path,
        showLoader: false,
        isFormData: false
    );
    if (response.statusCode == 200) {
      return response;
    }else{
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(jsonDecode(response.body)['detail']));
      return null;
    }
  }

  Future<Response?> refreshToken() async {
    Response response;
    response = await PublicMethods().post(
        body: {},
        subUri: refresh_token_url,
        showLoader: true,
        isFormData: false
    );
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
    response = await PublicMethods().post(
        body: {
            "name": name,
            "gender": 0,
            "birth_date": "07/07/1997",
            "email": email,
            "phone": "",
            "avartar": "",
            "password": password
          },
        subUri: user_path,
        showLoader: true,
        isFormData: false,
    );
    if (response.statusCode == 201) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(error_fail));
      return null;
    }
  }

  Future<Response?> logout() async {
    Response response;
    response = await PublicMethods().delete(
      subUri: logout_path,
      showLoader: true,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(error_fail));
      return null;
    }
  }
}
