import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/shared/animations/entrance_transition.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MenuButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntranceTransition(
      width: MediaQuery.of(context).size.width * 0.2,
      delay: const Duration(seconds: 1),
      offsetX: 200.0,
      offsetY: 100.0,
      initialX: 0.0,
      initialY: 0.0,
      offsetXPercentage: 0.1,
      offsetYPercentage: 0.0,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.menu,
              size: 35,
              color: Color(0xFF793EA5),
            ),
          ),
        ),
      ),
    );
  }
}
