import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewWidget extends StatefulWidget {
  const VideoPreviewWidget({super.key, required this.url});
  final String url;

  @override
  State<VideoPreviewWidget> createState() => _VideoPreviewWidgetState();
}

class _VideoPreviewWidgetState extends State<VideoPreviewWidget>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController videoPlayerController;

  late AnimationController controller;
  late Animation<double> animation;
  late ChewieController chewieController;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween<double>(begin: 0.0, end: 1).animate(controller);

    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url))..initialize();

    chewieController = ChewieController(
        additionalOptions: null,
        draggableProgressBar: true,
        showOptions: false,
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
}
