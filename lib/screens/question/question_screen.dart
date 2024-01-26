import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/global/audio_player.dart';
import 'package:istorija_srbije/core/shared/widget/background_wrapper.dart';
import 'package:istorija_srbije/core/shared/widget/diamond_heart_offer.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/question/service/question_service.dart';
import 'package:istorija_srbije/screens/question/service/shuffle.dart';
import 'package:istorija_srbije/screens/question/widget/answers/answers_container.dart';
import 'package:istorija_srbije/screens/question/widget/help/help_alert.dart';
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

  void updateState({
    bool shuffleAnswersAction = false,
    bool incrementIndexAction = false,
    bool resetIndexAction = false,
    int newIndex = 0,
  }) {
    setState(() {
      if (shuffleAnswersAction) {
        shuffleAnswers(questionsService.questions[currentQuestionIndex]);
      } else if (incrementIndexAction) {
        currentQuestionIndex++;
      } else if (resetIndexAction) {
        currentQuestionIndex = 0;
      } else {
        currentQuestionIndex = newIndex;
      }
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
              QuestionContainer(question: currentQuestion['body']),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HelpButton(
                      text: '50/50',
                      right: null,
                      onTap: fifty,
                      icon: Icons.filter_2_rounded,
                      img: 'assets/diamond.png'),
                  HelpButton(
                      text: 'PRESKOCI',
                      left: null,
                      onTap: jump,
                      icon: Icons.skip_next_rounded,
                      img: 'assets/diamond.png')
                ],
              ),
              AnswerContainer(
                  currentQuestion: currentQuestion,
                  questionsService: questionsService,
                  currentQuestionIndex: currentQuestionIndex,
                  userProvider: widget.userProvider,
                  updateState: updateState)
            ],
          ),
        ),
      ),
    );
  }

  void fifty() {
    final currentQuestion = questionsService.questions[currentQuestionIndex];
    if (currentQuestion['answers'].length == 2) {
      return;
    }
    if (widget.userProvider.userModel.diamonds == 0) {
      return offer.showDiamondsHeartsOffer(context);
    }
    AudioPlayerSingleton().audioPlayer.play(AssetSource("sounds/help.m4a"));
    HelpAlert.showAlertDialog(
        context: context,
        icon: 'assets/diamond.png',
        onPress: () {
          int newDiamonds = widget.userProvider.userModel.diamonds - 1;
          updateState(shuffleAnswersAction: true);
          widget.userProvider.setDiamonds(newDiamonds);
          Navigator.of(context).pop();
        });
  }

  void jump() {
    if (widget.userProvider.userModel.diamonds == 0) {
      return offer.showDiamondsHeartsOffer(context);
    }
    AudioPlayerSingleton().audioPlayer.play(AssetSource("sounds/help.m4a"));
    HelpAlert.showAlertDialog(
      context: context,
      onPress: () {
        int newDiamonds = widget.userProvider.userModel.diamonds - 1;
        if (currentQuestionIndex == 4) {
          widget.userProvider.setDiamonds(newDiamonds);
          questionsService.loadQuestions();
          updateState(resetIndexAction: true);
          return Navigator.of(context).pop();
        }
        widget.userProvider.setDiamonds(newDiamonds);
        updateState(incrementIndexAction: true);
        Navigator.of(context).pop();
      },
      icon: 'assets/diamond.png',
    );
  }
}
