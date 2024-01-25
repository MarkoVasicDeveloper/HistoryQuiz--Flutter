import 'package:flutter/material.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget child;
  final ColorFilter? colorFilter;

  const BackgroundWrapper({
    Key? key,
    required this.child,
    this.colorFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/stefan_nemanja.jpg'),
          fit: BoxFit.cover,
          colorFilter: colorFilter,
        ),
      ),
      child: child,
    );
  }
}
