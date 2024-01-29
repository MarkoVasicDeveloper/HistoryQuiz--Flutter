import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';
import 'package:istorija_srbije/core/shared/animations/entrance_transition.dart';

class AssetNumberAnimation extends StatefulWidget {
  final int number;
  final Widget Function(
          Animation<double> animation, Color textColor, Color shadowColor)
      childBuilder;

  const AssetNumberAnimation({
    Key? key,
    required this.number,
    required this.childBuilder,
  }) : super(key: key);

  @override
  AssetNumberAnimationState createState() => AssetNumberAnimationState();
}

class AssetNumberAnimationState extends State<AssetNumberAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<Color?> _shadowColorAnimation;
  late Color _textColor;
  late Color _shadowColor;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation =
        Tween<double>(begin: 1.0, end: 1.5).animate(_animationController);

    _shadowColorAnimation = ColorTween(
      begin: Colors.white.withOpacity(0.0),
      end: Colors.white.withOpacity(0.5),
    ).animate(_animationController);

    _textColor = const Color.fromARGB(255, 226, 218, 218);
    _shadowColor = _shadowColorAnimation.value ?? Colors.transparent;

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
        _resetColors();
      }
    });
  }

  @override
  void didUpdateWidget(covariant AssetNumberAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.number != oldWidget.number) {
      _setAnimationsColors(
        widget.number > oldWidget.number ? Colors.white : Colors.red,
        widget.number > oldWidget.number
            ? Colors.white.withOpacity(0.5)
            : Colors.red.withOpacity(0.5),
      );
    }
  }

  void _setAnimationsColors(Color textColor, Color shadowColor) {
    _animationController.forward(from: 0.0);

    _shadowColorAnimation = ColorTween(
      begin: _shadowColor,
      end: shadowColor,
    ).animate(_animationController);

    setState(() {
      _textColor = textColor;
      _shadowColor = shadowColor;
    });
  }

  void _resetColors() {
    setState(() {
      _textColor = const Color.fromARGB(255, 226, 218, 218);
      _shadowColor = Colors.white.withOpacity(0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return EntranceTransition(
      width: screenWidth(context) * 0.2,
      delay: const Duration(seconds: 1),
      offsetX: 0.0,
      offsetY: 100.0,
      initialX: 0.0,
      initialY: 0.0,
      offsetXPercentage: 0.05,
      offsetYPercentage: -0.04,
      child: widget.childBuilder(_animation, _textColor, _shadowColor),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
