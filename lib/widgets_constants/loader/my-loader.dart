import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class MyLoader extends StatelessWidget {
  const MyLoader({
    Key? key,
    double? strokeWidth,
    Color? backgroundColor,
  })  : _strokeWidth = strokeWidth,
        _backgroundColor = backgroundColor,
        super(key: key);

  final double? _strokeWidth;
  final Color? _backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: SolhColors.green,
      strokeWidth: _strokeWidth ?? 4.0,
      backgroundColor: _backgroundColor,
    );
  }
}
