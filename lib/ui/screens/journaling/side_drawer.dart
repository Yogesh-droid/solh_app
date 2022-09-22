import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/ui/my_diary/my_diary_list_page.dart';
import 'package:solh/ui/screens/global-search/global_search_page.dart';
import 'package:solh/ui/screens/groups/manage_groups.dart';
import 'package:solh/ui/screens/journaling/widgets/side_drawer_menu_tile.dart';
import 'package:solh/ui/screens/mood-meter/mood_analytic_page.dart';
import 'package:solh/ui/screens/my-profile/appointments/appointment_screen.dart';
import 'package:solh/ui/screens/psychology-test/psychology_test_page.dart';
import '../../../bloc/user-bloc.dart';
import '../../../controllers/mood-meter/mood_meter_controller.dart';
import '../../../controllers/profile/appointment_controller.dart';
import '../../../model/user/user.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../../../widgets_constants/loader/my-loader.dart';
import '../../../widgets_constants/privacy_web.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final MoodMeterController moodMeterController = Get.find();
  BottomNavigatorController bottomNavigatorController = Get.find();
  AppointmentController appointmentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 78.w,
        child: Column(
          children: [
            StreamBuilder<UserModel?>(
                stream: userBlocNetwork.userStateStream,
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData)
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 2.5.h, horizontal: 3.8.w),
                      child: InkWell(
                        onTap: () {
                          bottomNavigatorController.isDrawerOpen.value = false;
                          bottomNavigatorController.tabrouter!
                              .setActiveIndex(4);
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 7.w,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 6.8.w,
                                backgroundImage: CachedNetworkImageProvider(
                                  userSnapshot.data!.profilePicture ??
                                      "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      userSnapshot.requireData!.name ?? "",
                                      style:
                                          TextStyle(color: Color(0xFF666666)),
                                    ),
                                    SizedBox(width: 1.5.w),
                                    GetBadge(
                                        userType:
                                            userSnapshot.requireData!.userType)

                                    // Text(
                                    //   userSnapshot.requireData!.userType ==
                                    //           'Normal'
                                    //       ? ''
                                    //       : userSnapshot.requireData!.userType ??
                                    //           "",
                                    //   style: TextStyle(
                                    //       height: 0.18.h,
                                    //       color: SolhColors.green,
                                    //       fontSize: 10),
                                    // ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  return Container(
                    child: MyLoader(),
                  );
                }),
            Container(
              height: 0.25.h,
              width: double.infinity,
              color: SolhColors.green,
            ),
            Column(children: [
              SideDrawerMenuTile(
                title: "Global Search",
                onPressed: () {
                  bottomNavigatorController.isDrawerOpen.value = false;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GlobalSearchPage()));
                },
              ),
              SideDrawerMenuTile(
                title: "My Diary",
                onPressed: () {
                  bottomNavigatorController.isDrawerOpen.value = false;
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
              userBlocNetwork.getUserType == 'SolhProvider'
                  ? Container()
                  : SideDrawerMenuTile(
                      title: "Appointments",
                      onPressed: () async {
                        appointmentController.getUserAppointments();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppointmentScreen()));
                      },
                    ),
              SideDrawerMenuTile(
                title: "Psychological Tests",
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PsychologyTestPage()));
                },
              ),
            ]),
            Expanded(
              child: Container(),
            ),
            Column(children: [
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
                                title: 'Privacy policy',
                                url: "https://solhapp.com/privacypolicy.html",
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
                          title: 'Terms and condtions'),
                    ),
                  );
                },
              ),
              SideDrawerMenuTile(
                title: "Give Feedback",
                isBottomMenu: true,
              ),
            ])
          ],
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
    return getBadge(_userType);
  }
}

Widget getBadge(String usertype) {
  switch (usertype) {
    case "SolhVolunteer":
      return Row(
        children: [
          Text(
            'Volunteer',
            style: GoogleFonts.signika(
              color: SolhColors.green,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          SvgPicture.asset('assets/images/verifiedTick.svg')
        ],
      );

    case "SolhProvider":
      return Row(
        children: [
          Text(
            'Counsellor',
            style: GoogleFonts.signika(
              color: SolhColors.green,
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
