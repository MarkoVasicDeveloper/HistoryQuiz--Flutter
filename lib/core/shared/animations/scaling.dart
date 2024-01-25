import 'package:flutter/material.dart';

class Scaling extends StatefulWidget {
  final Widget child;
  final double targetWidth;
  final double targetHeight;
  final Duration delay;
  final Duration duration;
  final Curve curve;

  const Scaling({
    Key? key,
    required this.child,
    required this.targetWidth,
    required this.targetHeight,
    required this.delay,
    required this.duration,
    this.curve = Curves.elasticInOut,
  }) : super(key: key);

  @override
  ScalingState createState() => ScalingState();
}

class ScalingState extends State<Scaling> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    Future.delayed(widget.delay, () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
