import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/shared/animations/scaling.dart';

class HomeImg extends StatelessWidget {
  const HomeImg({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      child: Scaling(
        targetWidth: 50.0,
        targetHeight: 50.0,
        delay: const Duration(milliseconds: 2000),
        duration: const Duration(milliseconds: 1000),
        child: Image.asset('assets/warrior.png'),
      ),
    );
  }
}
