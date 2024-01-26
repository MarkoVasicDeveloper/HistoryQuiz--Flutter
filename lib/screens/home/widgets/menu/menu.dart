import 'package:flutter/material.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/home/widgets/menu/volume_slider.dart';

class Menu extends StatelessWidget {
  final UserProvider userProvider;
  final bool isMenuOpen;

  const Menu({super.key, required this.userProvider, required this.isMenuOpen});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      left: isMenuOpen ? 0.0 : -240.0,
      top: 0.0,
      bottom: 0.0,
      child: SizedBox(
        width: 240,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 20.0, 0.0, 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Username',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontFamily: 'RubikDoodleShadow'),
              ),
              Text(
                userProvider.userModel.username,
                style: const TextStyle(
                    fontSize: 24,
                    color: Color(0xFF793EA5),
                    decoration: TextDecoration.none,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'ShantellSans'),
              ),
              const Text(
                'Zvuk',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontFamily: 'RubikDoodleShadow'),
              ),
              VolumeSlider(userProvider: userProvider)
            ],
          ),
        ),
      ),
    );
  }
}
