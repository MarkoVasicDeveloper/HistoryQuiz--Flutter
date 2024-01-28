import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/core/shared/animations/scaling.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Scaling(
            targetWidth: 50.0,
            targetHeight: 50.0,
            delay: const Duration(milliseconds: 1500),
            duration: const Duration(milliseconds: 1000),
            child: Text(
              'Istorija Srbije',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF793EA5),
                decoration: TextDecoration.none,
                fontSize: screenWidth(context) * 0.09,
                fontFamily: 'RubikDoodleShadow',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
