import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/fortune_items.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/provider/user/user_provider.dart';

class Congratilation extends StatelessWidget {
  final Items item;
  final UserProvider userProvider;

  const Congratilation(
      {super.key, required this.item, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    final userModel = userProvider.userModel;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/animation1.gif'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        AlertDialog(
          title: Text('Cestitamo!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: screenWidth(context) * 0.09)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Osvojili ste: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth(context) * 0.05)),
                  Text(
                    item.number,
                    style: TextStyle(
                        color: const Color(0xFF793EA5),
                        fontSize: screenWidth(context) * 0.08,
                        fontWeight: FontWeight.w900),
                  )
                ],
              ),
              Image.asset(item.image),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (item.image == './heart.png') {
                      userProvider.setHearts(
                          userModel.hearts + int.parse(item.number), null);
                      userProvider.setFreeSpin(false);
                    } else {
                      userProvider.setDiamonds(
                          userModel.diamonds + int.parse(item.number));
                      userProvider.setFreeSpin(false);
                    }
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('Pokupi'),
                ),
              ],
            )
          ],
          backgroundColor: Colors.black87,
        ),
      ],
    );
  }
}
