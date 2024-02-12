import 'dart:math';

import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/multiplayer/service/socket_service.dart';
import 'package:istorija_srbije/screens/question/service/question_service.dart';

Future<int> checkTournamentAnswer(
    Map<String, dynamic> currentQuestion,
    UserProvider userProvider,
    String userAnswer,
    int currentQuestionsIndex,
    QuestionsService loadQuestions,
    final Function({String? user, String? opponent}) setState,
    SocketService socketService,
    final Function(bool triangle) setTriangle) async {
  final multiplayer = userProvider.userModel.multiplayer;
  final isConnected = multiplayer.isConnected;
  final opponentAvailable = multiplayer.opponentAvailable;
  final score = multiplayer.score;
  final opponentScore = multiplayer.opponentScore;

  if (isConnected && opponentAvailable) socketService.emitAnswer(userAnswer);

  if (userAnswer == currentQuestion['correctAnswer']) {
    userProvider.setScore();
  }

  setState(user: userAnswer);

  if (!isConnected || !opponentAvailable) {
    List<dynamic> allAnswers = currentQuestion['answers'];
    String opponentAnswer = allAnswers[Random().nextInt(4)];

    if (opponentAnswer == currentQuestion['correctAnswer']) {
      userProvider.setOpponentScore();
    }

    await Future.delayed(const Duration(seconds: 2), () {
      setState(opponent: opponentAnswer);
    });

    if (currentQuestionsIndex == loadQuestions.questions.length - 1) {
      await Future.delayed(const Duration(seconds: 2), () {
        loadQuestions.loadQuestions();
        return 0;
      });
    }

    await Future.delayed(const Duration(seconds: 2));
    setTriangle(true);

    if (currentQuestionsIndex == loadQuestions.questions.length - 1) {
      if (score == opponentScore) {
        loadQuestions.loadQuestions();
        // draw
        return 0;
      }

      // win/lose
    }

    Future.delayed(const Duration(seconds: 3), () {
      setTriangle(false);
    });

    return ++currentQuestionsIndex;
  }

  return -1;
}
