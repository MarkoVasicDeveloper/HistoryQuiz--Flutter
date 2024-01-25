import 'package:flutter/material.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';

Future<void> showUsernameInputDialog(
    BuildContext context, UserProvider userProvider) async {
  TextEditingController usernameController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Unesite korisničko ime',
          style: TextStyle(color: Color(0xFF793EA5)),
          textAlign: TextAlign.center,
        ),
        content: TextField(
          controller: usernameController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Korisničko ime',
            hintStyle: TextStyle(color: Colors.white),
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
            child: const Text('Potvrdi'),
          ),
        ],
        backgroundColor: Colors.black,
      );
    },
  );
}
