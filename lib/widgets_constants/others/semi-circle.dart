import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:solh/widgets_constants/constants/colors.dart';

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({
    Key? key,
    this.diameter = 200,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(color ?? SolhColors.primary_green),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  MyPainter(this.color);
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
