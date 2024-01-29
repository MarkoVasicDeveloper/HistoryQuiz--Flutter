import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';

class OfferItem extends StatelessWidget {
  final String iconImg;
  final String text;
  final IconData icon;

  const OfferItem(
      {super.key,
      required this.iconImg,
      required this.text,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: screenWidth(context) - 60,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: const Color(0x66793EA5),
            border: Border.all(color: const Color(0xFF793EA5), width: 2),
            borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: screenWidth(context) * 0.15,
              color: const Color.fromARGB(255, 214, 2, 2),
            ),
            const SizedBox(width: 10.0),
            Text(
              text,
              style: TextStyle(
                  fontSize: screenWidth(context) * 0.06,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(width: 10.0),
            Image.asset(
              'assets/$iconImg',
              width: screenWidth(context) * 0.15,
              height: screenWidth(context) * 0.15,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
