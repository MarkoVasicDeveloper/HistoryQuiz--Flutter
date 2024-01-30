import 'package:istorija_srbije/core/constant/connection.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connectToServer() {
    socket = IO.io(socketServer, <String, dynamic>{
      'reconnection': false,
    });

    socket.on('connect', (_) {
      print('Povezivanje uspešno!');
    });

    socket.on('connect_error', (data) {
      print('Greška prilikom povezivanja: $data');
    });

    socket.on('disconnect', (_) {
      print('Odspajanje od servera');
    });
  }

  void joinGame(String playerName) {
    socket.emit('joinGame', {'playerName': playerName});
  }

  void disconnect() {
    socket.disconnect();
  }
}
