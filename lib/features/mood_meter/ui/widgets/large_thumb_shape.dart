import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../widgets_constants/constants/colors.dart';

class LargeThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(
      10.w,
      10.h,
    );
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final RRect outer = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: 48,
        height: 50,
      ),
      Radius.circular(25),
    );

    final RRect inner = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: 42,
        height: 42,
      ),
      Radius.circular(25),
    );

    final RRect shadow = RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 30, height: 30),
        Radius.circular(30));

    final Paint paint = Paint()
      ..color = SolhColors.primary_green
      ..style = PaintingStyle.fill;

    final Paint paint2 = Paint()
      ..color = SolhColors.greenShade5
      ..style = PaintingStyle.fill;

    context.canvas
        .drawShadow(Path()..addRRect(shadow), Colors.black, 10, false);
    context.canvas.drawRRect(outer, paint);
    context.canvas.drawRRect(inner, paint2);
  }
}
