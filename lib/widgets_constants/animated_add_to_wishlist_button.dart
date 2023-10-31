import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  late Animation colorAnimation;
  late Animation sizeAnimation;

  @override
  void initState() {
    // TODO: implement initState
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    // colorAnimation = TweenSequence([
    //   TweenSequenceItem(
    //       tween: ColorTween(begin: Colors.grey, end: Colors.red), weight: 10),
    //   TweenSequenceItem(
    //       tween: ColorTween(begin: Colors.red, end: Colors.grey), weight: 10)
    // ]).animate(controller);
    sizeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 30, end: 35), weight: 10),
//       TweenSequenceItem(tween: Tween(begin: 35, end: 30), weight: 10)
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
            color: widget.isSelected ? Colors.red : Colors.grey,
          ),
        );
      },
    );
  }
}
