import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/my_course_details/ui/controllers/my_course_detail_controller.dart';
import 'package:solh/features/lms/display/my_course_details/ui/widgets/my_course_content_section.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
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

  late ChewieController chewieController;
  var selectedPanelId = '';

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
            TabBar(
                indicatorColor: SolhColors.primary_green,
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
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: myCourseDetailController.sectionList
                        .map((e) => AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            child: selectedPanelId == e.id
                                ? ExpandedWidget(
                                    e: e,
                                    onTapped: (id) {
                                      setState(() {
                                        selectedPanelId = '';
                                      });
                                    },
                                    onLectureTapped: (lectures) {
                                      videoPlayerController.dispose();
                                      videoPlayerController =
                                          VideoPlayerController.networkUrl(
                                              Uri.parse(
                                                  lectures.contentData!.data ??
                                                      ''));
                                      chewieController.dispose();
                                      initializeChewie(videoPlayerController);
                                      setState(() {});
                                    })
                                : CollapsedWidget(
                                    e: e,
                                    onTapped: (id) {
                                      setState(() {
                                        selectedPanelId = id;
                                      });
                                    },
                                    percentage: e.progressStatus ?? 0,
                                  )))
                        .toList(),
                  )),
              Container()
            ]))
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
