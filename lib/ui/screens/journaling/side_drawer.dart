import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/controllers/video/video_tutorial_controller.dart';
import 'package:solh/ui/my_diary/my_diary_list_page.dart';
import 'package:solh/ui/screens/groups/manage_groups.dart';
import 'package:solh/ui/screens/intro/video_tutorial_page.dart';
import 'package:solh/ui/screens/journaling/widgets/side_drawer_menu_tile.dart';
import 'package:solh/ui/screens/mood-meter/mood_analytic_page.dart';
import 'package:solh/ui/screens/my-profile/appointments/appointment_screen.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../controllers/mood-meter/mood_meter_controller.dart';
import '../../../controllers/profile/appointment_controller.dart';
import '../../../routes/routes.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../../../widgets_constants/loader/my-loader.dart';
import '../../../widgets_constants/privacy_web.dart';

/* 
class SideDrawer extends StatefulWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}
 */
class SideDrawer extends StatelessWidget {
  final MoodMeterController moodMeterController = Get.find();
  BottomNavigatorController bottomNavigatorController = Get.find();
  AppointmentController appointmentController = Get.find();
  ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 78.w,
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: 78.w,
          child: Column(
            children: [
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 3.8.w),
                  child: Obx(() {
                    return profileController.isProfileLoading.value
                        ? Center(
                            child: MyLoader(),
                          )
                        : profileController.myProfileModel.value.body == null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: SolhColors.primary_green),
                                    child: IconButton(
                                        onPressed: () {
                                          profileController.getMyProfile();
                                        },
                                        icon: Icon(
                                          Icons.refresh,
                                          color: SolhColors.white,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Click to reload',
                                    style: SolhTextStyles.JournalingHintText,
                                  )
                                ],
                              )
                            : InkWell(
                                onTap: () {
                                  bottomNavigatorController.isDrawerOpen.value =
                                      false;
                                  bottomNavigatorController.activeIndex.value =
                                      4;
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 7.w,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 6.8.w,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          profileController.myProfileModel.value
                                                  .body!.user!.profilePicture ??
                                              "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hi, there",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              profileController.myProfileModel
                                                      .value.body!.user!.name ??
                                                  "",
                                              style: TextStyle(
                                                  color: Color(0xFF666666)),
                                            ),
                                            SizedBox(width: 1.5.w),
                                            GetBadge(
                                                userType: profileController
                                                        .myProfileModel
                                                        .value
                                                        .body!
                                                        .user!
                                                        .userType ??
                                                    '')
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ));
                  })),
              Container(
                height: 0.25.h,
                width: double.infinity,
                color: SolhColors.primary_green,
              ),
              Column(children: [
                SideDrawerMenuTile(
                  title: "My Diary",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyDiaryListPage()));
                  },
                ),
                SideDrawerMenuTile(
                  title: "Groups",
                  onPressed: () {
                    bottomNavigatorController.isDrawerOpen.value = false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageGroupPage()));
                  },
                ),
                SideDrawerMenuTile(
                  title: "Wheel of Emotions",
                  onPressed: () async {
                    moodMeterController.getMoodAnalytics(7);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoodAnalyticPage()));
                  },
                ),
                profileController.isProfileLoading.value
                    ? Container()
                    : profileController.myProfileModel.value.body != null
                        ? profileController.myProfileModel.value.body!.user!
                                    .userType ==
                                'SolhProvider'
                            ? Container()
                            : SideDrawerMenuTile(
                                title: "Appointments",
                                onPressed: () async {
                                  appointmentController.getUserAppointments();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AppointmentScreen()));
                                },
                              )
                        : Container(),
                SideDrawerMenuTile(
                  title: "Self Assessments",
                  onPressed: () async {
                    Navigator.pushNamed(context, AppRoutes.psychologyTest);
                  },
                ),
                SideDrawerMenuTile(
                  title: "Know Us More",
                  onPressed: () async {
                    Get.find<VideoTutorialController>().getVideolist();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoTutorialPage()));
                  },
                ),
              ]),
              Expanded(
                child: Container(),
              ),
              Column(
                children: [
                  SideDrawerMenuTile(
                    title: "Contact Us",
                    isBottomMenu: true,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyWeb(
                                    title: "Contact Us",
                                    url: "https://solhapp.com/contact-us.html",
                                  )));
                    },
                  ),
                  SideDrawerMenuTile(
                    title: "Privacy Policy",
                    isBottomMenu: true,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyWeb(
                                    title: 'Privacy Policy',
                                    url:
                                        "https://solhapp.com/privacypolicy.html",
                                  )));
                    },
                  ),
                  SideDrawerMenuTile(
                    title: "Terms of Use",
                    isBottomMenu: true,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivacyWeb(
                              url: 'https://solhapp.com/termsandcondition.html',
                              title: 'Terms and Conditions'),
                        ),
                      );
                    },
                  ),
                  SideDrawerMenuTile(
                    title: "Give Feedback",
                    isBottomMenu: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetBadge extends StatelessWidget {
  const GetBadge({Key? key, required userType})
      : _userType = userType,
        super(key: key);
  final _userType;

  @override
  Widget build(BuildContext context) {
    //return getBadge(_userType);
    return Container(
      child: getBadge(_userType),
    );
  }
}

Widget getBadge(String usertype) {
  switch (usertype) {
    case "SolhVolunteer":
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Volunteer',
            style: GoogleFonts.signika(
              color: SolhColors.primary_green,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          SvgPicture.asset('assets/images/verifiedTick.svg')
        ],
      );

    case "SolhProvider":
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Counsellor',
            style: GoogleFonts.signika(
              color: SolhColors.primary_green,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          SvgPicture.asset('assets/images/verifiedTick.svg')
        ],
      );

    default:
      return Container();
  }
}
