import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';

class DiamondsHeartsOffer extends StatelessWidget {
  const DiamondsHeartsOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context),
      decoration: const BoxDecoration(color: Colors.black45),
    );
  }

  void showDiamondsHeartsOffer(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DiamondsHeartsOffer();
      },
    );
  }
}
