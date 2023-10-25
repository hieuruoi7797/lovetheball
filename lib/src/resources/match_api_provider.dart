import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client, Response;

import '../../constants/api_paths.dart';

class MatchApiProvider {
  Client client = Client();
  // final _apiKey = 'api-key';
  final _baseUrl = "http://abc/v1";

  Future<Response> createMatch({
    required String name,
    required String location,
    required int type,
    required List<String> players,
  }) async {
    Response response;
      response = await client.post(
          Uri.parse(_baseUrl + MATCHES),
          body: jsonEncode({
            "name": name,
            "location": location,
            "type_": type,
            "players": players
          }));
      return response;
  }
}