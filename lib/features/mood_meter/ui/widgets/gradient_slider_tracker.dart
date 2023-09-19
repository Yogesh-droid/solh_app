import 'package:flutter/material.dart';

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  GradientRectSliderTrackShape({
    required Gradient gradient,
    required bool darkenInactive,
  }) : _gradient = gradient;

  final Gradient _gradient;

  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required Offset thumbCenter,
      Offset? secondaryOffset,
      bool? isEnabled,
      bool? isDiscrete,
      required TextDirection textDirection}) {
    final rect = Rect.fromCenter(
      center: Offset(parentBox.size.width / 2, parentBox.size.height / 2),
      width: parentBox.size.width,
      height: 7,
    );

    final gradient = _gradient.createShader(rect);

    final paint = Paint()
      ..shader = gradient
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
          rect, Radius.circular(sliderTheme.trackHeight ?? 2.0)),
      paint,
    );
  }
}
