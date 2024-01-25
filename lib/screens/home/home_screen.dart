import 'package:flutter/material.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/home/widgets/header.dart';

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
  Widget build(BuildContext context) {
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
