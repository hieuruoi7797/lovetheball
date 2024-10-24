
// import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:splat_mobile/public/public_methods.dart';

import '../../constants/api_paths.dart';

class MatchApiProvider {

  // final _apiKey = 'api-key';

  Future<Response> createMatch({
    required BuildContext context,
    required String name,
    required String location,
    required int type,
    required List<String> players,
  }) async {
    Response response;
    response = await PublicMethods().post(body:{
      "name": name,
      "location": location,
      "type_": type,
      "players": players
    }, subUri: matches_path, showLoader: true, isFormData: false);
    return response;
  }

  Future<Response> getMatchesList({
    required BuildContext context,
  }) async {
    Response response;
    response = await PublicMethods().get(
        subUri: matches_path,
        showLoader: false,
        queryParameters:  {
      'limit':'500',
      'offset':'0'
    });
    return response;
  }

  Future<Response> getMatchSetting({
    required BuildContext context,
  }) async {
    Response response;
    response = await PublicMethods().get(
        subUri: MATCH_SETTING,
        showLoader: false,
        queryParameters:  {
          "match_type" : '0',
          'limit':'1',
          'offset':'0'
        });
    return response;
  }

  Future<Response> postMatchSetting({
    required Map body}) async {
    Response response;
    response = await PublicMethods().post(
        body:body,
        subUri: MATCH_SETTING,
        showLoader: true,
        isFormData: false);
    return response;
  }
}
