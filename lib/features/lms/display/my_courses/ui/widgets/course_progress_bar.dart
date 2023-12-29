import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/stepsProgressbar.dart';

class CourseProgressBar extends StatelessWidget {
  const CourseProgressBar({super.key, required this.progress});

  final int progress;
  @override
  Widget build(BuildContext context) {
    return StepsProgressbar(
      stepNumber: 50,
      maxStep: 100,
      upperBarcolor: _getUpperBarColor(progress),
      bottomBarcolor: SolhColors.grey_3,
    );
  }
}

Color _getUpperBarColor(int progress) {
  if (progress < 30) {
    return SolhColors.org_color;
  } else if (progress > 30 && progress < 80) {
    return Colors.yellowAccent[700]!;
  } else {
    return SolhColors.primary_green;
  }
}
