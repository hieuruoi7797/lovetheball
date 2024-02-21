
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:splat_mobile/public/public_methods.dart';

import '../../constants/api_paths.dart';

class MatchApiProvider {
  Client client = Client();

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
    }, subUri: MATCHES, showLoader: true, isFormData: false);
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
