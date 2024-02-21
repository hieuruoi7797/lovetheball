import 'dart:developer';

import 'package:http/http.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:splat_mobile/public/public_methods.dart';
import 'package:splat_mobile/src/blocs/game_on/game_on_bloc.dart';

import '../../constants/api_paths.dart';
import '../../constants/constant_values.dart';
import '../../widgets_common/dialogs.dart';

class GameOnApiProvider {
  Client httpClient = Client();
  late IO.Socket socket;

  GameOnApiProvider();

  Future<Response> finishMatch({
    required String matchId,
  }) async {
    Response response;
    response = await PublicMethods().post(
        body: {
          "match_id": matchId,
        },
        subUri: FINISH_MATCH,
        showLoader: true,
        isFormData: false);
    if (response.statusCode == 200) {
      return response;
    } else {
      await Future.delayed(
          Duration.zero, () => DialogWidget().showFailDialog(error_fail));
      return response;
    }
  }

  void socketConnect() {
    socket = IO.io(
      'https://ample-crawdad-kind.ngrok-free.app',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // for Flutter or Dart VM
          .setPath("/sio/socket.io")
          .build());
    socket.nsp = '/stats';
    socket.connect();
    socket.onConnect((data) {
      socket.on('get_stats', (data) =>  gameOnBloc.updateStats(data));
      socket.on('disconnect', (data) =>  gameOnBloc.dispose(data));
    });
    socket.onConnectError((data) => log('E: ${data.toString()}'));
    socket.onDisconnect((data) => log('disconnected to socket'));

  }

  void emitSocket(String event, {required Map body}) {
    print("EMIT: $body");
    socket.emit(event, body);
  }

  void socketDisconnect() {
    socket.disconnect();
  }

  setStatsList(data) {

  }
}
