import 'package:flutter/material.dart';

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
          title: const Text(
            'Da li ste sigurni?',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Izgubićete: ',
                      style: TextStyle(color: Colors.white)),
                  const Text(
                    '1',
                    style: TextStyle(
                      color: Color(0xFF793EA5),
                      fontSize: 24,
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
                    child: const Text('Ok',
                        style: TextStyle(fontWeight: FontWeight.w900)),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Nazad',
                        style: TextStyle(fontWeight: FontWeight.w900)),
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
