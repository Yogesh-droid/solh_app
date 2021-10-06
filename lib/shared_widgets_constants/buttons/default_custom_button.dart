import 'package:flutter/material.dart';
import 'package:solh/shared_widgets_constants/constants/colors.dart';

class SolhDefaultCustomButton extends StatefulWidget {
  SolhDefaultCustomButton(
      {
      Key? key,
      this.child,
      required this.onPressed,
      this.height,
      this.width,
      this.backgroundColor,
      this.padding,
      this.border,
      this.borderRadius,
      this.alignment,
      this.margin,
      }) :
      super(key: key);

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
  _SolhDefaultCustomButtonState createState() => _SolhDefaultCustomButtonState();
}

class _SolhDefaultCustomButtonState extends State<SolhDefaultCustomButton> {
  
  @override
  Widget build(BuildContext context) {
   return InkWell(
      onTap: widget.onPressed,
      child: Container(
        alignment: widget.alignment ?? Alignment.center,
        margin: widget.margin,
        padding: widget.padding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
            color: widget.backgroundColor ?? SolhColors.white,
            border: widget.border ?? Border.all(color: SolhColors.green, width: 2.0),
            borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
            ),
        height: widget.height ?? MediaQuery.of(context).size.height / 18,
        width: widget.width ?? MediaQuery.of(context).size.width / 3,
        child: widget.child,
      ),
    );
  }
}