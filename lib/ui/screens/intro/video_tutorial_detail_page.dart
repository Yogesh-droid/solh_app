import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/video/video_tutorial_controller.dart';
import 'package:solh/model/video_tutorial.dart';
import 'package:solh/ui/screens/intro/video_tutorial_page.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoDetailPage extends StatefulWidget {
  VideoDetailPage({Key? key, required this.videoTutorialModel})
      : super(key: key);
  final TutorialList videoTutorialModel;

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late YoutubePlayerController controller;

  final VideoTutorialController videoTutorialController = Get.find();
  List<String> allVideoPlaylist = [];

  List<TutorialList> remainingVideos = [];

  @override
  void initState() {
    getRemainingVideos();
    controller = YoutubePlayerController(
        params: const YoutubePlayerParams(
      showControls: true,
      mute: false,
      showFullscreenButton: true,
      loop: false,
      enableCaption: true,
    ))
      ..onInit = () {
        controller.loadVideo(widget.videoTutorialModel.videoUrl ?? '');
      }
      ..onFullscreenChange = (isFullScreen) {
        print('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
      };
    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: controller,
      builder: (context, player) {
        return Scaffold(
            appBar: SolhAppBar(
                title:
                    Text('Video Tutorials', style: SolhTextStyles.AppBarText),
                isLandingScreen: false),
            body: getBody(player));
      },
    );
  }

  Widget getBody(Widget player) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: widget.videoTutorialModel.title ?? '',
          child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              child: player),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 18.0,
            right: 18.0,
            top: 8.0,
          ),
          child: Text(
            widget.videoTutorialModel.title ?? '',
            style: SolhTextStyles.GreenBorderButtonText,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 8.0),
          child: Text(
            widget.videoTutorialModel.description ?? '',
            style: SolhTextStyles.JournalingDescriptionText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Divider(
          color: SolhColors.grey,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: remainingVideos.length,
                itemBuilder: (context, index) {
                  return VideoTile(
                    e: remainingVideos[index],
                    onTap: () {},
                  );
                }),
          ),
        )
      ],
    );
  }

  void getRemainingVideos() {
    List<TutorialList> list = videoTutorialController.videoList.value;
    list.forEach((element) {
      allVideoPlaylist.add(element.videoUrl ?? '');
    });
    list.remove(widget.videoTutorialModel);
    remainingVideos.addAll(list);
  }
}
