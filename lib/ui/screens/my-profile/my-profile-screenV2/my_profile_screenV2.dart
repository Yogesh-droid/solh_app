import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/mood-meter/mood_meter_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/journaling/side_drawer.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/edit_profile_option.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/setting.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/profile_completion_controller.dart';
import 'package:solh/ui/screens/profile-setupV2/profile-setup-controller/profile_setup_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../../widgets_constants/privacy_web.dart';
import '../../../my_diary/my_diary_list_page.dart';
import '../../groups/manage_groups.dart';
import '../../intro/playlist_page.dart';

class MyProfileScreenV2 extends StatelessWidget {
  MyProfileScreenV2({Key? key}) : super(key: key);

  final ProfileController profileController = Get.find();
  final ProfileCompletionController profileCompletionController =
      Get.put(ProfileCompletionController());
  final ProfileSetupController profileSetupController =
      Get.put(ProfileSetupController());

  @override
  Widget build(BuildContext context) {
    profileCompletionController.getAppRoute(0);
    return ScaffoldWithBackgroundArt(
      body: Obx(() {
        return profileController.isProfileLoading.value
            ? Center(
                child: MyLoader(),
              )
            : profileController.myProfileModel.value.body == null
                ? Container()
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Center(
                          child: Stack(
                            children: [
                              Positioned(
                                  left: 0,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        CupertinoIcons.chevron_back,
                                        color: SolhColors.grey,
                                      ))),
                              Positioned(
                                right: 0,
                                child: EditAndSettingOption(),
                              ),
                              Container(
                                width: double.maxFinite,
                                child: Column(
                                  children: [
                                    profileController
                                                .myProfileModel.value.body !=
                                            null
                                        ? InkWell(
                                            onTap: () {
                                              if (profileController
                                                  .myProfileModel
                                                  .value
                                                  .body!
                                                  .userMoveEmptyScreenEmpty!
                                                  .isNotEmpty) {
                                                profileCompletionController
                                                        .uncompleteFields =
                                                    profileController
                                                        .myProfileModel
                                                        .value
                                                        .body!
                                                        .userMoveEmptyScreenEmpty!;
                                                Navigator.pushNamed(
                                                    context,
                                                    profileCompletionController
                                                        .getAppRoute(
                                                            profileCompletionController
                                                                .uncompleteFields
                                                                .first),
                                                    arguments: {
                                                      "indexOfpage": 0
                                                    });
                                              }
                                            },
                                            child: ImageWithProgressBarAndBadge(
                                                imageRadius: Size(30.w, 30.w),
                                                percent: profileController
                                                        .myProfileModel
                                                        .value
                                                        .body!
                                                        .percentProfile ??
                                                    0,
                                                imageUrl: profileController
                                                        .myProfileModel
                                                        .value
                                                        .body!
                                                        .user!
                                                        .profilePicture ??
                                                    ''),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        NameUsertypeBio(
                          name: profileController
                                  .myProfileModel.value.body!.user!.name ??
                              '',
                          bio: profileController
                                  .myProfileModel.value.body!.user!.bio ??
                              '',
                          userType: profileController
                                  .myProfileModel.value.body!.user!.userType ??
                              '',
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        StatsRow(
                          like: profileController
                                  .myProfileModel.value.body!.user!.likes ??
                              0,
                          connections: profileController.myProfileModel.value
                              .body!.user!.connectionsList!.length,
                          posts: profileController
                                  .myProfileModel.value.body!.user!.posts ??
                              0,
                          reviews: profileController
                                  .myProfileModel.value.body!.user!.reviews ??
                              0,
                          psychlogicalCapital: profileController.myProfileModel
                                  .value.body!.user!.psychologicalCapital ??
                              0,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Obx(() {
                          return profileController.myProfileModel.value.body!
                                      .percentProfile ==
                                  100
                              ? Container()
                              : YouAreAlmostThere();
                        }),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        OptionsColumn()
                      ],
                    ),
                  );
      }),
    );
  }
}

class NameUsertypeBio extends StatelessWidget {
  NameUsertypeBio({Key? key, this.name = '', this.userType = '', this.bio = ''})
      : super(key: key);

  final String name;
  final String userType;
  final String bio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style:
              SolhTextStyles.QS_body_1_med.copyWith(color: SolhColors.black666),
        ),
        GetBadge(userType: userType),
        Text(
          bio,
          style: SolhTextStyles.QS_caption,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class StatsRow extends StatelessWidget {
  StatsRow(
      {Key? key,
      required this.like,
      required this.connections,
      required this.posts,
      required this.psychlogicalCapital,
      this.reviews})
      : super(key: key);
  final int like;
  final int connections;
  final int posts;
  final int? reviews;
  final int? psychlogicalCapital;

  final ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        getStatsItem(
            Icon(
              Icons.thumb_up,
              color: SolhColors.primary_green,
              size: 18,
            ),
            like.toString(),
            'Likes'.tr),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.connections);
          },
          child: getStatsItem(
              SvgPicture.asset(
                'assets/images/connect.svg',
              ),
              connections.toString(),
              'Connections'.tr),
        ),
        InkWell(
          onTap: (() {
            Navigator.pushNamed(context, AppRoutes.userPostScreen, arguments: {
              "sId": profileController.myProfileModel.value.body!.user!.sId!
            });
          }),
          child: getStatsItem(
              SvgPicture.asset(
                'assets/images/post.svg',
              ),
              posts.toString(),
              'Posts'.tr),
        ),
        InkWell(
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.activityBadgeParent),
          child: getCapitalItem(
              Icon(
                CupertinoIcons.money_dollar,
                size: 16,
                color: SolhColors.primary_green,
              ),
              psychlogicalCapital.toString(),
              'Capital'.tr),
        )
        // reviews != null
        //     ? getStatsItem(
        //         Icon(
        //           Icons.star,
        //           color: SolhColors.primary_green,
        //           size: 18,
        //         ),
        //         reviews!.toString(),
        //         'Reviews')
        //     : Container(),
      ],
    );
  }
}

