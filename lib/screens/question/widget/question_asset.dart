import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/core/shared/animations/entrance_transition.dart';
import 'package:istorija_srbije/core/shared/widget/asset.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';

class QuestionsAssets extends StatelessWidget {
  final UserProvider userProvider;

  const QuestionsAssets({super.key, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    final userModel = userProvider.userModel;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        EntranceTransition(
          width: screenWidth(context) * 0.3,
          delay: const Duration(seconds: 1),
          offsetX: 0.0,
          offsetY: 100.0,
          initialX: 0.0,
          initialY: 0.0,
          offsetXPercentage: 0.12,
          offsetYPercentage: -0.04,
          child: IconButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              icon: const Icon(Icons.arrow_back)),
        ),
        Asset(icon: 'heart.png', number: userModel.hearts),
        Asset(icon: 'star.png', number: userModel.success.points),
        Asset(icon: 'diamond.png', number: userModel.diamonds),
      ],
    );
  }
}
