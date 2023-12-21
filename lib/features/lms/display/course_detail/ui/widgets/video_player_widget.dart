import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget(
      {super.key, required this.url, required this.videoPlayerController});
  final String url;
  final VideoPlayerController videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(videoPlayerController);
  }
}
