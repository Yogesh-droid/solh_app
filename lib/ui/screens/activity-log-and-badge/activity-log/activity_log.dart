import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/ui/screens/activity-log-and-badge/activity-log/activity-log-controller/activity_log_controller.dart';
import 'package:solh/widgets_constants/animated_refresh_container.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

String lastDate = '';

class ActivityLogScreen extends StatefulWidget {
  const ActivityLogScreen({Key? key}) : super(key: key);

  @override
  State<ActivityLogScreen> createState() => _ActivityLogScreenState();
}

class _ActivityLogScreenState extends State<ActivityLogScreen> {
  final ActivityLogContoller activityLogContoller = Get.find();
  final ProfileController profileController = Get.find();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    lastDate = '';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getMoreLogs();
    });

    super.initState();
  }

  @override
  void dispose() {
    activityLogContoller.firstLoadDone.value = true;
    activityLogContoller.pageNumber = 1;
    super.dispose();
  }

  getMoreLogs() {
    scrollController.addListener(() {
      print(
          activityLogContoller.activityLogModel.value.result!.next.toString());
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          activityLogContoller.activityLogModel.value.result!.next != null) {
        print('fetching');
        activityLogContoller.isFeatchingMoreLog.value = true;
        activityLogContoller.pageNumber++;
        activityLogContoller.getActivityLogController();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return activityLogContoller.isActivityLogLoading.value &&
              activityLogContoller.firstLoadDone.value == false
          ? Center(
              child: MyLoader(),
            )
          : Stack(
              children: [
                Container(
                  width: 100.w,
                  child: Image.asset('assets/images/ScaffoldBackgroundArt.png',
                      fit: BoxFit.fitWidth),
                ),
                SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Obx(() {
                        lastDate = '';
                        return activityLogContoller.firstLoadDone.value ==
                                    true &&
                                activityLogContoller.isActivityLogLoading.value
                            ? AnimatedRefreshContainer()
                            : Container();
                      }),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10),
                        itemCount: activityLogContoller
                            .activityLogModel.value.result!.activityLog!.length,
                        itemBuilder: (context, index) {
                          return getListItem(
                            activityLogContoller.activityLogModel.value.result!
                                .activityLog![index].createdAt,
                            activityLogContoller.activityLogModel.value.result!
                                .activityLog![index].content,
                            activityLogContoller.activityLogModel.value.result!
                                .activityLog![index].subContent,
                            activityLogContoller.activityLogModel.value.result!
                                .activityLog![index].activityType,
                            activityLogContoller.activityLogModel.value.result!
                                .activityLog![index].anonymously,
                            profileController,
                            activityLogContoller.activityLogModel.value.result!
                                .activityLog![index].activityPoints,
                          );
                        },
                      ),
                      Obx(() {
                        return activityLogContoller.isFeatchingMoreLog.value
                            ? Column(
                                children: [
                                  ButtonLoadingAnimation(
                                    ballColor: SolhColors.primary_green,
                                    ballSizeLowerBound: 3,
                                    ballSizeUpperBound: 10,
                                  ),
                                  SizedBox(
                                    height: 24,
                                  )
                                ],
                              )
                            : Container();
                      })
                    ],
                  ),
                ),
              ],
            );
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

Widget getListItem(var time, content, subContent, activityType, isAnon,
    ProfileController profileController, activityPoints) {
  var date = DateTime.fromMillisecondsSinceEpoch(time);
  var date12 = DateFormat('MM/dd/yyyy').format(date);

  if (lastDate == '') {
    lastDate = date12;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getDay(date),
                  style: SolhTextStyles.QS_big_body_med_20.copyWith(
                      color: SolhColors.Grey_1),
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 10,
                //     vertical: 5,
                //   ),
                //   decoration: BoxDecoration(
                //       border:
                //           Border.all(color: SolhColors.primary_green, width: 2),
                //       borderRadius: BorderRadius.circular(18)),
                //   child: Row(
                //     children: [
                //       Icon(
                //         CupertinoIcons.slider_horizontal_3,
                //         color: SolhColors.primary_green,
                //       ),
                //       Text('Filter',
                //           style: SolhTextStyles.CTA.copyWith(
                //             color: SolhColors.primary_green,
                //           )),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
        Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  getIcon(activityType, true),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            content,
                            style: SolhTextStyles.QS_caption_bold,
                          ),
                          Container(
                            width: 50.w,
                            child: Text(
                              subContent,
                              style: SolhTextStyles.QS_caption,
                            ),
                          ),
                          Text(
                            '${timeago.format(date).toString()} ',
                            style: SolhTextStyles.QS_cap_2,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.arrow_down_left,
                    color: SolhColors.primary_green,
                    size: 16,
                  ),
                  Stack(
                    children: [
                      Image.asset('assets/images/dollar_background.png'),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: Center(
                          child: Text(
                            activityPoints.toString(),
                            style: SolhTextStyles.QS_cap_semi.copyWith(
                                color: SolhColors.black),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  } else if (lastDate != date12) {
    lastDate = date12;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            child: Text(
              getDay(date),
              style: SolhTextStyles.QS_big_body_med_20.copyWith(
                  color: SolhColors.Grey_1),
            ),
          ),
        ),
        getLogItem(time, content, subContent, activityType, isAnon,
            profileController, activityPoints),
      ],
    );
  } else {
    lastDate = date12;
    return getLogItem(time, content, subContent, activityType, isAnon,
        profileController, activityPoints);
  }
}

