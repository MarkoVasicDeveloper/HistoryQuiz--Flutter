import 'package:flutter/material.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/multiplayer/service/check_tournament_answer.dart';
import 'package:istorija_srbije/screens/multiplayer/service/socket_service.dart';
import 'package:istorija_srbije/screens/question/service/check_answer.dart';
import 'package:istorija_srbije/screens/question/service/question_service.dart';
import 'package:istorija_srbije/screens/question/widget/answers/answer.dart';

class AnswerContainer extends StatelessWidget {
  final Map<String, dynamic> currentQuestion;
  final QuestionsService questionsService;
  final int currentQuestionIndex;
  final UserProvider userProvider;
  final Function(int newIndex) setIndex;
  final Function({String? user, String? opponent})? setAnswer;
  final bool isTournament;
  final SocketService? socketService;
  final String? opponentAnswer;

  const AnswerContainer(
      {super.key,
      required this.currentQuestion,
      required this.questionsService,
      required this.currentQuestionIndex,
      required this.userProvider,
      required this.setIndex,
      this.setAnswer,
      this.isTournament = false,
      this.socketService,
      this.opponentAnswer = ''});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (String answer in currentQuestion['answers'])
              Answer(
                answer: answer,
                callback: () async {
                  if (isTournament) {
                    final tournamentIndex = checkTournamentAnswer(
                        currentQuestion,
                        userProvider,
                        answer,
                        currentQuestionIndex,
                        questionsService,
                        setAnswer!,
                        socketService!);

                    if (tournamentIndex != -1) {
                      setIndex(tournamentIndex);
                    }
                  } else {
                    final index = await checkAnswer(answer.toString(), context,
                        questionsService, currentQuestionIndex, userProvider);
                    setIndex(index);
                  }
                },
                opponentAnswer: '',
              ),
          ],
        ),
      ),
    );
  }
}
