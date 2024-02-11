import 'package:flutter/material.dart';
import 'package:istorija_srbije/core/constant/screen.dart';

class Triangle extends StatefulWidget {
  final bool isVisible;
  final bool left;
  final String username;
  final int points;

  const Triangle(
      {Key? key,
      required this.isVisible,
      required this.left,
      required this.username,
      required this.points})
      : super(key: key);

  @override
  TriangleState createState() => TriangleState();
}

class TriangleState extends State<Triangle> {
  @override
  Widget build(BuildContext context) {
    final matrix = Matrix4.identity()
      ..translate(widget.isVisible ? 0.0 : -screenWidth(context), 0.0);

    final rightMatrix = Matrix4.identity()
      ..translate(widget.isVisible ? 0.0 : screenWidth(context), 0.0);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      transform: widget.left ? matrix : rightMatrix,
      child: Stack(
        children: [
          SizedBox(
            width: screenWidth(context),
            height: screenHeight(context),
            child: CustomPaint(
              painter: TrianglePainter(left: widget.left),
            ),
          ),
          Positioned(
            bottom: widget.left
                ? screenHeight(context) / 3
                : screenHeight(context) / 1.5,
            left: widget.left
                ? screenWidth(context) / 4
                : screenWidth(context) / 2,
            child: Column(
              children: [
                Text(
                  widget.username,
                  style: TextStyle(
                      fontFamily: 'ShantellSans',
                      fontSize: screenWidth(context) * 0.07,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  widget.points.toString(),
                  style: TextStyle(
                      fontFamily: 'RubikDoodleShadow',
                      fontSize: screenWidth(context) * 0.05,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final bool left;

  TrianglePainter({required this.left});

  @override
  void paint(Canvas canvas, Size size) {
    const Gradient gradient = LinearGradient(
      colors: [
        Color(0xFF793EA5),
        Color.fromRGBO(12, 12, 12, 1),
      ],
    );

    final Paint paint = Paint()
      ..shader = gradient.createShader(
          Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)));

    final Paint borderPaint = Paint()
      ..color = const Color.fromRGBO(198, 40, 40, 1)
      ..strokeWidth = 5.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5.0);

    final Path leftPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(0, 0)
      ..close();

    final Path rightPath = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(left ? leftPath : rightPath, paint);

    canvas.drawLine(
        const Offset(0, 0), Offset(size.width, size.height), borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
