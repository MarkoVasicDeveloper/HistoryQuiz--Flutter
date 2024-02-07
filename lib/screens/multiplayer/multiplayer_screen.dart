import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/multiplayer/widget/countdown_timer.dart';
import 'package:istorija_srbije/screens/multiplayer/widget/triangle.dart';
import 'package:istorija_srbije/screens/question/service/question_service.dart';
import 'package:istorija_srbije/screens/question/service/shuffle.dart';
import 'package:istorija_srbije/screens/question/widget/answers/answers_container.dart';
import 'package:istorija_srbije/screens/question/widget/question_asset.dart';
import 'package:istorija_srbije/screens/question/widget/question_container.dart';

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
  int currentQuestionIndex = 0;

  void updateState({
    bool shuffleAnswersAction = false,
    bool incrementIndexAction = false,
    bool resetIndexAction = false,
    int newIndex = 0,
  }) {
    setState(() {
      if (shuffleAnswersAction) {
        shuffleAnswers(questionsService.questions[currentQuestionIndex]);
      } else if (incrementIndexAction) {
        currentQuestionIndex++;
      } else if (resetIndexAction) {
        currentQuestionIndex = 0;
      } else {
        currentQuestionIndex = newIndex;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    isWait = true;
    triangleIsVisible = false;

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
                        currentQuestion: currentQuestion,
                        questionsService: questionsService,
                        currentQuestionIndex: currentQuestionIndex,
                        userProvider: widget.userProvider,
                        updateState: updateState)
                  ],
                ),
              ),
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
          ),
        ));
  }
}
