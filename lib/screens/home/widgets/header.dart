import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/shared/widget/asset.dart';
import 'package:istorija_srbije/core/shared/widget/menu_button.dart';
import 'package:istorija_srbije/screens/home/widgets/wheel_button.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';

class Header extends StatelessWidget {
  final UserProvider userProvider;
  final VoidCallback onMenu;
  final VoidCallback onRotate;

  const Header(
      {super.key,
      required this.userProvider,
      required this.onMenu,
      required this.onRotate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MenuButton(onPressed: onMenu),
        Asset(icon: 'heart.png', number: userProvider.userModel.hearts),
        Asset(icon: 'diamond.png', number: userProvider.userModel.diamonds),
        const WheelButton(),
      ],
    );
  }
}
