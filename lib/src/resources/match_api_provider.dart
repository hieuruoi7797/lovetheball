import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:splat_record/constants/constant_values.dart';
import 'package:splat_record/constants/public_values.dart';
import 'package:splat_record/public/public_methods.dart';
import 'package:splat_record/src/blocs/player/user_bloc.dart';
import 'package:splat_record/widgets_common/dialogs.dart';

import '../../constants/api_paths.dart';

class MatchApiProvider {
  Client client = Client();

  // final _apiKey = 'api-key';
  final _baseUrl = BASEURL;

  Future<Response> createMatch({
    required BuildContext context,
    required String name,
    required String location,
    required int type,
    required List<String> players,
  }) async {
    Response response;
    // DialogWidget().showLoaderDialog();
    response = await PublicMethods().post(body:{
      "name": name,
      "location": location,
      "type_": type,
      "players": players
    }, subUri: MATCHES, showLoader: true, isFormData: false);
    // response = await client.post(Uri.parse(_baseUrl + MATCHES),
    //     body: jsonEncode({
    //       "name": name,
    //       "location": location,
    //       "type_": type,
    //       "players": players
    //     }),
    //     // headers: headerWithToken,
    // );
    // Navigator.pop(context);
    return response;
  }

  Future<Response> getMatchesList({
    required BuildContext context,
  }) async {
    Response response;
    response = await PublicMethods().get(
        subUri: MATCHES,
        showLoader: false,
        queryParameters:  {
      'limit':'500',
      'offset':'0'
    });
    return response;
  }
}
