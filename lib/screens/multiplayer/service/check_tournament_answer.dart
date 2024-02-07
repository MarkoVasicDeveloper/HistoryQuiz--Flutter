import 'dart:math';

import 'package:istorija_srbije/provider/user/user_provider.dart';

void checkTournamentAnswer(Map<String, dynamic> currentQuestion,
    UserProvider userProvider, String userAnswer) {
  final isConnected = userProvider.userModel.multiplayer.isConnected;
  final opponentAvailable =
      userProvider.userModel.multiplayer.opponentAvailable;

  if (userAnswer == currentQuestion['correctAnswer']) {
    userProvider.setScore();
  }

  userProvider.setCurrentAnswer(userAnswer);

  if (!isConnected || !opponentAvailable) {
    List<String> allAnswers = currentQuestion['answers'];
    String opponentAnswer = allAnswers[Random().nextInt(4)];

    if (opponentAnswer == currentQuestion['correctAnswer']) {
      userProvider.setOpponentScore();
    }

    userProvider.setOpponentCurrentAnswer(opponentAnswer);
  }
}
