import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/models/multiplayer_model.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';

class TournamentResultAnimation {
  static OverlayEntry createOverlayEntry({
    required BuildContext context,
    required MultiplayerModel multiplayer,
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
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage(multiplayer.score > multiplayer.opponentScore
                            ? 'assets/animation1.gif'
                            : multiplayer.score == multiplayer.opponentScore
                                ? 'assets/animation2.gif'
                                : 'assets/wrong.png'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.black),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    multiplayer.score > multiplayer.opponentScore
                        ? 'WoW! Pobeda!'
                        : multiplayer.score == multiplayer.opponentScore
                            ? 'Nereseno! Nova runda!'
                            : 'Vise srece sledeci put!',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${multiplayer.score} : ${multiplayer.opponentScore}',
                        style: TextStyle(
                          color: const Color(0xFF793EA5),
                          fontSize: screenWidth(context) * 0.09,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.none,
                        ),
                      ),
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

  static Future<void> showOverlay(
      {required BuildContext context,
      required UserProvider userProvider}) async {
    final multiplayer = userProvider.userModel.multiplayer;

    final overlayEntry = createOverlayEntry(
      context: context,
      multiplayer: multiplayer,
    );

    Overlay.of(context).insert(overlayEntry);

    await Future.delayed(const Duration(milliseconds: 5000));

    overlayEntry.remove();
  }
}
