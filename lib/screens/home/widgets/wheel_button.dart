import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/shared/animations/entrance_transition.dart';
import 'package:istorija_srbije/core/shared/animations/pulsating.dart';

class WheelButton extends StatelessWidget {
  const WheelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntranceTransition(
      width: MediaQuery.of(context).size.width * 0.2,
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
          width: MediaQuery.of(context).size.width * 0.2,
          height: 20,
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/wheel'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(1.0),
            ),
            child: const Text('Zavrti', style: TextStyle(fontSize: 12)),
          ),
        ),
      ),
    );
  }
}
