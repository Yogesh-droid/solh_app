import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BubbleContainer();
  }
}

class AnimatedBubbleContatiner extends StatefulWidget {
  const AnimatedBubbleContatiner({Key? key}) : super(key: key);

  @override
  State<AnimatedBubbleContatiner> createState() =>
      _AnimatedBubbleContatinerState();
}

class _AnimatedBubbleContatinerState extends State<AnimatedBubbleContatiner> {
  double _width = 0;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _width = 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 20,
          width: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            right: _width,
            top: 0,
            bottom: 0,
            child: BubbleContainer()),
      ],
    );
  }
}

class BubbleContainer extends StatelessWidget {
  const BubbleContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 30,
        width: 70,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(50),
        ),
        child: BallsRow(),
      ),
    );
  }
}

class BallsRow extends StatefulWidget {
  const BallsRow({Key? key}) : super(key: key);

  @override
  State<BallsRow> createState() => _BallsRowState();
}

class _BallsRowState extends State<BallsRow>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  Animation<double>? ball1Animation;
  Animation<double>? ball2Animation;
  Animation<double>? ball3Animation;

  @override
  void initState() {
    // TODO: implement initState
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..repeat();

    ball1Animation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 5, end: 20),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 10, end: 15),
        weight: 1,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller!,
      curve: Interval(0, 0.4, curve: Curves.bounceIn),
    ));

    ball2Animation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 5, end: 20),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 10, end: 15),
        weight: 1,
      ),
    ]).animate(CurvedAnimation(
        parent: _controller!,
        curve: Interval(0.2, 0.7, curve: Curves.bounceIn)));

    ball3Animation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 5, end: 20),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 10, end: 15),
        weight: 1,
      ),
    ]).animate(CurvedAnimation(
        parent: _controller!, curve: Interval(0.5, 1, curve: Curves.bounceIn)));

    _controller!.addStatusListener((value) {
      if (value == AnimationStatus.completed) {
        _controller!.reverse();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BubbleBalls(),
            AnimatedBuilder(
                animation: _controller!,
                builder: (BuildContext context, _) {
                  return SizedBox(
                    height: ball1Animation!.value,
                  );
                })
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BubbleBalls(),
            AnimatedBuilder(
                animation: _controller!,
                builder: (BuildContext context, _) {
                  return SizedBox(
                    height: ball2Animation!.value,
                  );
                })
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BubbleBalls(),
            AnimatedBuilder(
                animation: _controller!,
                builder: (BuildContext context, _) {
                  return SizedBox(
                    height: ball3Animation!.value,
                  );
                })
          ],
        ),
      ],
    );
  }
}

class BubbleBalls extends StatelessWidget {
  const BubbleBalls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        shape: BoxShape.circle,
      ),
    );
  }
}
