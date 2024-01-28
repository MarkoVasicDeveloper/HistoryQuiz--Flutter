import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:istorija_srbije/core/constant/fortune_items.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/core/shared/animations/scaling.dart';

class FortuneItemComp extends FortuneItem {
  final Items item;
  final int counter;
  final BuildContext context;

  FortuneItemComp(this.context, {required this.item, required this.counter})
      : super(
          style: FortuneItemStyle(
            borderColor: Colors.black26,
            borderWidth: 5.0,
            color: item.color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: screenWidth(context) * 0.11,
                  width: screenWidth(context) * 0.11),
              Transform.rotate(
                angle: 90 * (3.14 / 180),
                child: Scaling(
                  targetWidth: screenWidth(context),
                  targetHeight: screenHeight(context),
                  delay: Duration(milliseconds: 150 + counter * 25),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOutCirc,
                  child: Text(item.number,
                      style: TextStyle(
                          fontSize: screenWidth(context) * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          shadows: const [
                            Shadow(
                              blurRadius: 0.0,
                              color: Colors.black,
                              offset: Offset(1.0, 1.0),
                            ),
                          ])),
                ),
              ),
              SizedBox(
                width: screenWidth(context) * 0.05,
                height: screenWidth(context) * 0.05,
              ),
              Transform.rotate(
                angle: 90 * (3.14 / 180),
                child: Scaling(
                  targetWidth: screenWidth(context),
                  targetHeight: screenHeight(context),
                  delay: Duration(milliseconds: 500 + counter * 25),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCirc,
                  child: Image.asset(
                    item.image,
                    width: screenWidth(context) * 0.15,
                  ),
                ),
              ),
            ],
          ),
        );
}
