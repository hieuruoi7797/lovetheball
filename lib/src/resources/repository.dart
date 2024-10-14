// import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:splat_mobile/src/models/base_api_model.dart';
import 'package:splat_mobile/src/resources/authentication_api_provider.dart';
import 'package:splat_mobile/src/resources/gameon_api_provider.dart';
import 'package:splat_mobile/src/resources/invitation_api_provider.dart';
import 'package:splat_mobile/src/resources/match_api_provider.dart';
import 'package:splat_mobile/src/resources/player_api_provider.dart';

class Repository {
  final _matchApiProvider = MatchApiProvider();
  final _playerApiProvider = PlayerApiProvider();
  final _authenticationProvider = AuthenticationiApiProvider();
  final _gameOnApiProvider = GameOnApiProvider();
  final _invitationUserProvider = InvitationApiProvider();

  Future<Response> createMatch({
    required BuildContext context,
    required String name,
    required String location,
    required int type,
    required List<String> players,
  }) =>
      _matchApiProvider.createMatch(
        context: context,
        name: name,
        location: location,
        type: type,
        players: players,
      );

  Future<Response> getMatchesList(BuildContext context)
    => _matchApiProvider.getMatchesList(context: context);

  Future<Response?> login({required String email, required String pw})
  => _authenticationProvider.login(inputEmail: email, inputPasswords: pw);

  Future<Response> getUsers(BuildContext context)
  => _invitationUserProvider.getUser(context: context);

  Future<Response> getUsersById(BuildContext context, String userId)
  => _invitationUserProvider.getUserById(context: context, userId: userId);

  Future<BaseApiModel?> createUser(
          {
            required String email,
          }) async =>
      await _authenticationProvider.createUser(
        email: email,
      );
  //xac thuc otp email
  Future<BaseApiModel?> verifiCreateUser(
  {
    required String email,
    required String otp,

  }) async => await _authenticationProvider.verifiCreateUser(email: email, otp: otp);

  Future<BaseApiModel?> createUserLogin(
      {
        required Map body,
      }) async =>
      await _authenticationProvider.createUserLogin(body: body);

  Future<Response> getPlayers({String? matchId}) async =>
      await _playerApiProvider.getPlayer(matchId:  matchId);

  void socketConnect(String namespace) {
    _gameOnApiProvider.socketConnect(namespace);
  }

  void emitSocket(String event, {required Map<dynamic, dynamic> body}) {
    _gameOnApiProvider.emitSocket(event, body: body);
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

  Future<Response?> testToken() => _authenticationProvider.testToken();

  Future<Response?> refreshToken() =>  _authenticationProvider.refreshToken();
  Future<Response?> loginGG() =>  _authenticationProvider.loginGG();

  Future<Response?> logout() => _authenticationProvider.logout();
}

final repository = Repository();
