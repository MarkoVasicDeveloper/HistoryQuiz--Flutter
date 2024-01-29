import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/core/shared/widget/offer/offer_item.dart';

class DiamondsHeartsOffer extends StatelessWidget {
  const DiamondsHeartsOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: screenWidth(context),
          height: screenHeight(context),
          decoration: const BoxDecoration(color: Colors.black45),
          child: const Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OfferItem(
                  iconImg: 'heart.png',
                  text: 'x2',
                  icon: Icons.play_arrow_rounded),
              SizedBox(
                width: 10.0,
                height: 10.0,
              ),
              OfferItem(
                  iconImg: 'diamond.png',
                  text: 'x2',
                  icon: Icons.play_arrow_rounded)
            ],
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Color(0xFF793EA5),
            ),
          ),
        ),
      ],
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
