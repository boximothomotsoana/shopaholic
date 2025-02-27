import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

/// 🎨 **Custom Top Curve**
class CurvePainterTop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = AppColors.primary;
    Path path = Path();

    path.moveTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// 🎨 **Custom Bottom Curve**
class CurvePainterBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color =  AppColors.primary;
    Path path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
