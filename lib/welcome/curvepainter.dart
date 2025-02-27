import 'package:flutter/material.dart';

class WelcomeCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define the gradient
    final Gradient gradient = LinearGradient(
      begin: Alignment(-1.0, 0.0), // Adjusted for 109.6 degrees
      end: Alignment(1.0, 1.0),
      colors: [
        Color.fromARGB(255, 19, 170, 82), // rgb(0, 204, 130)
        Color.fromARGB(255, 0, 102, 43), // rgb(58, 181, 46)
      ],
      stops: [0.112, 0.917], // Equivalent to 11.2% and 91.7%
    );

    // Create a paint object with the gradient
    final Paint paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Define the curved path
    final Path path = Path()
      ..lineTo(0, size.height * 0.4) // Move to 40% height
      ..quadraticBezierTo(
        size.width * 0.5, size.height * 0.2, // Control point
        size.width, size.height * 0.4,     // End point
      )
      ..lineTo(size.width, 0) // Line to the top-right corner
      ..close();

    // Draw the path with the gradient paint
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
