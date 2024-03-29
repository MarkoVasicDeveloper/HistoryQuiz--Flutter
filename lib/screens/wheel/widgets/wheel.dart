import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:istorija_srbije/core/constant/fortune_items.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';
import 'package:istorija_srbije/screens/wheel/widgets/congratilation.dart';
import 'package:istorija_srbije/screens/wheel/widgets/fortune_item_comp.dart';

class Wheel extends StatefulWidget {
  final Stream<int> controller;
  final UserProvider userProvider;

  const Wheel({Key? key, required this.controller, required this.userProvider})
      : super(key: key);

  @override
  WheelState createState() => WheelState();
}

class WheelState extends State<Wheel> {
  List<Items> items = Items.getItems();
  int item = 0;

  @override
  void initState() {
    super.initState();

    widget.controller.listen((int currentPosition) {
      int current = currentPosition + 3 >= items.length
          ? currentPosition - items.length + 3
          : currentPosition + 3;

      setState(() {
        item = current;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenWidth(context) * 0.95,
            maxHeight: screenHeight(context) * 0.6,
          ),
          child: FortuneWheel(
            alignment: Alignment.bottomLeft,
            selected: widget.controller,
            animateFirst: false,
            onAnimationEnd: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Congratilation(
                      item: items[item],
                      userProvider: widget.userProvider,
                    );
                  });
            },
            indicators: [
              FortuneIndicator(
                  alignment: Alignment.topCenter,
                  child: TriangleIndicator(
                    color: Colors.red.shade400,
                  ))
            ],
            items: [
              for (var i = 0; i < items.length; i++)
                FortuneItemComp(context, item: items[i], counter: i)
            ],
          ),
        ),
      ],
    );
  }
}
