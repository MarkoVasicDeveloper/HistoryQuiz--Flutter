import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';

Future<void> showUsernameInputDialog(
    BuildContext context, UserProvider userProvider) async {
  TextEditingController usernameController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Unesite korisničko ime',
          style: TextStyle(
              color: const Color(0xFF793EA5),
              fontSize: screenWidth(context) * 0.06),
          textAlign: TextAlign.center,
        ),
        content: TextField(
          controller: usernameController,
          style: TextStyle(
              color: Colors.white, fontSize: screenWidth(context) * 0.04),
          decoration: InputDecoration(
            hintText: 'Korisničko ime',
            hintStyle: TextStyle(
                color: Colors.white, fontSize: screenWidth(context) * 0.04),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              String username = usernameController.text.trim();
              if (username.isNotEmpty) {
                userProvider.setUsername(username);
                Navigator.pushReplacementNamed(context, '/home');
              }
            },
            child: Text(
              'Potvrdi',
              style: TextStyle(fontSize: screenWidth(context) * 0.05),
            ),
          ),
        ],
        backgroundColor: Colors.black,
      );
    },
  );
}
