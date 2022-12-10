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
          border:
              border ?? Border.all(color: SolhColors.primary_green, width: 1.0),
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

class SolhGreenMiniButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: alignment ?? Alignment.center,
        margin: margin,
        padding: padding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          color: backgroundColor ?? SolhColors.primary_green,
          border: border ?? null,
          borderRadius: borderRadius ?? BorderRadius.circular(20),
        ),
        height: height ?? MediaQuery.of(context).size.height / 18,
        width: width ?? MediaQuery.of(context).size.width / 3,
        child: child,
      ),
    );
  }
}

class SolhPinkMiniButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: alignment ?? Alignment.center,
        margin: margin,
        padding: padding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          color: backgroundColor ?? SolhColors.pink224,
          border: border ?? null,
          borderRadius: borderRadius ?? BorderRadius.circular(20),
        ),
        height: height ?? MediaQuery.of(context).size.height / 18,
        width: width ?? MediaQuery.of(context).size.width / 3,
        child: child,
      ),
    );
  }
}

class SolhGreenButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 48,
      width: width ?? 180,
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                backgroundColor ?? SolhColors.primary_green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(30.0),
            )),
          ),
          onPressed: onPressed,
          child: child),
    );
  }
}

class SolhGreenBorderButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 5.h,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        border: Border.all(color: SolhColors.primary_green),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).scaffoldBackgroundColor),
          overlayColor: MaterialStateProperty.all<Color>(
              SolhColors.primary_green.withOpacity(0.5)),
        ),
        child: Container(alignment: Alignment.center, child: child),
      ),
    );
  }
}

class SolhGreenButtonWithWhiteBorder extends StatelessWidget {
  const SolhGreenButtonWithWhiteBorder({
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
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 5.h,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: SolhColors.white),
          boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black54)],
          borderRadius: BorderRadius.circular(24)),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(30.0),
          )),
        ),
        onPressed: onPressed,
        child: Container(alignment: Alignment.center, child: child),
      ),
    );
  }
}
