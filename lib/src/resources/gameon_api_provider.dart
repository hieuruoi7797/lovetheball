import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:splat_record/src/blocs/match/match_bloc.dart';

import '../../constants/api_paths.dart';
import '../../constants/constant_values.dart';
import '../../widgets_common/dialogs.dart';
import '../app.dart';

class GameOnApiProvider {
  Client httpClient = Client();
  late IO.Socket socket;
  final _baseUrl = BASEURL;

  GameOnApiProvider() {
    socket = IO.io(
        'https://ample-crawdad-kind.ngrok-free.app',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect() // for Flutter or Dart VM
            .setPath("/sio/socket.io")
            .build());
    socket.nsp = '/stats';
  }
  Future<Response> finishMatch({
    required String matchId,
  }) async {
    Response response;
    DialogWidget().showLoaderDialog();
    response = await httpClient.post(
      Uri.parse(_baseUrl + FINISH_MATCH),
      body: jsonEncode(<String, dynamic>{
        "match_id": matchId,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    Navigator.pop(navigatorKey.currentContext!);
    if (response.statusCode == 200) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(navigatorKey.currentContext!, ERROR_FAIL));
      return response;
    }
  }

  void socketConnect() {
    socket.onConnect((data) => log('connected to socket'));
    socket.onConnectError((data) => log('E: ${data.toString()}'));
    socket.onDisconnect((data) => log('disconnected to socket'));
    socket.connect();
  }

  void emitSocket(String event, {required Map body}) {
    socket.emit(event, body);
  }

  void socketDisconnect() {
    socket.disconnect();
  }

  setStatsList(data) {

  }
}
