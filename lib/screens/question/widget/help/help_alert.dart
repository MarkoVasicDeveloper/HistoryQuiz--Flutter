import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';

class HelpAlert {
  static void showAlertDialog({
    required BuildContext context,
    required VoidCallback onPress,
    required String icon,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Da li ste sigurni?',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: screenWidth(context) * 0.06),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Izgubićete: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth(context) * 0.05)),
                  Text(
                    '1',
                    style: TextStyle(
                      color: const Color(0xFF793EA5),
                      fontSize: screenWidth(context) * 0.06,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Image.asset(icon),
                ],
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPress,
                    child: Text('Ok',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: screenWidth(context) * 0.04)),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Nazad',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: screenWidth(context) * 0.04)),
                  ),
                ),
              ],
            )
          ],
          backgroundColor: Colors.black87,
        );
      },
    );
  }
}
