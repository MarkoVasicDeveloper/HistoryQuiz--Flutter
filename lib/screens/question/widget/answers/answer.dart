import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answer;
  final VoidCallback callback;

  const Answer({super.key, required this.answer, required this.callback});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: InkWell(
        onTap: callback,
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0x66793EA5),
              border: const Border(
                bottom: BorderSide(color: Colors.black, width: 2),
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              answer,
              style: TextStyle(
                  fontSize: height * 0.04,
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
