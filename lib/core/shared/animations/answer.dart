import 'package:flutter/material.dart';

class AnswerAnimation {
  static OverlayEntry createOverlayEntry({
    required BuildContext context,
    required bool correct,
  }) {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(
                  height: 250,
                  correct ? 'assets/correct.gif' : 'assets/wrong.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          if (correct)
            Positioned(
              top: 40,
              left: 40,
              right: 40,
              bottom: 40,
              child: Material(
                color: Colors.transparent,
                child: Image.asset(
                  'assets/animation1.gif',
                  fit: BoxFit.fill,
                ),
              ),
            ),
        ],
      ),
    );
  }

  static Future<void> showOverlay({
    required BuildContext context,
    required bool correct,
  }) async {
    final overlayEntry = createOverlayEntry(context: context, correct: correct);

    Overlay.of(context).insert(overlayEntry);

    await Future.delayed(const Duration(milliseconds: 1800));

    overlayEntry.remove();
  }
}
