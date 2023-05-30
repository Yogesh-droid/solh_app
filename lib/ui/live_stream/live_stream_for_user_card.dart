import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/live_stream/live-stream-controller.dart/live_stream_controller.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class LiveStreamForUserCard extends StatelessWidget {
  LiveStreamForUserCard({super.key});

  final LiveStreamController _liveStreamController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (_liveStreamController.isgettingStreamData.value
          ? getStreamShimmer()
          : _liveStreamController.liveStreamForUserModel.value.webinar == null
              ? Container()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    GetHelpDivider(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Streaming',
                          style: SolhTextStyles.QS_body_semi_1,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                          decoration: BoxDecoration(
                            color: SolhColors.primaryRed,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Live',
                            style: SolhTextStyles.Caption_2_semi.copyWith(
                              color: SolhColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.liveStream,
                            arguments: {
                              'appId': "4db2d5eea0c3466cb8dc7ba7f488dbef",
                              'title': _liveStreamController
                                  .liveStreamForUserModel.value.webinar!.title,
                              'channelName': _liveStreamController
                                  .liveStreamForUserModel
                                  .value
                                  .webinar!
                                  .channelName,
                              'token': _liveStreamController
                                  .liveStreamForUserModel.value.webinar!.token,
                              'isBroadcaster': false
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: _getThumbnailCard(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _getStreamInfo(_liveStreamController),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetHelpDivider(),
                  ]),
                ));
    });
  }
}

Widget _getThumbnailCard() {
  return Container(
    height: 28.h,
    width: 100.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      image: DecorationImage(
        fit: BoxFit.fill,
        image: NetworkImage(
          'https://picsum.photos/seed/picsum/300/200',
        ),
      ),
    ),
    child: FittedBox(
        fit: BoxFit.fill,
        child: Stack(
          children: [
            Container(
              width: 100.w,
              height: 28.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black38,
              ),
              child: Center(
                  child: Icon(
                CupertinoIcons.play_circle_fill,
                size: 15.w,
                color: SolhColors.primaryRed.withOpacity(0.7),
              )),
            )
          ],
        )),
  );
}

Widget _getStreamInfo(LiveStreamController liveStreamController) {
  return Container(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        liveStreamController.liveStreamForUserModel.value.webinar!.title ?? '',
        style: SolhTextStyles.QS_body_1_bold.copyWith(
            color: SolhColors.primary_green),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        liveStreamController
                .liveStreamForUserModel.value.webinar!.description ??
            '',
        style: SolhTextStyles.QS_cap_semi.copyWith(color: SolhColors.Grey_1),
      ),
      SizedBox(
        height: 10,
      ),
      _getHostsRow(liveStreamController),
    ]),
  );
}

Widget _getHostsRow(LiveStreamController liveStreamController) {
  return Row(
    children: [
      Row(
        children: [
          SimpleImageContainer(
            radius: 22,
            enableborder: true,
            borderWidth: 1,
            borderColor: SolhColors.grey_2,
            imageUrl: liveStreamController
                .liveStreamForUserModel.value.webinar!.host!.profilePicture!,
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            liveStreamController
                .liveStreamForUserModel.value.webinar!.host!.name!,
            style: SolhTextStyles.QS_caption_2_bold,
          ),
        ],
      ),
      SizedBox(
        width: 12,
      ),
      Row(children: [
        SimpleImageContainer(
          radius: 22,
          enableborder: true,
          borderWidth: 1,
          borderColor: SolhColors.grey_2,
          imageUrl: liveStreamController.liveStreamForUserModel.value.webinar!
              .otherHost![0].profilePicture!,
        ),
        SizedBox(
          width: 3,
        ),
        liveStreamController.liveStreamForUserModel.value.webinar!.otherHost !=
                    null ||
                liveStreamController
                    .liveStreamForUserModel.value.webinar!.otherHost!.isNotEmpty
            ? Text(
                liveStreamController
                    .liveStreamForUserModel.value.webinar!.otherHost![0].name!,
                style: SolhTextStyles.QS_caption_2_bold,
              )
            : Container(),
      ]),
      SizedBox(
        width: 15,
      ),
      liveStreamController.liveStreamForUserModel.value.webinar!.otherHost !=
                  null ||
              liveStreamController
                      .liveStreamForUserModel.value.webinar!.otherHost!.length >
                  1
          ? Text(
              '+${liveStreamController.liveStreamForUserModel.value.webinar!.otherHost!.length - 1} more',
              style: SolhTextStyles.QS_caption_2_bold,
            )
          : Container()
    ],
  );
}

Widget getStreamShimmer() {
  return Container(
    height: 60,
    width: double.infinity,
    child: Shimmer.fromColors(
      baseColor: SolhColors.grey239,
      highlightColor: SolhColors.dark_grey,
      child: Container(
        height: 60,
        width: double.infinity,
        color: SolhColors.grey239,
      ),
    ),
  );
}
