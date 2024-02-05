import 'package:istorija_srbije/core/constant/connection.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  late io.Socket socket;
  final UserProvider _userProvider;

  SocketService({required UserProvider userProvider})
      : _userProvider = userProvider;

  void connectToServer() {
    final userModel = _userProvider.userModel;
    socket = io.io(socketServer, <String, dynamic>{
      'reconnection': false,
    });

    socket.on('connect', (data) {
      _userProvider.setIsConnected(true);

      final registerData = {
        'username': userModel.username,
        'success': userModel.success.procentage,
        'stage': userModel.multiplayer.currentStage
      };

      socket.emit('register', registerData);
    });

    socket.on('connect_error', (data) {
      _userProvider.setIsConnected(false);
    });

    socket.on('registrationResponse', (data) {
      if (data['succes']) _userProvider.setOpponentAvailable(true);
      if (data['failed']) _userProvider.setOpponentAvailable(false);
    });

    socket.on('opponent', (data) => {_userProvider.setOpponent(data)});

    socket.on('disconnect', (_) {
      _userProvider.setIsConnected(false);
    });
  }

  void joinGame(String playerName) {
    socket.emit('joinGame', {'playerName': playerName});
  }

  void disconnect() {
    socket.disconnect();
  }
}
