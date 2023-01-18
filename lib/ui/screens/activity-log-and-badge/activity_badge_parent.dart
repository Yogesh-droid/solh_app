import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/activity-log-and-badge/activity-log/activity-log-controller/activity_log_controller.dart';
import 'package:solh/ui/screens/activity-log-and-badge/activity-log/activity_log.dart';
import 'package:solh/ui/screens/activity-log-and-badge/badges/badge_screen.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ActivityBadgeParent extends StatefulWidget {
  const ActivityBadgeParent({Key? key}) : super(key: key);

  @override
  State<ActivityBadgeParent> createState() => _ActivityBadgeParentState();
}

class _ActivityBadgeParentState extends State<ActivityBadgeParent>
    with TickerProviderStateMixin {
  ActivityLogContoller activityLogContoller = Get.put(ActivityLogContoller());
  // late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    activityLogContoller.getActivityLogController();

    // _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text(''),
      ),
      body: SizedBox(
        height: 100.h,
        child: Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 60.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Psychological Capital',
                          style: SolhTextStyles.QS_big_body.copyWith(
                            color: SolhColors.dark_grey,
                          ),
                        ),
                        Text(
                          '''This is a grand total based on your Engagement on the app''',
                          textAlign: TextAlign.start,
                          style: SolhTextStyles.QS_caption,
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Obx(() {
                        return activityLogContoller.isActivityLogLoading.value
                            ? ButtonLoadingAnimation(
                                ballColor: SolhColors.primary_green,
                                ballSizeLowerBound: 3,
                                ballSizeUpperBound: 8,
                              )
                            : Text(
                                activityLogContoller.activityLogModel.value
                                    .result!.psychologicalCapital
                                    .toString(),
                                style: SolhTextStyles.QS_head_4,
                              );
                      }),
                      Text(
                        'Your Capital',
                        style: SolhTextStyles.QS_cap_2_semi.copyWith(
                            color: SolhColors.Grey_1),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(child: ActivityLogScreen()),

            // Column(
            //   children: [
            //     Divider(),

            //     // TabBar(
            //     //     indicatorColor: SolhColors.primary_green,
            //     //     controller: _tabController,
            //     //     onTap: ((value) {
            //     //       setState(() {});
            //     //     }),
            //     //     tabs: [
            //     //       Padding(
            //     //         padding: const EdgeInsets.symmetric(vertical: 8),
            //     //         child: Text(
            //     //           'Activity',
            //     //           style: SolhTextStyles.QS_body_1_bold.copyWith(
            //     //               color: _tabController.index == 0
            //     //                   ? SolhColors.primary_green
            //     //                   : SolhColors.Grey_1),
            //     //         ),
            //     //       ),
            //     //       Padding(
            //     //         padding: const EdgeInsets.symmetric(vertical: 8),
            //     //         child: Text(
            //     //           'Badges',
            //     //           style: SolhTextStyles.QS_body_1_bold.copyWith(
            //     //               color: _tabController.index == 1
            //     //                   ? SolhColors.primary_green
            //     //                   : SolhColors.Grey_1),
            //     //         ),
            //     //       )
            //     //     ]),
            //   ],
            // ),

            // Expanded(
            //   child: TabBarView(controller: _tabController, children: [
            //     ActivityLogScreen(),
            //     BadgesScreen(),
            //   ]),
            // )
          ],
        ),
      ),
    );
  }

  // @override
  // // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => true;
}
