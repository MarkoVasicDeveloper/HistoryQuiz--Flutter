import 'package:flutter/material.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/multiplayer/service/socket_service.dart';

class MultiplayerIntroScreen extends StatefulWidget {
  final UserProvider userProvider;

  const MultiplayerIntroScreen({super.key, required this.userProvider});

  @override
  MultiplayerIntroScreenState createState() => MultiplayerIntroScreenState();
}

class MultiplayerIntroScreenState extends State<MultiplayerIntroScreen> {
  late SocketService socketService;

  @override
  void initState() {
    super.initState();

    socketService = SocketService(userProvider: widget.userProvider);
    socketService.connectToServer();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
              Navigator.pushNamed(
                context,
                '/multiplayer',
                arguments: {'socketService': socketService},
              )
            },
        child: const Text('Start'));
  }
}
