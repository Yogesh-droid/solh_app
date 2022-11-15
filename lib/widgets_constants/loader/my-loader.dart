import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';

class MyLoader extends StatelessWidget {
  MyLoader({Key? key, this.strokeWidth = 6, this.radius}) : super(key: key);

  final double strokeWidth;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SolhGradientLoader(
      radius: radius,
      strokeWidth: strokeWidth,
    );
  }
}

class SolhGradientLoader extends StatelessWidget {
  const SolhGradientLoader({Key? key, this.strokeWidth = 6.0, this.radius})
      : super(key: key);

  final double strokeWidth;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return GradientProgressIndicator(
          radius: radius == null &&
                  (constraints.maxHeight > 300 || constraints.maxWidth > 300)
              ? 25
              : (constraints.maxHeight > constraints.maxWidth
                  ? constraints.maxWidth / 2
                  : constraints.maxHeight / 2),
          duration: 1,
          strokeWidth: strokeWidth,
          gradientStops: const [0.2, 0.8, 0.10],
          gradientColors: const [
            Color(0xff5F9B8C),
            Color(0xffe1555a),
            Colors.transparent
          ],
          child: Container());
    });
  }
}
