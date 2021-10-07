import 'package:flutter/material.dart';
import 'package:solh/shared_widgets_constants/constants/colors.dart';

class SolhCurvedContainer extends StatelessWidget {
  const SolhCurvedContainer(
      {
      Key? key,
      this.child,
      this.onPressed,
      this.height,
      this.width,
      this.backgroundColor,
      this.padding,
      this.border,
      this.borderRadius,
      this.alignment,
      this.margin,
      }) :
      super (key: key);

  final double? height;
  final double? width;
  final Widget? child;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final Border? border;
  final BorderRadius? borderRadius;
  final Alignment? alignment;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: alignment ?? Alignment.center,
        margin: margin,
        padding: padding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            border: border ?? Border.all(color: SolhColors.green, width: 2.0),
            borderRadius: borderRadius ?? BorderRadius.circular(20)
            ),
        height: height ?? MediaQuery.of(context).size.height / 18,
        width: width ?? MediaQuery.of(context).size.width / 1.8,
        child: child,
      ),
    );
  }
}