import 'package:flutter/material.dart';

///  This is a custom tick mark shape.
class MyTickerShape extends SliderTickMarkShape {
  @override
  Size getPreferredSize({
    required SliderThemeData sliderTheme,
    bool? isEnabled,
    bool? isDiscrete,
  }) {
    return Size(10.0, 10.0);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required Offset thumbCenter,
      required bool isEnabled,
      required TextDirection textDirection}) {
    final paint = Paint();
    paint.color = Color(0xFFA6A6A6);
    paint.style = PaintingStyle.fill;

    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: 3.0, height: 20.0),
      Radius.circular(10),
    );
    context.canvas.drawRRect(rRect, paint);
  }
}