Container getStatsItem(Widget icon, String statNumber, String stat) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
    decoration: BoxDecoration(
        color: SolhColors.light_Bg, borderRadius: BorderRadius.circular(4)),
    child: Column(
      children: [
        Row(
          children: [
            icon,
            SizedBox(
              width: 2.w,
            ),
            Text(
              statNumber,
              style: SolhTextStyles.QS_body_2,
            ),
          ],
        ),
        SizedBox(
          width: 1.h,
        ),
        Text(
          stat,
          style: SolhTextStyles.QS_caption,
        )
      ],
    ),
  );
}

Widget getCapitalItem(icon, statNumber, stat) {
  return Stack(
    children: [
      Shimmer.fromColors(
        baseColor: Color(0xffC29535),
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 50,
          width: 70,
          decoration: BoxDecoration(
              color: Color(0xffC29535), borderRadius: BorderRadius.circular(4)),
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        child: Padding(
            padding: EdgeInsets.all(2),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                  color: SolhColors.light_Bg,
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    statNumber,
                    style: SolhTextStyles.QS_body_2,
                  ),
                  SizedBox(
                    width: 1.h,
                  ),
                  Text(
                    stat,
                    style: SolhTextStyles.QS_caption,
                  )
                ],
              ),
            )),
      )
    ],
  );
}

