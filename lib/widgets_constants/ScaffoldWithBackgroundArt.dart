import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScaffoldWithBackgroundArt extends StatelessWidget {
  ScaffoldWithBackgroundArt({
    Key? key,
    this.appBar,
    this.body,
  }) : super(key: key);

  final AppBar? appBar;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FittedBox(
          fit: BoxFit.fill,
          child: Container(
            child: SvgPicture.asset('assets/images/ScaffoldBackground.svg'),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: body,
        )
      ],
    );
  }
}
