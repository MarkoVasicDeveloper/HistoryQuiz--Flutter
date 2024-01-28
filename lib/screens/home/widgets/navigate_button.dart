import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/core/shared/animations/entrance_transition.dart';

class NavigateButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;

  const NavigateButton({super.key, required this.onPress, required this.title});

  @override
  Widget build(BuildContext context) {
    return EntranceTransition(
      width: screenWidth(context) * 0.7,
      delay: const Duration(seconds: 1),
      offsetY: -100.0,
      initialY: -10.0,
      offsetXPercentage: 0.5,
      child: SizedBox(
        width: screenWidth(context) * 0.7,
        child: ElevatedButton(
          onPressed: onPress,
          child: Text(
            title,
            style: TextStyle(fontSize: screenWidth(context) * 0.05),
          ),
        ),
      ),
    );
  }
}
