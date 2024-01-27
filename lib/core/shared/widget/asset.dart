import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/shared/animations/asset_number.dart';
import 'package:istorija_srbije/core/shared/widget/diamond_heart_offer.dart';

class Asset extends StatefulWidget {
  final String icon;
  final int number;

  const Asset({
    Key? key,
    required this.icon,
    required this.number,
  }) : super(key: key);

  @override
  AssetState createState() => AssetState();
}

class AssetState extends State<Asset> {
  late Animation<double> _animation;
  late Color _textColor;
  late Color _shadowColor;
  final DiamondsHeartsOffer _diamondsHeartsOffer = const DiamondsHeartsOffer();

  @override
  Widget build(BuildContext context) {
    final scale = widget.icon == 'star.png' ? 0.165 : 0.105;
    final layout = widget.icon == 'star.png' ? 0.05 : 0.03;

    return AssetNumberAnimation(
      number: widget.number,
      childBuilder: (animation, textColor, shadowColor) {
        _animation = animation;
        _textColor = textColor;
        _shadowColor = shadowColor;

        return GestureDetector(
          onTap: () {
            if (widget.icon != 'star.png') {
              _diamondsHeartsOffer.showDiamondsHeartsOffer(context);
            }
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.21,
            height: 30,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 128, 64, 64),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: _shadowColor,
                    spreadRadius: 0.5,
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(1, 1, 3, 1),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: -MediaQuery.of(context).size.width * layout,
                    top: -MediaQuery.of(context).size.width * layout,
                    child: Image.asset(
                      'assets/${widget.icon}',
                      width: MediaQuery.of(context).size.width * scale,
                      height: MediaQuery.of(context).size.width * scale,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: widget.icon == 'star.png'
                            ? const EdgeInsets.only(right: 5.0)
                            : const EdgeInsets.all(0),
                        child: Transform.scale(
                          scale: _animation.value,
                          child: Visibility(
                            visible: true,
                            child: Text(
                              widget.number.toString(),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                color: _textColor,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (widget.icon != 'star.png')
                        const Padding(
                          padding: EdgeInsets.only(left: 2),
                          child: Icon(
                            Icons.add_circle,
                            color: Color.fromARGB(255, 14, 204, 4),
                            size: 12,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
