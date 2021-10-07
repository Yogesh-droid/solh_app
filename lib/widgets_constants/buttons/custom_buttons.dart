import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SolhGreenBorderMiniButton extends StatefulWidget {
  SolhGreenBorderMiniButton(
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
  _SolhGreenBorderMiniButtonState createState() => _SolhGreenBorderMiniButtonState();
}

class _SolhGreenBorderMiniButtonState extends State<SolhGreenBorderMiniButton> {
  
  @override
  Widget build(BuildContext context) {
   return InkWell(
      onTap: widget.onPressed,
      child: Container(
        alignment: widget.alignment ?? Alignment.center,
        margin: widget.margin,
        padding: widget.padding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.transparent,
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

class SolhPinkBorderMiniButton extends StatefulWidget {
  const SolhPinkBorderMiniButton(
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
  _SolhPinkBorderMiniButtonState createState() => _SolhPinkBorderMiniButtonState();
}

class _SolhPinkBorderMiniButtonState extends State<SolhPinkBorderMiniButton> {

  @override
  Widget build(BuildContext context) {
   return InkWell(
      onTap: widget.onPressed,
      child: Container(
        alignment: widget.alignment ?? Alignment.center,
        margin: widget.margin,
        padding: widget.padding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.transparent,
            border: widget.border ?? Border.all(color: SolhColors.pink224, width: 2.0),
            borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
            ),
        height: widget.height ?? MediaQuery.of(context).size.height / 18,
        width: widget.width ?? MediaQuery.of(context).size.width / 3,
        child: widget.child,
      ),
    );
  }
}

class SolhGreenMiniButton extends StatefulWidget {
  const SolhGreenMiniButton(
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
  _SolhGreenMiniButtonState createState() => _SolhGreenMiniButtonState();
}

class _SolhGreenMiniButtonState extends State<SolhGreenMiniButton> {
  
  @override
  Widget build(BuildContext context) {
   return InkWell(
      onTap: widget.onPressed,
      child: Container(
        alignment: widget.alignment ?? Alignment.center,
        margin: widget.margin,
        padding: widget.padding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
            color: widget.backgroundColor ?? SolhColors.green,
            border: widget.border ?? null,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
            ),
        height: widget.height ?? MediaQuery.of(context).size.height / 18,
        width: widget.width ?? MediaQuery.of(context).size.width / 3,
        child: widget.child,
      ),
    );
  }
}

class SolhPinkMiniButton extends StatefulWidget {
  const SolhPinkMiniButton(
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
  _SolhPinkMiniButtonState createState() => _SolhPinkMiniButtonState();
}

class _SolhPinkMiniButtonState extends State<SolhPinkMiniButton> {

  @override
  Widget build(BuildContext context) {
   return InkWell(
      onTap: widget.onPressed,
      child: Container(
        alignment: widget.alignment ?? Alignment.center,
        margin: widget.margin,
        padding: widget.padding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
            color: widget.backgroundColor ?? SolhColors.pink224,
            border: widget.border ?? null,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
            ),
        height: widget.height ?? MediaQuery.of(context).size.height / 18,
        width: widget.width ?? MediaQuery.of(context).size.width / 3,
        child: widget.child,
      ),
    );
  }
}