import 'dart:math';

import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/multiplayer/service/socket_service.dart';
import 'package:istorija_srbije/screens/question/service/question_service.dart';

int checkTournamentAnswer(
    Map<String, dynamic> currentQuestion,
    UserProvider userProvider,
    String userAnswer,
    int currentQuestionsIndex,
    QuestionsService loadQuestions,
    SocketService socketService) {
  final isConnected = userProvider.userModel.multiplayer.isConnected;
  final opponentAvailable =
      userProvider.userModel.multiplayer.opponentAvailable;

  if (isConnected && opponentAvailable) socketService.emitAnswer(userAnswer);

  if (userAnswer == currentQuestion['correctAnswer']) {
    userProvider.setScore();
  }

  userProvider.setCurrentAnswer(userAnswer);

  if (!isConnected || !opponentAvailable) {
    List<dynamic> allAnswers = currentQuestion['answers'];
    String opponentAnswer = allAnswers[Random().nextInt(4)];

    if (opponentAnswer == currentQuestion['correctAnswer']) {
      userProvider.setOpponentScore();
    }

    userProvider.setOpponentCurrentAnswer(opponentAnswer);

    if (currentQuestionsIndex == loadQuestions.questions.length - 1) {
      loadQuestions.loadQuestions();
      return 0;
    }

    return ++currentQuestionsIndex;
  }

  return -1;
}
