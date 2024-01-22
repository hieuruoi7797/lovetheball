import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:splat_record/constants/public_values.dart';
import 'package:splat_record/src/app.dart';
import 'package:splat_record/src/blocs/player/user_bloc.dart';
import 'package:splat_record/widgets_common/dialogs.dart';

import '../../constants/api_paths.dart';
import '../../constants/constant_values.dart';

class PlayerApiProvider {
  Client client = Client();
  final _baseUrl = BASEURL;



  Future<Response> getPlayer({
    String? matchId,
  }) async {
    Response response;
    DialogWidget().showLoaderDialog();
    String token = await storage.read(key: "access_token") ?? '';
    response = await client.get(
      Uri.parse(_baseUrl + USERS)
          .replace(queryParameters: {'match_id': matchId ?? ""}),
      headers: headerWithToken(token),
    );
    Future.delayed(Duration.zero, () => Navigator.pop(navigatorKey.currentContext!));
    if (response.statusCode == 200) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(ERROR_FAIL));
      return response;
    }
  }
}


