import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class ButtonLoadingAnimation extends StatelessWidget {
  const ButtonLoadingAnimation(
      {Key? key,
      this.ballSizeLowerBound,
      this.ballSizeUpperBound,
      this.ballColor = SolhColors.green})
      : super(key: key);

  final double? ballSizeUpperBound;
  final double? ballSizeLowerBound;
  final Color ballColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          maxWidth: 70,
          maxHeight: 40,
        ),
        child: BallsRow(
          ballSizeLowerBound: ballSizeLowerBound,
          ballSizeUpperBound: ballSizeUpperBound,
          ballColor: ballColor,
        ));
  }
}

class BallsRow extends StatefulWidget {
  const BallsRow(
      {Key? key,
      this.ballSizeLowerBound = 5,
      this.ballSizeUpperBound = 20,
      required this.ballColor})
      : super(key: key);

  final double? ballSizeUpperBound;
  final double? ballSizeLowerBound;
  final Color ballColor;

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
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..repeat();

    ball1Animation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(
            begin: widget.ballSizeLowerBound, end: widget.ballSizeUpperBound),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
            begin: widget.ballSizeUpperBound, end: widget.ballSizeLowerBound),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller!,
      curve: Interval(0, 0.6, curve: Curves.easeOut),
    ));

    ball2Animation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(
            begin: widget.ballSizeLowerBound, end: widget.ballSizeUpperBound),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
            begin: widget.ballSizeUpperBound, end: widget.ballSizeLowerBound),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(
        parent: _controller!,
        curve: Interval(0.2, 0.8, curve: Curves.easeOut)));

    ball3Animation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(
            begin: widget.ballSizeLowerBound, end: widget.ballSizeUpperBound),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
            begin: widget.ballSizeUpperBound, end: widget.ballSizeLowerBound),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(
        parent: _controller!, curve: Interval(0.4, 1, curve: Curves.easeOut)));

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
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _controller!,
                  builder: (BuildContext context, _) {
                    return BubbleBalls(
                      size: ball1Animation!.value,
                      ballColor: widget.ballColor,
                    );
                  })
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _controller!,
                  builder: (BuildContext context, _) {
                    return BubbleBalls(
                      size: ball2Animation!.value,
                      ballColor: widget.ballColor,
                    );
                  })
            ],
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _controller!,
                  builder: (BuildContext context, _) {
                    return BubbleBalls(
                      size: ball3Animation!.value,
                      ballColor: widget.ballColor,
                    );
                  })
            ],
          ),
        ),
      ],
    );
  }
}

class BubbleBalls extends StatelessWidget {
  const BubbleBalls({Key? key, required this.size, required this.ballColor})
      : super(key: key);

  final double size;
  final Color ballColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: ballColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
