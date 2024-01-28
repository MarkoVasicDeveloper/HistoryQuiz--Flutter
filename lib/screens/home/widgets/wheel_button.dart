import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/core/shared/animations/entrance_transition.dart';
import 'package:istorija_srbije/core/shared/animations/pulsating.dart';

class WheelButton extends StatelessWidget {
  const WheelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntranceTransition(
      width: screenWidth(context) * 0.2,
      delay: const Duration(seconds: 1),
      fadeIn: true,
      offsetX: -100.0,
      offsetY: 0.0,
      initialX: 0.0,
      initialY: 0.0,
      offsetXPercentage: 0.06,
      offsetYPercentage: -0.04,
      child: Pulsating(
        child: SizedBox(
          width: screenWidth(context) * 0.2,
          height: screenHeight(context) * 0.05,
          child: ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/wheel'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(1.0),
            ),
            child: Text('Zavrti',
                style: TextStyle(fontSize: screenWidth(context) * 0.04)),
          ),
        ),
      ),
    );
  }
}
