import 'dart:developer';

import 'package:http/http.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GameOnApiProvider {
  Client httpClient = Client();
  late IO.Socket socket;

  GameOnApiProvider() {

    socket = IO.io(
        'https://ample-crawdad-kind.ngrok-free.app',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()// for Flutter or Dart VM
            .setPath("/sio/socket.io")
            .build());
    socket.nsp = '/stats';

  }

  void socketConnect() {
    socket.onConnect((data) => log('connected to socket'));
    socket.onConnectError((data) => log('E: ${data.toString()}'));
    socket.onDisconnect((data) => log('disconnected to socket'));
    socket.on('get_stats', (data) => print("RECEIVED $data"));
    socket.connect();
  }

  void emitSocket(String event, {required Map body}) {
    socket.emit(event, body);
  }

  void socketDisconnect() {
    socket.disconnect();
  }
}
