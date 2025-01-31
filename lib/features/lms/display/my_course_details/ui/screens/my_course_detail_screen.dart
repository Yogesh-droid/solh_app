import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/my_course_details/ui/controllers/my_course_detail_controller.dart';
import 'package:solh/features/lms/display/my_course_details/ui/widgets/my_course_content_section.dart';
import 'package:solh/features/lms/display/my_course_details/ui/widgets/my_course_more_options.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:url_launcher/url_launcher.dart';
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

    getCourseDetail();

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
        body: Obx(() => myCourseDetailController.isLoading.value
            ? Hero(
                tag: "${widget.args['id']}",
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      Image.asset('assets/images/opening_link.gif'),
                  imageUrl: widget.args['thumbnail'],
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
              )
            : Column(
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
                  Padding(
                    padding: const EdgeInsets.only(left:8.0, right: 8.0, top:6.0, bottom:2.0),
                   child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Modules 1 - ${myCourseDetailController.sectionList.length}",
                          style: SolhTextStyles.CTA,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: TabBarView(controller: tabController, children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: myCourseDetailController.sectionList
                              .map((e) => AnimatedSize(
                                  duration: const Duration(milliseconds: 200),
                                  child: selectedPanelId == e.id
                                      ? ExpandedWidget(
                                          courseId: "${widget.args['id']}",
                                          e: e,
                                          onTapped: (id) {
                                            setState(() {
                                              selectedPanelId = '';
                                            });
                                          },
                                          onLectureTapped: (lectures) {
                                            if (lectures.contentType ==
                                                'video') {
                                              videoPlayerController.dispose();
                                              videoPlayerController =
                                                  VideoPlayerController
                                                      .networkUrl(Uri.parse(
                                                          lectures.contentData!
                                                                  .data ??
                                                              ''));
                                              chewieController.dispose();
                                              initializeChewie(
                                                  videoPlayerController);
                                              setState(() {});
                                            } else {
                                              launchUrl(Uri.parse(
                                                  lectures.contentData!.data!));
                                            }
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
                        ),
                      ),
                    ),
                    MyCourseMoreOptions(
                      courseId: widget.args['id'],
                    )
                  ]))
                ],
              )));
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

  Future<void> getCourseDetail() async {
    await myCourseDetailController.getMyCourseDetail(widget.args['id']);
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        myCourseDetailController
                .sectionList[0].lectures![0].contentData!.data ??
            ''));

    initializeChewie(videoPlayerController);
  }
}
