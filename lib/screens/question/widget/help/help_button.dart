import 'package:flutter/material.dart';

class HelpButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData icon;
  final String img;
  final double? top;
  final double? left;
  final double? right;

  const HelpButton(
      {Key? key,
      required this.text,
      required this.onTap,
      required this.icon,
      required this.img,
      this.top = -25,
      this.left = 0,
      this.right = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              constraints: const BoxConstraints(minHeight: 40),
              width: MediaQuery.of(context).size.width / 3 - 10.0,
              height: 30.0,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF793EA5), width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: top,
            left: left,
            right: right,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                img,
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.width * 0.1,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
