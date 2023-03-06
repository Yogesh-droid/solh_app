import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/video/video_tutorial_controller.dart';
import 'package:solh/model/video_tutorial.dart';
import 'package:solh/ui/screens/intro/video_tutorial_detail_page.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class VideoTutorialPage extends StatelessWidget {
  VideoTutorialPage({Key? key}) : super(key: key);
  final VideoTutorialController videoTutorialController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
            title: Text(
              'Videos',
              style: SolhTextStyles.AppBarText,
            ),
            isLandingScreen: false),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(children: [
              Text(
                'Discover previously unknown features by learning more about Solh Features',
                style: SolhTextStyles.JournalingHintText,
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => videoTutorialController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: videoTutorialController.videoList.value
                          .map((e) => Hero(
                                tag: e.sId ?? '',
                                child: VideoTile(
                                  e: e,
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (conext) {
                                      return VideoDetailPage(
                                        videoTutorialModel: e,
                                      );
                                    }));
                                  },
                                ),
                              ))
                          .toList(),
                    ))
            ]),
          ),
        ));
  }
}

class VideoTile extends StatelessWidget {
  VideoTile({
    required this.e,
    required this.onTap,
  });
  final TutorialList e;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Card(
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: SolhColors.greyS200),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: e.videoThumbnail ?? '',
                          fit: BoxFit.fill,
                        ),
                      )),
                  Positioned(
                      child: Image.asset(
                    'assets/images/play_icon.png',
                    fit: BoxFit.fill,
                  )),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250,
                      child: Text(
                        e.title ?? '',
                        style: SolhTextStyles.QS_body_2_bold.copyWith(
                            color: SolhColors.primary_green),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 250,
                      child: Text(
                        e.description ?? '',
                        style: SolhTextStyles.QS_cap_semi,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
