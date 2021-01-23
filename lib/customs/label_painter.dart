import 'package:flutter/material.dart';

class LabelCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color(0xff2E3944)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    // path_0.moveTo(0, size.height * 0.08);
    path_0.quadraticBezierTo(0, 0, size.width * 0.55, size.height * 0.5);
    // path_0.quadraticBezierTo(
    //     size.width * 0.00, size.height * -0.00, size.width * 0.08, 0);
    // path_0.lineTo(size.width * 0.90, 0);
    // path_0.quadraticBezierTo(
    //     size.width * 1.00, size.height * -0.00, size.width, size.height * 0.08);
    // path_0.cubicTo(size.width * 0.94, size.height * 0.56, size.width * 0.36,
    //     size.height * 0.17, 0, size.height * 0.68);
    // path_0.cubicTo(
    //     0, size.height * 0.53, 0, size.height * 0.53, 0, size.height * 0.08);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
