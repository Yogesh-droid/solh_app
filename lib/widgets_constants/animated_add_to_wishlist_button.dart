import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

// ignore: must_be_immutable
class AnimatedAddToWishlistButton extends StatefulWidget {
  AnimatedAddToWishlistButton(
      {super.key, this.isSelected = false, this.onClick});
  bool isSelected;
  final VoidCallback? onClick;
  @override
  State<AnimatedAddToWishlistButton> createState() =>
      _AnimatedAddToWishlistButtonState();
}

class _AnimatedAddToWishlistButtonState
    extends State<AnimatedAddToWishlistButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation sizeAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));

    sizeAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 30.0, end: 35.0)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 10),
    ]).animate(controller);

    controller.addListener(() {
      if (AnimationStatus.completed == controller.status) {
        controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.onClick;
              widget.isSelected
                  ? widget.isSelected = !widget.isSelected
                  : widget.isSelected = !widget.isSelected;
              controller.forward();
            });
          },
          child: Icon(
            CupertinoIcons.heart_fill,
            size: sizeAnimation.value,
            color: widget.isSelected ? SolhColors.primaryRed : Colors.grey[400],
          ),
        );
      },
    );
  }
}
