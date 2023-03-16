import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:readmore/readmore.dart';
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
  // late TutorialList currentVideo;
  final VideoTutorialController videoTutorialController = Get.find();
  List<String> allVideoPlaylist = [];

  //List<TutorialList> remainingVideos = [];
  List<TutorialList> allVideos = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getVideosPlaylist();
    });
    videoTutorialController.currentVideo.value = widget.videoTutorialModel;
    controller = YoutubePlayerController(
        params: const YoutubePlayerParams(
      showControls: true,
      mute: false,
      showFullscreenButton: true,
      loop: false,
      enableCaption: true,
    ))
      ..onInit = () {
        controller.loadVideo(
            videoTutorialController.currentVideo.value.videoUrl ?? '');
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
                title: Text('Videos', style: SolhTextStyles.AppBarText),
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
          tag: Text(
            widget.videoTutorialModel.title ?? '',
            style: SolhTextStyles.QS_body_1_bold,
          ),
          child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              child: player),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 8.0, bottom: 8.0),
          child: Obx(() => Text(
                videoTutorialController.currentVideo.value.title ?? '',
                style: SolhTextStyles.QS_body_1_bold.copyWith(
                    color: SolhColors.primary_green),
              )),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 18.0, right: 18.0, bottom: 8.0),
                  child: Obx(() => ReadMoreText(
                        videoTutorialController
                                .currentVideo.value.description ??
                            '',
                        style: SolhTextStyles.QS_body_2_semi,
                        trimLines: 2,
                        trimMode: TrimMode.Line,
                      )),
                ),
                Divider(
                  color: SolhColors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Obx(() => ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: videoTutorialController.remainingVideos.length,
                      itemBuilder: (context, index) {
                        return VideoTile(
                          title: videoTutorialController
                                  .remainingVideos[index].title ??
                              '',
                          description: videoTutorialController
                                  .remainingVideos[index].description ??
                              '',
                          videoThumb: videoTutorialController
                                  .remainingVideos[index].videoThumbnail ??
                              '',
                          onTap: () {
                            controller.loadVideo(videoTutorialController
                                    .remainingVideos[index].videoUrl ??
                                '');
                            videoTutorialController.getRemainingVideos(
                                videoTutorialController.remainingVideos[index],
                                videoTutorialController.currentVideo.value);
                          },
                        );
                      })),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void getVideosPlaylist() {
    allVideos.addAll(videoTutorialController.videoList);
    allVideos.forEach((element) {
      allVideoPlaylist.add(element.videoUrl ?? '');
    });
    allVideos.remove(widget.videoTutorialModel);
    videoTutorialController.remainingVideos.clear();
    videoTutorialController.remainingVideos.addAll(allVideos);
    videoTutorialController.remainingVideos.refresh();
  }
}
