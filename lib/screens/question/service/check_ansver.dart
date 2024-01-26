import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:istorija_srbije/core/constant/difficulty_points.dart';
import 'package:istorija_srbije/core/constant/sound.dart';
import 'package:istorija_srbije/core/global/audio_player.dart';
import 'package:istorija_srbije/core/shared/animations/answer.dart';
import 'package:istorija_srbije/core/shared/animations/in_row.dart';
import 'package:istorija_srbije/core/shared/widget/interesting_facts.dart';

Future<int> checkAnswer(
    answer, context, loadQuestions, currentQuestionIndex, userData) async {
  final question = loadQuestions.questions[currentQuestionIndex];
  int points = difficultyPoints[question['moderate']] ?? 0;

  final correctAnswer = question['correctAnswer'];
  final hearts = userData.userData.hearts;
  final currentInRow = userData.userData.success.currentInRow;
  userData.setSuccessTotal();

  if (correctAnswer == answer) {
    userData.setSuccessCorrect();
    userData.setCurrentInRow(false);
    userData.setPoints(points);

    final sound = (currentInRow + 1) % 5 == 0 && currentInRow != 0
        ? AssetSource(applause)
        : AssetSource(correctAnswer);

    AudioPlayerSingleton().audioPlayer.play(sound);

    if ((currentInRow + 1) % 5 == 0 && currentInRow != 0) {
      await InRowAnimation.showOverlayInRow(
          context: context, row: ((currentInRow + 1) / 5) ~/ 1);
      userData.setHearts(hearts + (currentInRow + 1) / 5, null);
    } else {
      await AnswerAnimation.showOverlay(
        correct: correctAnswer == answer,
        context: context,
      );
    }
  } else {
    userData.setSuccessWrong();
    userData.setCurrentInRow(true);

    Vibrate.vibrate();
    AudioPlayerSingleton().audioPlayer.play(AssetSource(wrongAnswer));

    await AnswerAnimation.showOverlay(
      correct: correctAnswer == answer,
      context: context,
    );

    userData.setHearts(hearts - 1, () async {
      await Future.delayed(const Duration(milliseconds: 1730));
      Navigator.pushReplacementNamed(context, '/home');
    });
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const InterestingFacts(
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Great_serb_migration-sr.png/256px-Great_serb_migration-sr.png',
        text:
            'Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.Neki tekst o pitanju.',
      );
    },
  );

  if (currentQuestionIndex == loadQuestions.questions.length - 1) {
    loadQuestions.loadQuestions();
    return currentQuestionIndex = 0;
  }

  return ++currentQuestionIndex;
}
