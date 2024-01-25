import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';

class QuestionsService {
  final UserProvider userProvider;
  late int index;
  List<Map<String, dynamic>> questions = [];
  final BuildContext context;
  final Function(bool) onLoadingStateChanged;

  QuestionsService({
    required this.onLoadingStateChanged,
    required this.context,
    required this.userProvider,
    required this.index,
  });

  Future<void> loadQuestions() async {
    final String roundFileName = 'question${userProvider.userModel.round}.json';
    try {
      final String rawJson = await DefaultAssetBundle.of(context)
          .loadString('assets/questions/$roundFileName');

      final List<dynamic> questionsList = json.decode(rawJson);
      questions = questionsList.cast<Map<String, dynamic>>();

      index = 0;
      userProvider.setRound(null);
    } catch (e) {
      questions = [];
      index = 0;
      userProvider.setRound(0);
      loadQuestions();
    }

    onLoadingStateChanged(false);
  }
}
