import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class ProfileSetupFloatingActionButton {
  static Widget profileSetupFloatingActionButton(
      {required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: SolhColors.white, width: 2),
          shape: BoxShape.circle),
      child: FloatingActionButton(
        backgroundColor: SolhColors.green,
        onPressed: onPressed,
        child: Icon(
          Icons.chevron_right_rounded,
          size: 40,
        ),
      ),
    );
  }
}
