import 'package:istorija_srbije/core/constant/connection.dart';
import 'package:istorija_srbije/models/multiplayer_model.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  late io.Socket socket;
  final UserProvider _userProvider;

  SocketService({required UserProvider userProvider})
      : _userProvider = userProvider;

  void connectToServer() {
    socket = io.io(socketServer, <String, dynamic>{
      'transports': ['websocket'],
      'reconnection': false,
    });

    socket.on('connect', (data) {
      _userProvider.setIsConnected(true);
    });

    socket.on('answer', (answer) => '');

    socket.on('connect_error', (data) {
      _userProvider.setIsConnected(false);
    });

    socket.on('opponentAvailable',
        (data) => _userProvider.setOpponentAvailable(data['availablePlayer']));

    socket.on('opponent', (data) {
      OpponentModel opponent = OpponentModel.fromJson(data);
      _userProvider.setOpponent(opponent);
    });

    socket.on('disconnect', (_) {
      _userProvider.setIsConnected(false);
    });
  }

  void emitAnswer(String answer) {
    socket.emit('answer', answer);
  }

  void emitStart() {
    if (_userProvider.userModel.multiplayer.isConnected) {
      socket.emit('start');
    }
  }

  void emitRegistration() {
    final userModel = _userProvider.userModel;

    final registerData = {
      'username': userModel.username,
      'points': userModel.success.points,
      'round': userModel.multiplayer.currentStage
    };

    socket.emit('register', registerData);
  }

  void disconnect() {
    socket.disconnect();
  }
}
