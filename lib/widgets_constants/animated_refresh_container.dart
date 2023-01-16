import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class AnimatedRefreshContainer extends StatelessWidget {
  AnimatedRefreshContainer({Key? key, this.text = 'Refreshing..'})
      : super(key: key);
  final text;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        child: RefreshContainer(text: text),
        tween: Tween<double>(begin: 0, end: 20),
        duration: Duration(milliseconds: 300),
        builder: (BuildContext context, double _val, Widget? child) {
          return Container(
            padding: EdgeInsets.only(top: _val),
            child: child,
          );
        });
  }
}

class RefreshContainer extends StatelessWidget {
  const RefreshContainer({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
          color: SolhColors.primary_green,
          borderRadius: BorderRadius.circular(24)),
      child: Center(
        child: Text(text,
            style: SolhTextStyles.CTA.copyWith(color: SolhColors.white)),
      ),
    );
  }
}
