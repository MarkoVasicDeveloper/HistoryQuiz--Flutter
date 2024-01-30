import 'package:istorija_srbije/core/constant/connection.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  final UserProvider _userProvider;

  SocketService({required UserProvider userProvider})
      : _userProvider = userProvider;

  void connectToServer() {
    socket = IO.io(socketServer, <String, dynamic>{
      'reconnection': false,
    });

    socket.on('connect', (data) {
      _userProvider.setIsConnected(true);
      print('Connection success');
      // send register data

      // socket.emit('register', podaciZaSlanje);
    });

    socket.on('connect_error', (data) {
      _userProvider.setIsConnected(false);
      print('Error: $data');
    });

    socket.on('disconnect', (_) {
      _userProvider.setIsConnected(false);
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
