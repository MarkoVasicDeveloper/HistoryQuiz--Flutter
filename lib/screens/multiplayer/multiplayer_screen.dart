import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/multiplayer/service/socket_service.dart';
import 'package:istorija_srbije/screens/multiplayer/widget/countdown_timer.dart';

class Multiplayer extends StatefulWidget {
  final UserProvider userProvider;

  const Multiplayer({Key? key, required this.userProvider}) : super(key: key);

  @override
  MultiplayerState createState() => MultiplayerState();
}

class MultiplayerState extends State<Multiplayer> {
  late SocketService socketService;
  late bool connect;
  late bool isVisible;

  @override
  void initState() {
    super.initState();
    isVisible = true;

    socketService = SocketService(userProvider: widget.userProvider);
    socketService.connectToServer();

    socketService.onConnectionChanged = (isConnected) {
      setState(() {
        connect = isConnected;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: screenWidth(context),
        height: screenHeight(context),
        child: Stack(
          children: [
            Container(),
            CountdownTimer(
              initialSeconds: 5,
              eventText: 'Sacekajte protivnika...',
              isVisible: isVisible,
              onTimerFinish: () => setState(() {
                isVisible = !isVisible;
              }),
            ),
          ],
        ));
  }
}
