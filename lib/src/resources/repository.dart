import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:splat_record/src/resources/match_api_provider.dart';
import 'package:splat_record/src/resources/player_api_provider.dart';

class Repository {
  final matchApiProvider = MatchApiProvider();
  final playerApiProvider = PlayerApiProvider();

  Future<Response> createMatch({
    required BuildContext context,
    required String name,
    required String location,
    required int type,
    required List<String> players,
  }) =>
      matchApiProvider.createMatch(
        context: context,
        name: name,
        location: location,
        type: type,
        players: players,
      );

  Future<Response> createPlayer(
          {required BuildContext context, required String name}) async =>
      await playerApiProvider.createPlayer(
        context: context,
        name: name,
      );
  Future<Response> getPlayers(
          {required BuildContext context}) async =>
      await playerApiProvider.getPlayer(
        context: context,
      );
}
