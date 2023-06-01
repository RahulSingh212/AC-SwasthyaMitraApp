// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xff42ccc3)
      ..strokeWidth = 15;

    double _aspect_ratio = size.width / size.height;

    Offset centre = Offset(size.width / 2, 0);
    canvas.drawCircle(centre, size.width, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
