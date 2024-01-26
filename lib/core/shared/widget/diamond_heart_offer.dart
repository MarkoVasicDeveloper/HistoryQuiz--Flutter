import 'package:flutter/material.dart';

class DiamondsHeartsOffer extends StatelessWidget {
  const DiamondsHeartsOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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
