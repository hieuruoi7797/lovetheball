import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:splat_record/src/app.dart';
import 'package:splat_record/widgets_common/dialogs.dart';

import '../../constants/api_paths.dart';
import '../../constants/constant_values.dart';

class PlayerApiProvider {
  Client client = Client();
  final _baseUrl = BASEURL;

  Future<Response> createPlayer({
    required BuildContext context,
    required String name,
  }) async {
    Response response;
    DialogWidget().showLoaderDialog();
    response = await client.post(
      Uri.parse(_baseUrl + PLAYERS),
      body: jsonEncode(<String, dynamic>{
        "name": name,
        // "gender": 0,
        // "birth_date": "",
        // "email": "",
        // "phone": ""
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
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

  Future<Response> getPlayer({
    String? matchId,
  }) async {
    Response response;
    DialogWidget().showLoaderDialog();
    response = await client.get(
      Uri.parse(_baseUrl + PLAYERS)
          .replace(queryParameters: {'match_id': matchId ?? ""}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    Future.delayed(Duration.zero, () => Navigator.pop(navigatorKey.currentContext!));
    if (response.statusCode == 200) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(navigatorKey.currentContext!, ERROR_FAIL));
      return response;
    }
  }
}
