import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';

class InterestingFacts extends StatefulWidget {
  final String imageUrl;
  final String text;

  const InterestingFacts({Key? key, required this.imageUrl, required this.text})
      : super(key: key);

  @override
  InterestingFactsState createState() => InterestingFactsState();
}

class InterestingFactsState extends State<InterestingFacts> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 9, 9, 14)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    widget.imageUrl,
                    width: double.infinity,
                    height: 256,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Text(
                        widget.text,
                        style: TextStyle(
                            fontSize: screenWidth(context) * 0.04,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Zatvori'),
                  ),
                ],
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 2000),
            curve: Curves.fastOutSlowIn,
            builder: (context, value, child) {
              return Positioned(
                top: 20 + screenHeight(context) * value,
                left: 0,
                right: 0,
                child: Container(
                  height: screenHeight(context),
                  color: const Color.fromARGB(255, 9, 9, 14),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
