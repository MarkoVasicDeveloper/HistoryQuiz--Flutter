import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/shared/widget/background_wrapper.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/question/service/question_service.dart';
import 'package:istorija_srbije/screens/question/widget/help/help_button.dart';
import 'package:istorija_srbije/screens/question/widget/question_asset.dart';

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

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
      ),
      body: BackgroundWrapper(
        colorFilter: ColorFilter.mode(
          Colors.black54.withOpacity(0.9),
          BlendMode.multiply,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 8.0),
          child: Column(
            children: [
              QuestionsAssets(userProvider: widget.userProvider),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HelpButton(
                      text: '50/50',
                      right: null,
                      onTap: () {},
                      icon: Icons.filter_2_rounded,
                      img: 'assets/diamond.png'),
                  HelpButton(
                      text: 'PRESKOCI',
                      left: null,
                      onTap: () {},
                      icon: Icons.skip_next_rounded,
                      img: 'assets/diamond.png')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
