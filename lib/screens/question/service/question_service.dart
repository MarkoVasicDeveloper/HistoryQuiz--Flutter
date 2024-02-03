import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/error/load_file_error.dart';
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

  Future<Object> loadFile(int number) async {
    final String roundFileName = 'question$number.json';
    try {
      final String rawJson = await DefaultAssetBundle.of(context)
          .loadString('assets/questions/$roundFileName');

      final List<dynamic> questionsList = json.decode(rawJson);
      return questionsList.cast<Map<String, dynamic>>();
    } catch (e) {
      return LoadFileError(message: 'File doesn`t exist', statusCode: -1000);
    }
  }

  Future<void> loadQuestions({int? tournament}) async {
    final data = await loadFile(tournament ?? userProvider.userModel.round);
    if (data is LoadFileError) {
      questions = [];
      index = 0;
      userProvider.setRound(0);
      await loadQuestions(
          tournament: tournament ?? userProvider.userModel.round);
      return;
    }

    questions = data as List<Map<String, dynamic>>;
    index = 0;
    userProvider.setRound(null);

    onLoadingStateChanged(false);
  }
}
