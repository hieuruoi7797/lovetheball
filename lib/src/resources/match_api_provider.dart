import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:splat_record/widgets_common/loading.dart';

import '../../constants/api_paths.dart';

class MatchApiProvider {
  Client client = Client();

  // final _apiKey = 'api-key';
  final _baseUrl = "https://ample-crawdad-kind.ngrok-free.app/v1";

  Future<Response> createMatch({
    required BuildContext context,
    required String name,
    required String location,
    required int type,
    required List<String> players,
  }) async {
    Response response;
    DialogWidget().showLoaderDialog(context);
    response = await client.post(Uri.parse(_baseUrl + MATCHES),
        body: jsonEncode({
          "name": name,
          "location": location,
          "type_": type,
          "players": players
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },);
    Navigator.pop(context);
    return response;
  }
}
