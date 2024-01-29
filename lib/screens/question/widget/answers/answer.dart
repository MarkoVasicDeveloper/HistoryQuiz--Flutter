import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';

class Answer extends StatelessWidget {
  final String answer;
  final VoidCallback callback;

  const Answer({Key? key, required this.answer, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
