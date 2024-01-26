import 'package:flutter/material.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/home/widgets/header.dart';
import 'package:istorija_srbije/screens/home/widgets/home_img.dart';
import 'package:istorija_srbije/screens/home/widgets/home_title.dart';
import 'package:istorija_srbije/screens/home/widgets/menu/menu.dart';
import 'package:istorija_srbije/screens/home/widgets/navigate_button.dart';
import 'package:istorija_srbije/screens/home/widgets/username_input.dart';

class HomeScreen extends StatefulWidget {
  final UserProvider userProvider;

  const HomeScreen({Key? key, required this.userProvider}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  bool isMenuOpen = false;
  bool isRotatedComponentVisible = false;

  @override
  void initState() {
    super.initState();

    if (widget.userProvider.userModel.freeSpin) {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamed(context, '/wheel');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userProvider.userModel.username.isEmpty) {
      return Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            showUsernameInputDialog(context, widget.userProvider);
          },
          child: const Text('Unesite username'),
        ),
      );
    }

    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          left: isMenuOpen ? 240.0 : 0.0,
          top: isMenuOpen ? 30.0 : 0.0,
          right: isMenuOpen ? -300.0 : 0.0,
          bottom: 0.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Header(
                userProvider: widget.userProvider,
                onMenu: () => setState(() {
                  isMenuOpen = !isMenuOpen;
                }),
                onRotate: () => setState(() {
                  isRotatedComponentVisible = !isRotatedComponentVisible;
                }),
              ),
              const HomeTitle(),
              const HomeImg(),
              NavigateButton(
                  onPress: () => Navigator.pushNamed(context, '/questions'),
                  title: 'Pocni kviz'),
            ],
          ),
        ),
        Menu(userProvider: widget.userProvider, isMenuOpen: isMenuOpen)
      ],
    );
  }
}
