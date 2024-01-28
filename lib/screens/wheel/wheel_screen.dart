import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/wheel/widgets/spin_button.dart';
import 'package:istorija_srbije/screens/wheel/widgets/wheel.dart';

class WheelScreen extends StatefulWidget {
  final UserProvider userProvider;

  const WheelScreen({Key? key, required this.userProvider}) : super(key: key);

  @override
  WheelScreenState createState() => WheelScreenState();
}

class WheelScreenState extends State<WheelScreen> {
  late StreamController<int> _controller;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<int>.broadcast();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF793EA5), width: 10.0),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth(context) * 0.95,
              maxHeight: screenHeight(context) * 0.6,
            ),
            child: Wheel(
                controller: _controller.stream,
                userProvider: widget.userProvider),
          ),
        ),
        SpinButton(
          isSpinning: widget.userProvider.userModel.freeSpin,
          onPressed: () {
            if (widget.userProvider.userModel.freeSpin) {
              setState(() {
                _controller.add(Random().nextInt(8));
              });
            }
          },
        ),
      ],
    );
  }
}
