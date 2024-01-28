import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';

class SpinButton extends StatelessWidget {
  final bool isSpinning;
  final VoidCallback onPressed;

  const SpinButton({
    required this.isSpinning,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  String calculateTimeRemaining() {
    DateTime now = DateTime.now();
    DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1);

    Duration remainingTime = nextMidnight.difference(now);

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    int hours = remainingTime.inHours;
    int minutes = remainingTime.inMinutes.remainder(60);
    int seconds = remainingTime.inSeconds.remainder(60);

    return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    return isSpinning
        ? ElevatedButton(
            onPressed: onPressed,
            child: Text('Zavrti',
                style: TextStyle(fontSize: screenWidth(context) * 0.05)),
          )
        : Column(
            children: [
              Text(
                'Sledeci slobodan krug: ',
                style: TextStyle(
                    fontSize: screenWidth(context) * 0.04,
                    decoration: TextDecoration.none,
                    color: const Color(0xFF793EA5)),
              ),
              const SizedBox(width: 5, height: 5),
              Text(
                calculateTimeRemaining(),
                style: TextStyle(
                    fontSize: screenWidth(context) * 0.05,
                    decoration: TextDecoration.none,
                    color: const Color(0xFF793EA5),
                    fontStyle: FontStyle.italic),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/home'),
                child: Text(
                  'Nazad',
                  style: TextStyle(fontSize: screenWidth(context) * 0.05),
                ),
              )
            ],
          );
  }
}
