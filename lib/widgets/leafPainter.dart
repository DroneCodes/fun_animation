import 'package:flutter/material.dart';

class LeafPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(size.width / 2, size.height / 2)
      ..cubicTo(
        size.width * 0.5,
        size.height * 0.2,
        size.width * 0.2,
        size.height * 0.2,
        size.width * 0.5,
        size.height * 0.1,
      )
      ..cubicTo(
        size.width * 0.8,
        size.height * 0.2,
        size.width * 0.5,
        size.height * 0.2,
        size.width / 2,
        size.height / 2,
      );

    // Add additional details to the leaf
    path.moveTo(size.width / 2, size.height / 2);
    path.lineTo(size.width * 0.4, size.height * 0.3);
    path.moveTo(size.width / 2, size.height / 2);
    path.lineTo(size.width * 0.6, size.height * 0.3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
