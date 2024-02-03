import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/multiplayer/service/socket_service.dart';
import 'package:istorija_srbije/screens/multiplayer/widget/countdown_timer.dart';
import 'package:istorija_srbije/screens/multiplayer/widget/triangle.dart';
import 'package:istorija_srbije/screens/question/service/question_service.dart';

class Multiplayer extends StatefulWidget {
  final UserProvider userProvider;

  const Multiplayer({Key? key, required this.userProvider}) : super(key: key);

  @override
  MultiplayerState createState() => MultiplayerState();
}

class MultiplayerState extends State<Multiplayer> {
  late SocketService socketService;
  late bool connect = false;
  late bool isWait;
  late bool triangleIsVisible;
  late QuestionsService questionsService;
  late bool? noPlayer;
  late Map<String, dynamic> opponent;

  @override
  void initState() {
    super.initState();
    isWait = true;
    triangleIsVisible = false;

    socketService = SocketService(userProvider: widget.userProvider);
    socketService.connectToServer();

    socketService.onConnectionChanged = (isConnected, isPlayer) {
      setState(() {
        connect = isConnected;
        noPlayer = isPlayer;
      });
    };

    socketService.onRegistrationResponse = (isRecived) {
      setState(() {
        isWait = isRecived;
      });
    };

    socketService.setOpponent = (data) {
      setState(() {
        opponent = {'username': data['username'], 'points': data['points']};
        triangleIsVisible = true;
      });
    };
  }

  void loadQuestions() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: screenWidth(context),
        height: screenHeight(context),
        child: Stack(
          children: [
            CountdownTimer(
              initialSeconds: 5,
              eventText: 'Sacekajte protivnika...',
              isVisible: isWait,
              onTimerFinish: () => setState(() {
                isWait = !isWait;
                // triangleIsVisible = !triangleIsVisible;
              }),
            ),
            Triangle(
              isVisible: triangleIsVisible,
              left: true,
              username: widget.userProvider.userModel.username,
              points: widget.userProvider.userModel.success.points,
            ),
            Triangle(
              isVisible: triangleIsVisible,
              left: false,
              username: 'Predrag',
              points: 1590,
            ),
            ElevatedButton(
                onPressed: () => setState(() {
                      isWait = !isWait;
                    }),
                child: const Text('press')),
          ],
        ));
  }
}
