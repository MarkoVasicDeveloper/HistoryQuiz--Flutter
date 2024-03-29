import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/difficulty_points.dart';
import 'package:istorija_srbije/core/shared/widget/offer/diamond_heart_offer.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/question/service/help_service.dart';
import 'package:istorija_srbije/screens/question/service/question_service.dart';
import 'package:istorija_srbije/screens/question/service/shuffle.dart';
import 'package:istorija_srbije/screens/question/widget/answers/answers_container.dart';
import 'package:istorija_srbije/screens/question/widget/help/help_button.dart';
import 'package:istorija_srbije/screens/question/widget/question_asset.dart';
import 'package:istorija_srbije/screens/question/widget/question_container.dart';

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
  final offer = const DiamondsHeartsOffer();

  void setIndex(int newIndex) {
    setState(() {
      currentQuestionIndex = newIndex;
    });
  }

  void shuffle() {
    setState(() {
      shuffleAnswers(questionsService.questions[currentQuestionIndex]);
    });
  }

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
    final points = difficultyPoints[currentQuestion['moderate']].toString();
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 8.0),
        child: Column(
          children: [
            QuestionsAssets(userProvider: widget.userProvider),
            QuestionContainer(question: currentQuestion['body']),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HelpButton(
                    text: '50/50',
                    right: null,
                    onTap: () => fifty(currentQuestion, widget.userProvider,
                        offer, context, shuffle),
                    icon: Icons.filter_2_rounded,
                    img: 'assets/diamond.png'),
                Text(
                  points,
                  style: TextStyle(
                      color: getColor(points),
                      fontStyle: FontStyle.italic,
                      fontSize: 28,
                      fontWeight: FontWeight.w900),
                ),
                HelpButton(
                    text: 'PRESKOCI',
                    left: null,
                    onTap: () => jump(widget.userProvider, offer, context,
                        currentQuestionIndex, questionsService, setIndex),
                    icon: Icons.skip_next_rounded,
                    img: 'assets/diamond.png')
              ],
            ),
            AnswerContainer(
                currentQuestion: currentQuestion,
                questionsService: questionsService,
                currentQuestionIndex: currentQuestionIndex,
                userProvider: widget.userProvider,
                setIndex: setIndex)
          ],
        ),
      ),
    );
  }
}
