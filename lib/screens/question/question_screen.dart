import 'package:flutter/material.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/question/service/question_service.dart';

class QuestionScreen extends StatefulWidget {
  final UserProvider userProvider;
  const QuestionScreen({Key? key, required this.userProvider})
      : super(key: key);

  @override
  QuestionScreenState createState() => QuestionScreenState();
}

class QuestionScreenState extends State<QuestionScreen> {
  late QuestionsService questionsService;
  bool isLoading = true;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();

    if (widget.userProvider.userModel.hearts <= 0) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/home');
      });
      return;
    }

    questionsService = QuestionsService(
      context: context,
      onLoadingStateChanged: (bool loading) {
        if (mounted) {
          setState(() {
            isLoading = loading;
          });
        }
      },
      userProvider: widget.userProvider,
      index: currentQuestionIndex,
    );

    questionsService.loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    if (questionsService.questions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final currentQuestion = questionsService.questions[currentQuestionIndex];

    // TODO: implement build
    throw UnimplementedError();
  }
}
