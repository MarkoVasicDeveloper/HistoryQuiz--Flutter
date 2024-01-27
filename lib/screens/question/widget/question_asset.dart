import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/shared/widget/asset.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';

class QuestionsAssets extends StatelessWidget {
  final UserProvider userProvider;

  const QuestionsAssets({super.key, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    final userModel = userProvider.userModel;
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: SizedBox(
        height: 30,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Asset(icon: 'heart.png', number: userModel.hearts),
            Asset(icon: 'star.png', number: userModel.success.points),
            Asset(icon: 'diamond.png', number: userModel.diamonds),
          ],
        ),
      ),
    );
  }
}
