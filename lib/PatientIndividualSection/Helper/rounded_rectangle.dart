import 'package:flutter/cupertino.dart';

class RoundedRectangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFfbfcff)
      ..style = PaintingStyle.fill;

    // print();

    Rect rect = Rect.fromLTWH(
        0.138790 * size.width, 0.546916 * size.height, size.width, size.height);
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(17.8184)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
