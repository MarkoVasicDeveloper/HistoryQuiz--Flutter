import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/global/audio_player.dart';
import 'package:istorija_srbije/core/shared/widget/offer/diamond_heart_offer.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/question/service/question_service.dart';
import 'package:istorija_srbije/screens/question/widget/help/help_alert.dart';

void fifty(Map<String, dynamic> currentQuestion, UserProvider userProvider,
    DiamondsHeartsOffer offer, BuildContext context, Function shuffle) {
  if (currentQuestion['answers'].length == 2) {
    return;
  }
  if (userProvider.userModel.diamonds == 0) {
    return offer.showDiamondsHeartsOffer(context);
  }
  AudioPlayerSingleton().audioPlayer.play(AssetSource("sounds/help.m4a"));
  HelpAlert.showAlertDialog(
      context: context,
      icon: 'assets/diamond.png',
      onPress: () {
        int newDiamonds = userProvider.userModel.diamonds - 1;
        shuffle();
        userProvider.setDiamonds(newDiamonds);
        Navigator.of(context).pop();
      });
}

void jump(
    UserProvider userProvider,
    DiamondsHeartsOffer offer,
    BuildContext context,
    int currentQuestionIndex,
    QuestionsService questionsService,
    Function setIndex) {
  if (userProvider.userModel.diamonds == 0) {
    return offer.showDiamondsHeartsOffer(context);
  }
  AudioPlayerSingleton().audioPlayer.play(AssetSource("sounds/help.m4a"));
  HelpAlert.showAlertDialog(
    context: context,
    onPress: () {
      int newDiamonds = userProvider.userModel.diamonds - 1;
      userProvider.setDiamonds(newDiamonds);
      if (currentQuestionIndex == 4) {
        questionsService.loadQuestions();
        setIndex(currentQuestionIndex = 0);
        return Navigator.of(context).pop();
      }
      setIndex(currentQuestionIndex = ++currentQuestionIndex);
      Navigator.of(context).pop();
    },
    icon: 'assets/diamond.png',
  );
}

Color getColor(String points) {
  switch (points) {
    case '5':
      return Colors.white;
    case '10':
      return Colors.amber;
    case '15':
      return Colors.red;
    default:
      return Colors.white;
  }
}
