import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:video_player/video_player.dart';

class SolhVideoPlayer extends StatefulWidget {
  const SolhVideoPlayer(
      {super.key, required this.videoUrl, this.aspectRatio = 4 / 2.5});

  final String videoUrl;
  final double aspectRatio;

  @override
  State<SolhVideoPlayer> createState() => _SolhVideoPlayerState();
}

class _SolhVideoPlayerState extends State<SolhVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = true;
  bool _isVideoEnded = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.videoUrl);
    _controller.play();
    _controller.addListener(() {
      if (_controller.value.duration == _controller.value.position &&
          !_controller.value.isPlaying &&
          _controller.value.isInitialized) {
        _isVideoEnded = true;

        setState(() {});
      }
    });

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(_controller),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 0,
                child: InkWell(
                    onTap: () async {
                      await videoController(_controller);
                      setState(() {});
                    },
                    child: videoPlayerIconController(_controller)))
          ],
        ),
      ),
    );
  }
}

Future<void> videoController(VideoPlayerController videoController) async {
  if (videoController.value.isPlaying) {
    await videoController.pause();
  } else if (videoController.value.duration == videoController.value.position &&
      !videoController.value.isPlaying &&
      videoController.value.isInitialized) {
    await videoController.seekTo(Duration.zero);
    await videoController.play();
  } else if (!videoController.value.isPlaying) {
    videoController.play();
  }
}

Widget videoPlayerIconController(VideoPlayerController videoController) {
  if (videoController.value.isPlaying) {
    return AnimatedVideoPlayerIcon(iconChild: Icons.pause);
  } else if (videoController.value.isBuffering) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonLoadingAnimation(
          ballColor: SolhColors.primary_green,
          ballSizeLowerBound: 3,
          ballSizeUpperBound: 8,
        ),
      ],
    );
  } else if (videoController.value.duration == videoController.value.position &&
      !videoController.value.isPlaying &&
      videoController.value.isInitialized) {
    return Icon(
      Icons.replay,
      color: SolhColors.primary_green,
      size: 10.w,
    );
  } else if (!videoController.value.isPlaying &&
      videoController.value.isInitialized) {
    return Icon(
      Icons.play_arrow,
      color: SolhColors.primary_green,
      size: 10.w,
    );
  } else {
    return Container();
  }
}

class AnimatedVideoPlayerIcon extends StatefulWidget {
  AnimatedVideoPlayerIcon({super.key, required this.iconChild});
  final IconData iconChild;

  @override
  State<AnimatedVideoPlayerIcon> createState() =>
      _AnimatedVideoPlayerIconState();
}

class _AnimatedVideoPlayerIconState extends State<AnimatedVideoPlayerIcon>
    with SingleTickerProviderStateMixin {
  final ColorTween colorTween =
      ColorTween(begin: SolhColors.primary_green, end: Colors.transparent);
  late Animation<Color?> colorAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    colorAnimation = colorTween.animate(animationController);
    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: colorAnimation,
      builder: (context, child) {
        return Icon(
          widget.iconChild,
          color: colorAnimation.value,
          size: 10.w,
        );
      },
    );
  }
}
