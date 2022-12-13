import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class ProfileSetupFloatingActionButton {
  static Widget profileSetupFloatingActionButton(
      {required VoidCallback onPressed,
      Widget? child = const Icon(
        Icons.chevron_right_rounded,
        size: 40,
      )}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: SolhColors.white, width: 2),
          shape: BoxShape.circle),
      child: FloatingActionButton(
        backgroundColor: SolhColors.primary_green,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
