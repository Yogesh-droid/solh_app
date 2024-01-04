import 'package:chewie/chewie.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class MyCourseVideoPlayer extends StatefulWidget {
  const MyCourseVideoPlayer({super.key});

  @override
  State<MyCourseVideoPlayer> createState() => _MyCourseVideoPlayerState();
}

class _MyCourseVideoPlayerState extends State<MyCourseVideoPlayer> {
  late VideoPlayerController videoPlayerController;

  late ChewieController chewieController;

  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse("widget.url"))..initialize();

    chewieController = ChewieController(
        additionalOptions: null,
        draggableProgressBar: true,
        showOptions: false,
        allowedScreenSleep: false,
        autoInitialize: true,
        videoPlayerController: videoPlayerController,
        allowFullScreen: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Chewie(controller: chewieController),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
