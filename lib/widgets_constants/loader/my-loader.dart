import 'package:flutter/material.dart';

import 'custom_loader.dart';

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
      print('maxHeight' + constraints.maxHeight.toString());
      return GradientProgressIndicator(
          radius: radius != null
              ? radius!
              : (radius == null &&
                      (constraints.maxHeight > 200 ||
                          constraints.maxWidth > 200)
                  ? 25
                  : (constraints.maxHeight > constraints.maxWidth
                      ? constraints.maxWidth / 2
                      : constraints.maxHeight / 2)),
          duration: Duration(milliseconds: 500),
          strokeWidth: strokeWidth,
          gradientStops: const [0.0, 0.4, 0.10],
          gradientColors: const [
            Color(0xff5F9B8C),
            Color(0xffe1555a),
            Colors.transparent
          ],
          child: Container());
    });
  }
}

class SolhSmallButtonLoader extends StatelessWidget {
  SolhSmallButtonLoader(
      {Key? key, this.strokeWidth = 1.0, this.color = Colors.white})
      : super(key: key);

  final double strokeWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: strokeWidth,
      color: color,
    );
  }
}
