import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:istorija_srbije/core/constant/difficulty_points.dart';
import 'package:istorija_srbije/core/constant/sound.dart';
import 'package:istorija_srbije/core/global/audio_player.dart';
import 'package:istorija_srbije/core/shared/animations/answer.dart';
import 'package:istorija_srbije/core/shared/animations/in_row.dart';
import 'package:istorija_srbije/core/shared/widget/interesting_facts.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/question/service/question_service.dart';

Future<int> checkAnswer(answer, context, QuestionsService loadQuestions,
    currentQuestionIndex, UserProvider userProvider) async {
  final question = loadQuestions.questions[currentQuestionIndex];
  int points = difficultyPoints[question['moderate']] ?? 0;

  final correctAnswer = question['correctAnswer'];
  final hearts = userProvider.userModel.hearts;
  final currentInRow = userProvider.userModel.success.currentInRow;
  userProvider.setSuccessTotal();

  if (correctAnswer == answer) {
    userProvider.setSuccessCorrect();
    userProvider.setCurrentInRow(false);
    userProvider.setPoints(points);

    final sound = (currentInRow + 1) % 5 == 0 && currentInRow != 0
        ? AssetSource(applausePath)
        : AssetSource(correctAnswerPath);
    AudioPlayerSingleton().audioPlayer.play(sound);

    if ((currentInRow + 1) % 5 == 0 && currentInRow != 0) {
      await InRowAnimation.showOverlayInRow(
          context: context, row: ((currentInRow + 1) / 5) ~/ 1);
      userProvider.setHearts((hearts + (currentInRow + 1) / 5) ~/ 1, null);
    } else {
      await AnswerAnimation.showOverlay(
        correct: correctAnswer == answer,
        context: context,
      );
    }
  } else {
    userProvider.setSuccessWrong();
    userProvider.setCurrentInRow(true);

    Vibrate.vibrate();
    AudioPlayerSingleton().audioPlayer.play(AssetSource(wrongAnswerPath));

    await AnswerAnimation.showOverlay(
      correct: correctAnswer == answer,
      context: context,
    );

    userProvider.setHearts(hearts - 1, () async {
      await Future.delayed(const Duration(milliseconds: 1730));
      Navigator.pushReplacementNamed(context, '/home');
    });
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return InterestingFacts(
        imageUrl: question['imageUrl'] ?? '',
        text: question['description'] ?? '',
      );
    },
  );

  if (currentQuestionIndex == loadQuestions.questions.length - 1) {
    loadQuestions.loadQuestions();
    return 0;
  }

  return ++currentQuestionIndex;
}
