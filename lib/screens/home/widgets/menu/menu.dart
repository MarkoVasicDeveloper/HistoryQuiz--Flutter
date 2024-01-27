import 'package:flutter/material.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/home/widgets/menu/notification_slider.dart';
import 'package:istorija_srbije/screens/home/widgets/menu/volume_slider.dart';
import 'package:istorija_srbije/screens/home/widgets/username_input.dart';

class Menu extends StatelessWidget {
  final UserProvider userProvider;
  final bool isMenuOpen;

  const Menu({super.key, required this.userProvider, required this.isMenuOpen});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final fontSize = height * 0.02;
    final bigFontSize = height * 0.03;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      left: isMenuOpen ? 0.0 : -240.0,
      top: 0.0,
      bottom: 0.0,
      child: SizedBox(
        width: 240,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 60.0, 0.0, 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Korisnicko ime:',
                    style: TextStyle(
                        fontSize: bigFontSize,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontFamily: 'ShantellSans'),
                  ),
                  IconButton(
                      onPressed: () =>
                          showUsernameInputDialog(context, userProvider),
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ))
                ],
              ),
              Text(
                userProvider.userModel.username,
                style: TextStyle(
                    fontSize: fontSize,
                    color: const Color(0xFF793EA5),
                    decoration: TextDecoration.none,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'RubikDoodleShadow'),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    'Zvuk:',
                    style: TextStyle(
                        fontSize: bigFontSize,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontFamily: 'ShantellSans'),
                  ),
                ],
              ),
              VolumeSlider(userProvider: userProvider),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    'Obavestenja:',
                    style: TextStyle(
                        fontSize: bigFontSize,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontFamily: 'ShantellSans'),
                  ),
                ],
              ),
              NotificationSlider(userProvider: userProvider),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
