import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:istorija_srbije/core/constant/fortune_items.dart';
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
              const SizedBox(height: 40, width: 40),
              Transform.rotate(
                angle: 90 * (3.14 / 180),
                child: Scaling(
                  targetWidth: MediaQuery.of(context).size.width,
                  targetHeight: MediaQuery.of(context).size.height,
                  delay: Duration(milliseconds: 150 + counter * 25),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOutCirc,
                  child: Text(item.number,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          shadows: [
                            Shadow(
                              blurRadius: 0.0,
                              color: Colors.black,
                              offset: Offset(1.0, 1.0),
                            ),
                          ])),
                ),
              ),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              Transform.rotate(
                angle: 90 * (3.14 / 180),
                child: Scaling(
                  targetWidth: MediaQuery.of(context).size.width,
                  targetHeight: MediaQuery.of(context).size.height,
                  delay: Duration(milliseconds: 500 + counter * 25),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCirc,
                  child: Image.asset(item.image),
                ),
              ),
            ],
          ),
        );
}