String getDay(DateTime date) {
  if (DateFormat('MM/dd/yyyy').format(date) ==
      DateFormat('MM/dd/yyyy').format(DateTime.now())) {
    return 'Today';
  } else if (DateFormat('MM/dd/yyyy')
          .format(DateTime.now().subtract(Duration(days: 1))) ==
      DateFormat('MM/dd/yyyy').format(date)) {
    return 'Yesterday';
  } else {
    return DateFormat('dd-MMMM-yyyy').format(date);
  }
}

Container getIcon(String activityType, bool timelineCurved) {
  return Container(
    height: 80,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: Column(
            children: [
              Container(
                height: 80,
                width: 4,
                decoration: BoxDecoration(
                  color: SolhColors.grey_2,
                  borderRadius: BorderRadius.only(
                    topLeft: timelineCurved
                        ? Radius.circular(8)
                        : Radius.circular(0),
                    topRight: timelineCurved
                        ? Radius.circular(8)
                        : Radius.circular(0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 11.w,
            width: 11.w,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: SolhColors.white,
            ),
            child: Center(
              child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: SolhColors.primary_green),
                  child: getContainerIcon(activityType)),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget getLogItem(var time, content, subContent, activityType, isAnon,
    ProfileController profileController, activityPoints) {
  var date = DateTime.fromMillisecondsSinceEpoch(time);

  return Container(
    height: 80,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            getIcon(activityType, false),
            SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      content,
                      style: SolhTextStyles.QS_caption_bold,
                    ),
                    Container(
                      width: 50.w,
                      child: Text(
                        subContent,
                        style: SolhTextStyles.QS_caption,
                      ),
                    ),
                    Text(
                      '${timeago.format(date).toString()} ',
                      style: SolhTextStyles.QS_cap_2,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              CupertinoIcons.arrow_down_left,
              color: SolhColors.primary_green,
              size: 16,
            ),
            Stack(
              children: [
                Image.asset('assets/images/dollar_background.png'),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Center(
                    child: Text(
                      activityPoints.toString(),
                      style: SolhTextStyles.QS_cap_semi.copyWith(
                          color: SolhColors.black),
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ],
    ),
  );
}

Widget getContainerIcon(String activityType) {
  if (activityType == "like") {
    return Center(
      child: SvgPicture.asset(
        'assets/images/thumbs_up.svg',
        color: SolhColors.white,
        height: 6.w,
      ),
    );
  } else if (activityType == "comment") {
    return SvgPicture.asset(
      "assets/icons/journaling/post-comment.svg",
      width: 17,
      height: 17,
      color: SolhColors.white,
    );
  } else if (activityType == "journal") {
    return SvgPicture.asset(
      'assets/images/post.svg',
      color: SolhColors.white,
      height: 6.w,
    );
  } else if (activityType == "bestComment") {
    return SvgPicture.asset(
      'assets/images/star.svg',
      color: SolhColors.white,
      height: 6.w,
    );
  } else if (activityType == "group") {
    return Icon(
      CupertinoIcons.group,
      color: SolhColors.white,
      size: 16,
    );
  } else if (activityType == "appointment") {
    return SvgPicture.asset(
      'assets/images/person_square.svg',
      color: SolhColors.white,
      height: 6.w,
    );
  } else if (activityType == "connection") {
    return Icon(
      CupertinoIcons.arrow_down,
      color: SolhColors.white,
      size: 16,
    );
  } else if (activityType == "psychometricTest") {
    return Icon(
      CupertinoIcons.doc_text_search,
      color: SolhColors.white,
      size: 16,
    );
  } else {
    return Container();
  }
}
