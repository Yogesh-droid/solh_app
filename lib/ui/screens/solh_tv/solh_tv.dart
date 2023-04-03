import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

const List<String> _videoIds = [
  'tcodrIK2P_I',
  'H5v3kku4y6Q',
  'nPt8bK2gbaU',
  'K18cpp_-gP8',
  'iLnmTe5Q2Qw',
  '_WoCV4c6XOE',
  'KmzdUe0RSJo',
  '6jZDSSZZxjQ',
  'p2lYr3vM_1w',
  '7QUtEmBT_-w',
  '34_PXCzGw1M'
];

class SolhTv extends StatefulWidget {
  const SolhTv({Key? key}) : super(key: key);

  @override
  State<SolhTv> createState() => _SolhTvState();
}

class _SolhTvState extends State<SolhTv> {
  late YoutubePlayerController controller;
  @override
  void initState() {
    controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );
    controller.loadPlaylist(
      list: _videoIds,
      listType: ListType.playlist,
      startSeconds: 136,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Youtube Player IFrame Demo'),
              actions: const [VideoPlaylistIconButton()],
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return player;
              },
            ),
          );
        },
        controller: controller);
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}

class VideoPlaylistIconButton extends StatelessWidget {
  ///
  const VideoPlaylistIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.ytController;

    return IconButton(
      onPressed: () async {
        controller.pauseVideo();
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SizedBox(),
          ),
        );
        controller.playVideo();
      },
      icon: const Icon(Icons.playlist_play_sharp),
    );
  }
}
