import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key, this.onClick}) : super(key: key);

  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Text(
        "Skip",
        style: TextStyle(color: SolhColors.primary_green),
      ),
    );
  }
}
