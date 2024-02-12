import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/multiplayer/service/socket_service.dart';
import 'package:istorija_srbije/screens/multiplayer/widget/countdown_timer.dart';
import 'package:istorija_srbije/screens/multiplayer/widget/triangle.dart';
import 'package:istorija_srbije/screens/question/service/question_service.dart';
import 'package:istorija_srbije/screens/question/widget/answers/answers_container.dart';
import 'package:istorija_srbije/screens/question/widget/question_asset.dart';
import 'package:istorija_srbije/screens/question/widget/question_container.dart';

class Multiplayer extends StatefulWidget {
  final UserProvider userProvider;
  final SocketService socketService;

  const Multiplayer(
      {Key? key, required this.userProvider, required this.socketService})
      : super(key: key);

  @override
  MultiplayerState createState() => MultiplayerState();
}

class MultiplayerState extends State<Multiplayer> {
  late bool isWait;
  late bool triangleIsVisible;
  late QuestionsService questionsService;
  int currentQuestionIndex = 0;
  late String opponentAnswer = '';
  late String userAnswer = '';

  // void updateState(
  //     {bool incrementIndexAction = false,
  //     bool resetIndexAction = false,
  //     int newIndex = 0,
  //     bool? shuffleAnswersAction,
  //     String opponent = '',
  //     String answer = ''}) {
  //   setState(() {
  //     if (incrementIndexAction) {
  //       currentQuestionIndex++;
  //     } else if (resetIndexAction) {
  //       currentQuestionIndex = 0;
  //     } else if (opponent.isNotEmpty) {
  //       opponentAnswer = opponent;
  //     } else if (userAnswer.isNotEmpty) {
  //       userAnswer = answer;
  //     } else {
  //       currentQuestionIndex = newIndex;
  //     }
  //   });
  // }

  void setIndex(int newIndex) {
    setState(() {
      currentQuestionIndex = newIndex;
    });
  }

  void setAnswer({String? user, String? opponent}) {
    setState(() {
      if (user != null) userAnswer = user;
      if (opponent != null) opponentAnswer = opponent;
    });
  }

  @override
  void initState() {
    super.initState();
    isWait = true;
    triangleIsVisible = false;
    if (widget.userProvider.userModel.multiplayer.isConnected) {
      widget.socketService.emitStart();
    }

    questionsService = QuestionsService(
      context: context,
      onLoadingStateChanged: (bool loading) {
        if (mounted) {
          setState(() {
            triangleIsVisible = !triangleIsVisible;
          });
        }
      },
      userProvider: widget.userProvider,
      index: currentQuestionIndex,
    );

    loadQuestions();
  }

  void loadQuestions() async {
    final multiplayer = widget.userProvider.userModel.multiplayer;
    if (multiplayer.isConnected && multiplayer.opponentAvailable) {
      await questionsService.loadQuestions(
          tournament: multiplayer.opponent.round);
      return;
    }

    questionsService.loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    if (questionsService.questions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final currentQuestion = questionsService.questions[currentQuestionIndex];
    return SizedBox(
        width: screenWidth(context),
        height: screenHeight(context),
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    QuestionsAssets(userProvider: widget.userProvider),
                    QuestionContainer(question: currentQuestion['body']),
                    AnswerContainer(
                      isTournament: true,
                      currentQuestion: currentQuestion,
                      questionsService: questionsService,
                      currentQuestionIndex: currentQuestionIndex,
                      userProvider: widget.userProvider,
                      setIndex: setIndex,
                      setAnswer: setAnswer,
                      socketService: widget.socketService,
                      opponentAnswer: opponentAnswer,
                    )
                  ],
                ),
              ),
              Triangle(
                isVisible: triangleIsVisible,
                left: true,
                username: widget.userProvider.userModel.username,
                points: currentQuestionIndex == 0
                    ? widget.userProvider.userModel.success.points
                    : widget.userProvider.userModel.multiplayer.score,
              ),
              Triangle(
                isVisible: triangleIsVisible,
                left: false,
                username:
                    widget.userProvider.userModel.multiplayer.opponent.username,
                points: currentQuestionIndex == 0
                    ? widget.userProvider.userModel.multiplayer.opponent.points
                    : widget.userProvider.userModel.multiplayer.opponentScore,
              ),
              CountdownTimer(
                userProvider: widget.userProvider,
                initialSeconds: 15,
                eventText: 'Sacekajte protivnika...',
                isVisible: isWait,
                onTimerFinish: () {
                  Future.delayed(const Duration(milliseconds: 300), () {
                    setState(() {
                      isWait = !isWait;
                    });
                  });
                  setState(() {
                    triangleIsVisible = true;
                  });

                  Future.delayed(const Duration(seconds: 3), () {
                    setState(() {
                      triangleIsVisible = false;
                    });
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () => setState(() {
                        triangleIsVisible = !triangleIsVisible;
                      }),
                  child: const Text('press')),
            ],
          ),
        ));
  }
}
