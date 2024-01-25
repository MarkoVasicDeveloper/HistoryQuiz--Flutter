import 'package:flutter/material.dart';

class EntranceTransition extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Curve curve;
  final Duration duration;
  final double offsetX;
  final double offsetY;
  final bool fadeIn;
  final double initialX;
  final double initialY;
  final double offsetXPercentage;
  final double offsetYPercentage;
  final double width;

  const EntranceTransition({
    Key? key,
    required this.child,
    required this.width,
    this.delay = Duration.zero,
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 300),
    this.offsetX = 0.0,
    this.offsetY = 0.0,
    this.fadeIn = true,
    this.initialX = 0.0,
    this.initialY = 0.0,
    this.offsetXPercentage = 0.0,
    this.offsetYPercentage = 0.0,
  }) : super(key: key);

  @override
  EntranceTransitionState createState() => EntranceTransitionState();
}

class EntranceTransitionState extends State<EntranceTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _slideAnimation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _fadeAnimation = Tween<double>(
      begin: widget.fadeIn ? 0.0 : 1.0,
      end: widget.fadeIn ? 1.0 : 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    Future.delayed(widget.delay, () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            _slideAnimation.value * widget.offsetX +
                widget.initialX +
                screenWidth * widget.offsetXPercentage -
                widget.width / 2,
            _slideAnimation.value * widget.offsetY +
                widget.initialY +
                screenHeight * widget.offsetYPercentage,
          ),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
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
