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
      'transports': ['websocket'],
      'reconnection': false,
    });

    socket.on('connect', (data) {
      _userProvider.setIsConnected(true);

      final registerData = {
        'username': userModel.username,
        'success': userModel.success.points,
        'stage': userModel.multiplayer.currentStage
      };

      socket.emit('register', registerData);
    });

    socket.on(
        'answer', (answer) => _userProvider.setOpponentCurrentAnswer(answer));

    socket.on('connect_error', (data) {
      _userProvider.setIsConnected(false);
    });

    socket.on('registrationResponse', (data) {
      _userProvider.setOpponentAvailable(data['availablePlayer']);
    });

    socket.on('opponent', (data) => {_userProvider.setOpponent(data)});

    socket.on('disconnect', (_) {
      _userProvider.setIsConnected(false);
    });
  }

  void emitAnswer(String answer) {
    socket.emit('answer', answer);
  }

  void disconnect() {
    socket.disconnect();
  }
}
