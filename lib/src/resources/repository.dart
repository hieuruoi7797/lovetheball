import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:splat_record/src/resources/gameon_api_provider.dart';
import 'package:splat_record/src/resources/match_api_provider.dart';
import 'package:splat_record/src/resources/player_api_provider.dart';

class Repository {
  final matchApiProvider = MatchApiProvider();
  final playerApiProvider = PlayerApiProvider();
  final _gameOnApiProvider = GameOnApiProvider();

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

  Future<Response> getMatchesList(BuildContext context)
    => matchApiProvider.getMatchesList(context: context);

  Future<Response> createPlayer(
          {required BuildContext context, required String name}) async =>
      await playerApiProvider.createPlayer(
        context: context,
        name: name,
      );
  Future<Response> getPlayers({String? matchId}) async =>
      await playerApiProvider.getPlayer(matchId:  matchId);

  void socketConnect() {
    _gameOnApiProvider.socketConnect();
  }

  void emitSocket(String emit, {required Map<dynamic, dynamic> body}) {
    _gameOnApiProvider.emitSocket(emit, body: body);
  }

  void disconnect() {
    _gameOnApiProvider.socket.disconnect();
  }

  void close() {
    _gameOnApiProvider.socket.close();
  }

  Future<Response> finishMatch({required String matchId}) async {
    Response response = await _gameOnApiProvider.finishMatch(matchId: matchId);
    return response;
  }
}

final repository = Repository();
