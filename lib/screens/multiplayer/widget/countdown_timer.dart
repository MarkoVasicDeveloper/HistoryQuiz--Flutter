import 'dart:async';
import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';

class CountdownTimer extends StatefulWidget {
  final int initialSeconds;
  final Function? onTimerFinish;
  final String eventText;
  final bool isVisible;

  const CountdownTimer({
    Key? key,
    required this.initialSeconds,
    this.onTimerFinish,
    required this.eventText,
    required this.isVisible,
  }) : super(key: key);

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  late int seconds;
  late Timer countdownTimer;

  @override
  void initState() {
    super.initState();
    seconds = widget.initialSeconds;

    if (widget.isVisible) {
      startCountdown();
    }
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds--;

        if (seconds == 0) {
          timer.cancel();
          if (widget.onTimerFinish != null) {
            widget.onTimerFinish!();
          }
        }
      });
    });
  }

  void stopCountdown() {
    countdownTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: widget.isVisible ? 0 : -screenHeight(context),
      left: 0,
      right: 0,
      bottom: widget.isVisible ? 0 : screenHeight(context),
      duration: const Duration(milliseconds: 500),
      child: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.eventText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                decoration: TextDecoration.none,
                color: Color(0xFF793EA5),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              seconds.toString(),
              style: const TextStyle(
                fontSize: 24,
                decoration: TextDecoration.none,
                color: Color(0xFF793EA5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
