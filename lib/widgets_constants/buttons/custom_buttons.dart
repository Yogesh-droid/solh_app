import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SolhGreenBorderMiniButton extends StatelessWidget {
  SolhGreenBorderMiniButton({
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
  }) : super(key: key);

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
          border: border ?? Border.all(color: SolhColors.green, width: 1.0),
          borderRadius: borderRadius ?? BorderRadius.circular(25),
        ),
        height: height ?? MediaQuery.of(context).size.height / 18,
        width: width ?? MediaQuery.of(context).size.width / 3,
        child: child,
      ),
    );
  }
}

class SolhPinkBorderMiniButton extends StatelessWidget {
  const SolhPinkBorderMiniButton({
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
  }) : super(key: key);

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
          border: border ?? Border.all(color: SolhColors.pink224, width: 1.0),
          borderRadius: borderRadius ?? BorderRadius.circular(20),
        ),
        height: height ?? MediaQuery.of(context).size.height / 18,
        width: width ?? MediaQuery.of(context).size.width / 3,
        child: child,
      ),
    );
  }
}

class SolhGreenMiniButton extends StatefulWidget {
  const SolhGreenMiniButton({
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
  }) : super(key: key);

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
  const SolhPinkMiniButton({
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
  }) : super(key: key);

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

class SolhGreenButton extends StatefulWidget {
  const SolhGreenButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.height,
    this.width,
    this.backgroundColor,
    this.padding,
    this.border,
    this.borderRadius,
    this.alignment,
    this.margin,
  }) : super(key: key);

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
  _SolhGreenButtonState createState() => _SolhGreenButtonState();
}

class _SolhGreenButtonState extends State<SolhGreenButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 5.h,
      width: widget.width ?? double.infinity,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(30.0),
          )),
        ),
        onPressed: widget.onPressed,
        child: Container(alignment: Alignment.center, child: widget.child),
      ),
    );
  }
}

class SolhGreenBorderButton extends StatefulWidget {
  SolhGreenBorderButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.height,
    this.width,
    this.backgroundColor,
    this.padding,
    this.border,
    this.borderRadius,
    this.alignment,
    this.margin,
  }) : super(key: key);

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
  _SolhGreenBorderButtonState createState() => _SolhGreenBorderButtonState();
}

class _SolhGreenBorderButtonState extends State<SolhGreenBorderButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 5.h,
      width: widget.width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        border: Border.all(color: SolhColors.green),
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).scaffoldBackgroundColor),
          overlayColor: MaterialStateProperty.all<Color>(
              SolhColors.green.withOpacity(0.5)),
        ),
        child: Container(alignment: Alignment.center, child: widget.child),
      ),
    );
  }
}
