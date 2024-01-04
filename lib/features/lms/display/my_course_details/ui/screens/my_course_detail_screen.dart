import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/my_course_details/ui/controllers/my_course_detail_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:video_player/video_player.dart';

class MyCourseDetailScreen extends StatefulWidget {
  const MyCourseDetailScreen({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  State<MyCourseDetailScreen> createState() => _MyCourseDetailScreenState();
}

class _MyCourseDetailScreenState extends State<MyCourseDetailScreen>
    with SingleTickerProviderStateMixin {
  final MyCourseDetailController myCourseDetailController = Get.find();
  late TabController tabController;

  late VideoPlayerController videoPlayerController;
  final List list = [
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
  ];

  late ChewieController chewieController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    myCourseDetailController.getMyCourseDetail(widget.args['id']);
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"));

    initializeChewie(videoPlayerController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
            title: SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(widget.args['name'] ?? "",
                  style: SolhTextStyles.QS_body_1_bold),
            ),
            isLandingScreen: false,
            isVideoCallScreen: true),
        body: Column(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.black),
              child: Chewie(controller: chewieController),
            ),
            TabBar.secondary(
                indicatorColor: Colors.grey,
                controller: tabController,
                tabs: const [
                  Tab(
                    child: Text(
                      "Lecture",
                      style: SolhTextStyles.CTA,
                    ),
                  ),
                  Tab(
                      child: Text(
                    "More",
                    style: SolhTextStyles.CTA,
                  ))
                ]),
            Expanded(
                child: TabBarView(controller: tabController, children: [
              ListView(
                children: myCourseDetailController.sectionList
                    .map((e) => ListTile(
                          title: Text(e.lectures![0].contentData!.data!),
                          onTap: () {
                            videoPlayerController.dispose();
                            videoPlayerController =
                                VideoPlayerController.networkUrl(Uri.parse(
                                    e.lectures![0].contentData!.data!));
                            chewieController.dispose();
                            initializeChewie(videoPlayerController);
                            setState(() {});
                          },
                        ))
                    .toList(),
              ),
              Container()
            ]))

            /* Expanded(
                child: ListView(
              children: list
                  .map((e) => ListTile(
                        title: Text(e),
                        onTap: () {
                          videoPlayerController.dispose();
                          videoPlayerController =
                              VideoPlayerController.networkUrl(Uri.parse(e));
                          chewieController.dispose();
                          initializeChewie(videoPlayerController);
                          setState(() {});
                        },
                      ))
                  .toList(),
            )) */
          ],
        ));
  }

  void initializeChewie(VideoPlayerController videoPlayerController) {
    chewieController = ChewieController(
        additionalOptions: null,
        draggableProgressBar: true,
        aspectRatio: 16 / 9,
        zoomAndPan: true,
        showOptions: false,
        allowedScreenSleep: false,
        autoInitialize: true,
        autoPlay: true,
        videoPlayerController: videoPlayerController,
        allowFullScreen: true);
  }
}
