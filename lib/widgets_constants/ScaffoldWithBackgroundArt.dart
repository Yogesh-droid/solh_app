import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class ScaffoldWithBackgroundArt extends StatelessWidget {
  ScaffoldWithBackgroundArt({
    Key? key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 100.h,
            width: 100.w,
            color: Colors.white,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image(
                image: AssetImage('assets/images/backgroundScaffold.png'),
              ),
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: floatingActionButton,
          appBar: appBar,
          body: body,
        )
      ],
    );
  }
}

class ScaffoldGreenWithBackgroundArt extends StatelessWidget {
  ScaffoldGreenWithBackgroundArt({
    Key? key,
    this.appBar,
    this.body,
    this.floatingActionButton,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 100.h,
            width: 100.w,
            color: Colors.white,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image(
                image: AssetImage('assets/images/ScaffoldBackgroundGreen.png'),
              ),
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: body,
          floatingActionButton: floatingActionButton,
        )
      ],
    );
  }
}
