import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class LiveBlink extends StatefulWidget {
  const LiveBlink({super.key});

  @override
  State<LiveBlink> createState() => _LiveBlinkState();
}

class _LiveBlinkState extends State<LiveBlink> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LiveTag(),
    );
  }
}

class LiveTag extends StatefulWidget {
  const LiveTag({super.key});

  @override
  State<LiveTag> createState() => _LiveTagState();
}

class _LiveTagState extends State<LiveTag> with SingleTickerProviderStateMixin {
  Animation<Color?>? _color;

  AnimationController? _controller;

  @override
  void initState() {
    // TODO: implement initState

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
          ..repeat();

    _color = ColorTween(begin: Colors.white, end: SolhColors.primaryRed)
        .animate(CurvedAnimation(
      parent: _controller!,
      curve: Interval(
        0,
        0.6,
      ),
    ));

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      decoration: BoxDecoration(
        color: SolhColors.primaryRed,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Live',
            style:
                SolhTextStyles.QS_cap_2_semi.copyWith(color: SolhColors.white),
          ),
          SizedBox(
            width: 5,
          ),
          AnimatedBuilder(
            animation: _controller!,
            builder: (context, child) {
              return Container(
                height: 5,
                width: 5,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: _color?.value),
              );
            },
          )
        ],
      ),
    );
  }
}
