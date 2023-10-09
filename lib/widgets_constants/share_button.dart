import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
    required this.onTap,
    this.iconSize = 22,
    this.backgroundCircleColor = SolhColors.primary_green,
    this.enableBackgroundCircle = true,
    this.iconColor = SolhColors.white,
  });

  final double iconSize;
  final bool enableBackgroundCircle;
  final Color iconColor;
  final Color backgroundCircleColor;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: enableBackgroundCircle
                ? backgroundCircleColor.withOpacity(0.7)
                : Colors.transparent,
            shape: BoxShape.circle),
        child: Icon(
          Icons.share,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
