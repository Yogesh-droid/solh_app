import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        "Skip",
        style: TextStyle(color: SolhColors.green),
      ),
    );
  }
}