class YouAreAlmostThere extends StatelessWidget {
  YouAreAlmostThere({Key? key}) : super(key: key);
  final ProfileController profileController = Get.find();
  final ProfileCompletionController profileCompletionController = Get.find();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (profileController
            .myProfileModel.value.body!.userMoveEmptyScreenEmpty!.isNotEmpty) {
          profileCompletionController.uncompleteFields = profileController
              .myProfileModel.value.body!.userMoveEmptyScreenEmpty!;
          Navigator.pushNamed(
              context,
              profileCompletionController.getAppRoute(
                  profileCompletionController.uncompleteFields.first),
              arguments: {"indexOfpage": 0});
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: SolhColors.greenShade3,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You are almost there'.tr,
                      style: SolhTextStyles.QS_body_1_bold,
                    ),
                    SizedBox(
                      width: 40.w,
                      child: Text(
                        "The details matter. Let's take your profile from good to great."
                            .tr,
                        style: SolhTextStyles.QS_cap_2_semi,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_circle_right,
                color: SolhColors.primary_green,
                size: 36,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OptionsColumn extends StatelessWidget {
  OptionsColumn({Key? key}) : super(key: key);
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (() {
            Navigator.pushNamed(context, AppRoutes.userPostScreen, arguments: {
              "sId": profileController.myProfileModel.value.body!.user!.sId!
            });
          }),
          child: getOption(
              SvgPicture.asset(
                'assets/images/post.svg',
                height: 15,
              ),
              'Posts'.tr),
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.appointmentPage,
                arguments: {});
          },
          child: getOption(
              Icon(
                Icons.calendar_month_rounded,
                color: SolhColors.primary_green,
                size: 20,
              ),
              'Sessions & Packages'.tr),
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            Get.find<MoodMeterController>().getMoodAnalytics(7);
            Navigator.pushNamed(context, AppRoutes.moodAnalytics,
                arguments: {});
          },
          child: getOption(
              SvgPicture.asset(
                'assets/images/wheelOfEmotions.svg',
                height: 20,
              ),
              'Wheel of Emotions'.tr),
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            Get.find<MoodMeterController>().getMoodAnalytics(7);
            Navigator.pushNamed(context, AppRoutes.activityBadgeParent,
                arguments: {});
          },
          child: getOption(
              Container(
                height: 13,
                child: SvgPicture.asset(
                  'assets/images/activity_log.svg',
                  height: 20,
                ),
              ),
              'Activity Log'.tr),
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyDiaryListPage()));
          },
          child: getOption(
              Container(
                height: 13,
                child: SvgPicture.asset(
                  'assets/images/myDiary.svg',
                  height: 20,
                ),
              ),
              "My Diary".tr),
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ManageGroupPage()));
          },
          child: getOption(
              Container(
                height: 13,
                child: SvgPicture.asset(
                  'assets/images/groups.svg',
                  height: 20,
                ),
              ),
              "Groups".tr),
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.psychologyTest);
          },
          child: getOption(
              Container(
                height: 13,
                child: SvgPicture.asset(
                  'assets/images/appointment.svg',
                  height: 20,
                ),
              ),
              "Self Assessments".tr),
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VideoPlaylist()));
          },
          child: getOption(
              Container(
                height: 13,
                child: SvgPicture.asset(
                  'assets/images/psycotests.svg',
                  height: 20,
                ),
              ),
              "Know Us More".tr),
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyWeb(
                                title: "Contact Us".tr,
                                url: "https://solhapp.com/contact-us.html",
                              )));
                },
                child: Text(
                  "Help".tr,
                  style: SolhTextStyles.CTA
                      .copyWith(decoration: TextDecoration.underline),
                )),
            getGreenRoundDot(),
            TextButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PrivacyWeb(
                  //               title: "Contact Us".tr,
                  //               url: "https://solhapp.com/contact-us.html",
                  //             )));
                },
                child: Text(
                  "Feedback".tr,
                  style: SolhTextStyles.CTA
                      .copyWith(decoration: TextDecoration.underline),
                )),
            getGreenRoundDot(),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyWeb(
                                title: 'Privacy Policy'.tr,
                                url: "https://solhapp.com/privacypolicy.html",
                              )));
                },
                child: Text(
                  "Policies".tr,
                  style: SolhTextStyles.CTA
                      .copyWith(decoration: TextDecoration.underline),
                )),
            getGreenRoundDot(),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyWeb(
                                title: "Terms of Use".tr,
                                url:
                                    'https://solhapp.com/termsandcondition.html',
                              )));
                },
                child: Text(
                  "Terms of Use".tr,
                  style: SolhTextStyles.CTA
                      .copyWith(decoration: TextDecoration.underline),
                ))
          ],
        )
      ],
    );
  }
}

Container getGreenRoundDot() {
  return Container(
    height: 8,
    width: 8,
    decoration:
        BoxDecoration(shape: BoxShape.circle, color: SolhColors.primary_green),
  );
}

Container getOption(Widget icon, String option) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: BoxDecoration(
        color: SolhColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: SolhColors.grey_3)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            icon,
            SizedBox(
              width: 4,
            ),
            Text(
              option,
              style: SolhTextStyles.QS_body_2_bold,
            )
          ],
        ),
        Icon(
          Icons.arrow_forward_ios_sharp,
          color: SolhColors.Grey_1,
          size: 15,
        )
      ],
    ),
  );
}

class EditAndSettingOption extends StatelessWidget {
  const EditAndSettingOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: (() {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfileOptions()));
          }),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: SolhColors.light_Bg,
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.pen,
                size: 24,
                color: SolhColors.primary_green,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        InkWell(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Setting())),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: SolhColors.light_Bg,
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.settings,
                color: SolhColors.primary_green,
                size: 24,
              ),
            ),
          ),
        )
      ],
    );
  }
}
