import 'package:http/http.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GameOnApiProvider {
  Client httpClient = Client();
  IO.Socket socket = IO.io(
      'https://ample-crawdad-kind.ngrok-free.app',
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect()
          .setPath("/sio/socket.io/stats")
          .build());

  void socketConnect() {
    socket.connect();
  }

  void emitSocket(String event, {required Map body}) {
    socket.emit(event, body);
  }

  void socketDisconnect() {
    socket.disconnect();
  }
}
