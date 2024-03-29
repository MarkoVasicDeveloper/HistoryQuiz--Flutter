import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';

class InRowAnimation {
  static OverlayEntry createInRowAnimation({
    required BuildContext context,
    required int row,
  }) {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/animation1.gif'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.black),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'WoW! ${row * 5} u nizu!',
                    style: TextStyle(
                      color: const Color(0xFF793EA5),
                      decoration: TextDecoration.none,
                      fontSize: screenWidth(context) * 0.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Osvojili ste: ',
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: screenWidth(context) * 0.08),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${row.toString()}x ',
                        style: TextStyle(
                          color: const Color(0xFF793EA5),
                          fontSize: screenWidth(context) * 0.09,
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Image.asset('assets/heart.png'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showOverlayInRow({
    required BuildContext context,
    required int row,
  }) async {
    final overlayEntry = createInRowAnimation(context: context, row: row);

    Overlay.of(context).insert(overlayEntry);

    await Future.delayed(const Duration(milliseconds: 4000));

    overlayEntry.remove();
  }
}
