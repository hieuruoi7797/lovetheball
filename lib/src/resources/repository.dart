import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:splat_record/src/resources/match_api_provider.dart';

class Repository {
  final matchApiProvider = MatchApiProvider();

  Future<Response> createMatch(
  {
    required BuildContext context,
    required String name,
    required String location,
    required int type,
    required List<String> players,
  }) => matchApiProvider.createMatch(
      context: context,
      name: name,
      location: location,
      type: type,
      players: players,
  );
}