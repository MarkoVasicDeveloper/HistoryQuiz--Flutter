import 'package:istorija_srbije/core/constant/connection.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  final UserProvider _userProvider;
  late void Function(bool isConnected, bool? isPlayer) onConnectionChanged;
  late void Function(bool timer) onRegistrationResponse;
  late void Function(Map<String, dynamic> data) setOpponent;

  SocketService({required UserProvider userProvider})
      : _userProvider = userProvider;

  void connectToServer() {
    final userModel = _userProvider.userModel;
    socket = IO.io(socketServer, <String, dynamic>{
      'reconnection': false,
    });

    socket.on('connect', (data) {
      _userProvider.setIsConnected(true);
      onConnectionChanged(true, null);
      print('Connection success');

      final registerData = {
        'username': userModel.username,
        'success': userModel.success.procentage,
        'stage': userModel.multiplayer.currentStage
      };

      socket.emit('register', registerData);
    });

    socket.on('connect_error', (data) {
      _userProvider.setIsConnected(false);
      onConnectionChanged(false, null);
      print('Error: $data');
    });

    socket.on('registrationResponse', (data) {
      if (data['succes']) onRegistrationResponse(true);
      if (data['failed']) onRegistrationResponse(false);
    });

    socket.on('opponent', (data) => {setOpponent(data)});

    socket.on('disconnect', (_) {
      _userProvider.setIsConnected(false);
      onConnectionChanged(false, null);
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
