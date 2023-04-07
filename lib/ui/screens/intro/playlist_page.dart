import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/ui/screens/intro/video_tutorial_page.dart';
import '../../../controllers/video/video_tutorial_controller.dart';
import '../../../widgets_constants/appbars/app-bar.dart';
import '../../../widgets_constants/constants/textstyles.dart';

class VideoPlaylist extends StatelessWidget {
  VideoPlaylist({Key? key}) : super(key: key);
  final VideoTutorialController videoTutorialController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
            title: Text(
              'Video Playlist'.tr,
              style: SolhTextStyles.AppBarText,
            ),
            isLandingScreen: false),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(children: [
              Text(
                'Discover previously unknown features by learning more about Solh Features'
                    .tr,
                style: SolhTextStyles.JournalingHintText,
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => videoTutorialController.isLoadingPlaylist.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: videoTutorialController.videoPlaylist.value
                          .map((e) => Hero(
                                tag: e.sId ?? '',
                                child: VideoTile(
                                  title: e.title ?? '',
                                  description: e.description ?? '',
                                  videoThumb: e.videoThumbnail ?? '',
                                  playlistIcon: Icons.playlist_play_outlined,
                                  onTap: () {
                                    videoTutorialController
                                        .getVideolist(e.sId ?? '');
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (conext) {
                                      return VideoTutorialPage();
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
