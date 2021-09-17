import 'package:flutter/material.dart';
import 'package:solh/shared_widgets_constants/constants/colors.dart';

class CurvedContainer extends StatelessWidget {
  const CurvedContainer(this.child,
      {this.onPressed,
      this.height,
      this.width,
      this.backgroundColor,
      this.padding,
      this.border,
      this.borderRadius,
      this.alignment,
      this.margin,
      });

  final double? height;
  final double? width;
  final Widget child;
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
        padding: padding ?? EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height/60,
          horizontal: MediaQuery.of(context).size.width/20
          ),
        decoration: BoxDecoration(
            color: backgroundColor ?? SolhColors.black,
            border: border ?? Border.all(color: SolhColors.black),
            borderRadius: borderRadius ?? BorderRadius.circular(10)
            ),
        height: height ?? MediaQuery.of(context).size.height / 18,
        width: width ?? MediaQuery.of(context).size.width / 1.8,
        child: child,
      ),
    );
  }
}