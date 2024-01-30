import 'package:istorija_srbije/core/constant/connection.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connectToServer() {
    socket = IO.io(socketServer, <String, dynamic>{
      'reconnection': false,
    });

    socket.on('connect', (data) {
      print('Connection success');
      // send register data

      // socket.emit('register', podaciZaSlanje);
    });

    socket.on('connect_error', (data) {
      print('Error: $data');
    });

    socket.on('disconnect', (_) {
      print('disconnect');
    });
  }

  void joinGame(String playerName) {
    socket.emit('joinGame', {'playerName': playerName});
  }

  void disconnect() {
    socket.disconnect();
  }
}
