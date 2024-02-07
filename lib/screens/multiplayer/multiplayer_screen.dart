import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
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
  late bool isWait;
  late bool triangleIsVisible;
  late QuestionsService questionsService;
  late int currentQuestionIndex;

  @override
  void initState() {
    super.initState();
    isWait = true;
    triangleIsVisible = false;
    currentQuestionIndex = 0;

    questionsService = QuestionsService(
      context: context,
      onLoadingStateChanged: (bool loading) {
        if (mounted) {
          setState(() {
            triangleIsVisible = triangleIsVisible;
          });
        }
      },
      userProvider: widget.userProvider,
      index: currentQuestionIndex,
    );

    loadQuestions();
  }

  void loadQuestions() {
    final multiplayer = widget.userProvider.userModel.multiplayer;
    if (multiplayer.isConnected && multiplayer.opponentAvailable) {
      questionsService.loadQuestions(tournament: multiplayer.opponent.round);
      return;
    }

    questionsService.loadQuestions();
  }

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
                      print(questionsService.questions[0]);
                    }),
                child: const Text('press')),
          ],
        ));
  }
}
