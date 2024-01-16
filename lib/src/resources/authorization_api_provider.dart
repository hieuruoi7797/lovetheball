import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:splat_record/constants/api_paths.dart';
import 'package:splat_record/constants/constant_values.dart';
import 'package:splat_record/widgets_common/dialogs.dart';

class AuthorizationApiProvider {
  Client client = Client();
  final _baseUrl = BASEURL;

  Future<Response> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    Response response;
    var map = new Map<String, dynamic>();
    map['username'] = email;
    map['password'] = password;

    DialogWidget().showLoaderDialog();
    response = await client.post(
      Uri.parse(_baseUrl + LOGIN),
      body: map,
      headers: headerWithoutToken,
    );
    Future.delayed(Duration.zero, () => Navigator.pop(context));
    if (response.statusCode == 201) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(context, ERROR_FAIL));
      return response;
    }
  }
}
