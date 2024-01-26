import 'package:flutter/material.dart';

class QuestionContainer extends StatelessWidget {
  final String question;

  const QuestionContainer({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            question,
            style: TextStyle(
                fontSize: height * 0.025,
                decoration: TextDecoration.none,
                color: const Color(0xFF793EA5),
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
            textScaler: const TextScaler.linear(1.5),
          ),
        ),
      ),
    );
  }
}
