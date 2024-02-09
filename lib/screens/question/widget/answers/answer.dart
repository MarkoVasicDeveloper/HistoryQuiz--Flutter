import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';

class Answer extends StatefulWidget {
  final String answer;
  final VoidCallback callback;
  final String opponentAnswer;

  const Answer(
      {super.key,
      required this.answer,
      required this.callback,
      required this.opponentAnswer});

  @override
  AnswerState createState() => AnswerState();
}

class AnswerState extends State<Answer> {
  late Color color;

  @override
  void initState() {
    super.initState();
    color = const Color(0x66793EA5);
  }

  @override
  void didUpdateWidget(covariant Answer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.answer != oldWidget.answer) {
      setState(() {
        color = const Color(0x66793EA5);
      });
    }

    if (widget.opponentAnswer != oldWidget.opponentAnswer) {
      setState(() {
        color = const Color.fromARGB(255, 235, 93, 93);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: widget.callback,
        onTapUp: (_) {
          setState(() {
            color = Colors.greenAccent;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: color,
              border: const Border(
                bottom: BorderSide(color: Colors.black, width: 2),
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              widget.answer,
              style: TextStyle(
                  fontSize: screenHeight(context) * 0.04,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
    );
  }
}
