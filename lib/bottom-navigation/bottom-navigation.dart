import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/mood-meter/mood_meter_controller.dart';
import 'package:solh/ui/screens/chat/chat.dart';
import 'package:solh/ui/screens/live_stream/live-stream-controller.dart/live_stream_controller.dart';
import 'package:solh/ui/screens/my-profile/appointments/controller/appointment_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/home/homescreen.dart';
import 'package:solh/ui/screens/journaling/journaling.dart';
import 'package:solh/ui/screens/my-goals/my-goals-screen.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/my_profile_screenV2.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/app_rating_status.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/live_blink.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';
import '../controllers/connections/connection_controller.dart';
import '../controllers/getHelp/book_appointment.dart';
import '../controllers/getHelp/get_help_controller.dart';
import '../controllers/group/discover_group_controller.dart';
import '../controllers/journals/journal_page_controller.dart';
import '../routes/routes.dart';
import '../widgets_constants/constants/textstyles.dart';
import '../widgets_constants/loader/my-loader.dart';
import 'bottom_navigator_controller.dart';

class MasterScreen extends StatelessWidget {
  MasterScreen({Key? key}) : super(key: key);
  //ProfileController profileController = Get.put(ProfileController());

  final BookAppointmentController bookAppointment =
      Get.put(BookAppointmentController());
  final MoodMeterController moodMeterController =
      Get.put(MoodMeterController());
  final BottomNavigatorController bottomNavigatorController =
      Get.put(BottomNavigatorController());
  final JournalPageController journalPageController =
      Get.put(JournalPageController());
  final DiscoverGroupController discoverGroupController =
      Get.put(DiscoverGroupController());
  final ConnectionController connectionController =
      Get.put(ConnectionController());
  final AppointmentController appointmentController =
      Get.put(AppointmentController());
  final GetHelpController getHelpController = Get.put(GetHelpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: MasterScreen2(),
        // child: Stack(
        //   children: [
        //     SideDrawer(),
        //     MasterScreen2(),
        //   ],
        // ),
      ),
    );
  }
}

class MasterScreen2 extends StatefulWidget {
  @override
  State<MasterScreen2> createState() => _MasterScreen2State();
}

class _MasterScreen2State extends State<MasterScreen2>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final JournalPageController journalPageController =
      Get.put(JournalPageController());
  final MoodMeterController meterController = Get.find();
  final BottomNavigatorController bottomNavigatorController = Get.find();
  ProfileController profileController = Get.find();
  final LiveStreamController liveStreamController = Get.find();

  final MoodMeterController moodMeterController =
      Get.put(MoodMeterController());

  late TabController tabController;
  late AnimationController animationController;
  PersistentBottomSheetController? persistentBottomSheetController;

  List<Widget> bottomWidgetList = [];

  @override
  void initState() {
    print('init master');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.getMyProfile();
    });
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    bottomWidgetList.addAll([
      HomeScreen(),
      Journaling(),
      GetHelpScreen(),
      MyGoalsScreen(),
      // MyProfileScreenV2()
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: Scaffold(
          key: _scaffoldKey,
          appBar: SolhAppBar(
            title: getDrawer(),
            isLandingScreen: true,
          ),
          body: Obx(() => IndexedStack(
              index: bottomNavigatorController.activeIndex.value,
              children: bottomWidgetList)),
          bottomNavigationBar: getBottomBar(context)),
      /* child: Obx(() {
      return AnimatedPositioned(
        duration: Duration(milliseconds: 300),
        left: bottomNavigatorController.isDrawerOpen.value ? 78.w : 0,
        child: Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  offset: const Offset(
                    14.0,
                    14.0,
                  ),
                  blurRadius: 20.0,
                  spreadRadius: 4.0,
                )
              ],
              color: Colors.white),
          child: Scaffold(
              appBar: SolhAppBar(
                title: getDrawer(),
                isLandingScreen: true,
              ),
              body: IndexedStack(
                  index: bottomNavigatorController.activeIndex.value,
                  children: bottomWidgetList),
              /* Obx(
                () => Stack(
                  children: [
                    IgnorePointer(
                      ignoring: bottomNavigatorController.isDrawerOpen.value,
                      child: IndexedStack(
                          index: bottomNavigatorController.activeIndex.value,
                          children: bottomWidgetList),
                    ),
                    bottomNavigatorController.isDrawerOpen.value
                        ? GestureDetector(
                            onHorizontalDragStart: (details) {
                              //print(details.globalPosition.direction);
                              bottomNavigatorController.isDrawerOpen.value =
                                  false;
                              animationController.reverse();
                            },
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.transparent),
                            ),
                          )
                        : SizedBox(
                            height: 0,
                            width: 0,
                          ),
                  ],
                ),
              ), */
              bottomNavigationBar: getBottomBar(context)),
        ),
      );
    }) */
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    if (bottomNavigatorController.isDrawerOpen.value) {
      return Future.value(false);
    } else if (bottomNavigatorController.activeIndex != 0) {
      bottomNavigatorController.activeIndex.value = 0;
      return Future.value(false);
    } else {
      return await showDialog(
          context: context,
          builder: (context) {
            return Stack(
              children: [
                AlertDialog(
                  actionsPadding: EdgeInsets.all(8.0),
                  content: Text(
                    'Do you really want to exit app?'.tr,
                    style: SolhTextStyles.JournalingDescriptionText,
                  ),
                  actions: [
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Yes'.tr,
                            style: SolhTextStyles.CTA
                                .copyWith(color: SolhColors.primaryRed),
                          ),
                        ),
                        onTap: () {
                          exit(0);
                        }),
                    SizedBox(width: 30),
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'No'.tr,
                            style: SolhTextStyles.CTA
                                .copyWith(color: SolhColors.primary_green),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(false);
                        }),
                  ],
                ),
                bottomNavigatorController.shouldShowFeedbackForm
                    ? AlertDialog(content: feedbackForm())
                    : Container(),
              ],
            );
          });
    }
  }

  Widget getStarsRow() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          5,
          (index) => InkWell(
            onTap: () {
              setState(() {
                bottomNavigatorController.givenStars.value = index;
              });
            },
            child: Icon(
              bottomNavigatorController.givenStars.value < index
                  ? Icons.star_border
                  : Icons.star,
              size: 10.w,
              color: Color(0xfff0ba00),
            ),
          ),
        ),
      );
    });
  }

  Widget feedbackForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(8)),
          child: Text(
            'Those who support us want to know if we are supporting you well. Please review us and give feedback.',
            style: SolhTextStyles.QS_body_2_semi,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        getStarsRow(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
        SizedBox(
          height: 3.h,
        ),
        TextField(
          controller: bottomNavigatorController.feedbackTextEditingController,
          maxLines: 5,
          minLines: 2,
          decoration: TextFieldStyles.greenF_greyUF_4R.copyWith(
            hintText: 'Your feedback :)'.tr,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: SolhColors.grey_3,
                width: 1.0,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Obx(() => bottomNavigatorController.isSubmittingFeedback.value
            ? SolhGreenButton(
                child: ButtonLoadingAnimation(
                ballColor: SolhColors.white,
              ))
            : SolhGreenButton(
                onPressed: () async {
                  if (bottomNavigatorController.givenStars.value != 0) {
                    await bottomNavigatorController.submitRating({
                      "rating": (bottomNavigatorController.givenStars.value + 1)
                          .toString(),
                      "feedBackComment": bottomNavigatorController
                          .feedbackTextEditingController.text
                          .trim(),
                    });
                    exit(0);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Submit',
                  style: SolhTextStyles.CTA.copyWith(
                    color: SolhColors.white,
                  ),
                ),
              )),
      ],
    );
  }

  Widget getBottomBar(BuildContext context) {
    return Row(children: [
      Obx(() => SizedBox(
            width: MediaQuery.of(context).size.width - 70,
            child: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              currentIndex: bottomNavigatorController.activeIndex.value,
              showUnselectedLabels: true,
              selectedItemColor: SolhColors.primary_green,
              unselectedItemColor: SolhColors.dark_grey,
              selectedLabelStyle: SolhTextStyles.QS_cap_semi,
              onTap: (index) {
                if (persistentBottomSheetController != null) {
                  persistentBottomSheetController!.close();
                }
                bottomNavigatorController.activeIndex.value = index;
                switch (index) {
                  case 0:
                    if (persistentBottomSheetController != null) {
                      persistentBottomSheetController!.close();
                    }
                    FirebaseAnalytics.instance.logEvent(
                        name: 'HomePageOpen',
                        parameters: {'Page': 'HomeScreen'});
                    break;
                  case 1:
                    if (persistentBottomSheetController != null) {
                      persistentBottomSheetController!.close();
                    }
                    FirebaseAnalytics.instance.logEvent(
                        name: 'JournalingOpened',
                        parameters: {'Page': 'Journaling'});
                    break;
                  case 2:
                    if (persistentBottomSheetController != null) {
                      persistentBottomSheetController!.close();
                    }
                    FirebaseAnalytics.instance.logEvent(
                        name: 'GetHelpOpened', parameters: {'Page': 'GetHelp'});
                    break;
                  case 3:
                    if (persistentBottomSheetController != null) {
                      persistentBottomSheetController!.close();
                    }
                    FirebaseAnalytics.instance.logEvent(
                        name: 'MyGoalPageOpened',
                        parameters: {'Page': 'My Goal'});
                    break;
                  // case 4:
                  //   FirebaseAnalytics.instance.logEvent(
                  //       name: 'MyProfileOpened', parameters: {'Page': 'MyProfile'});
                  //   break;
                  default:
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Obx(
                    () => bottomNavigatorController.activeIndex.value == 0
                        ? SvgPicture.asset('assets/images/home_solid.svg')
                        : SvgPicture.asset('assets/images/home_outlined.svg'),
                  ),
                  label: "Home".tr,
                ),
                BottomNavigationBarItem(
                  icon: Obx(
                    () => bottomNavigatorController.activeIndex.value == 1
                        ? SvgPicture.asset(
                            'assets/images/journaling.svg',
                            height: 18,
                          )
                        : SvgPicture.asset(
                            'assets/images/journalling outline.svg',
                            height: 18,
                          ),
                  ),
                  label: "Journaling".tr,
                ),
                getHelpItem(),
                BottomNavigationBarItem(
                    icon: Obx(() => SvgPicture.asset(
                          'assets/images/groal tab vector.svg',
                          color:
                              bottomNavigatorController.activeIndex.value == 3
                                  ? SolhColors.primary_green
                                  : Colors.grey.shade600,
                        )),
                    label: "My Goals".tr),
                // BottomNavigationBarItem(
                //     icon: Obx(() => SvgPicture.asset(
                //           'assets/images/profile.svg',
                //           color: bottomNavigatorController.activeIndex.value == 4
                //               ? SolhColors.primary_green
                //               : Colors.grey.shade600,
                //         )),
                //     label: "My Profile".tr)
              ],
            ),
          )),
      Expanded(
          child: InkWell(
        onTap: () {
          openMoreSheet(context);
        },
        child: SafeArea(
          child: Container(
              color: Color.fromARGB(255, 247, 247, 247),
              height: 60,
              width: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    color: Colors.grey.shade600,
                  ),
                  Obx(() {
                    return liveStreamController
                                .liveStreamForUserModel.value.webinar ==
                            null
                        ? Text(
                            "More".tr,
                            style: TextStyle(fontSize: 12),
                          )
                        : LiveBlink();
                  }),
                ],
              )),
        ),
      ))
    ]);
  }

  BottomNavigationBarItem getHelpItem() {
    return BottomNavigationBarItem(
        icon: Obx(() {
          return profileController.isProfileLoading.value ||
                  profileController.myProfileModel.value.body == null
              ? bottomNavigatorController.activeIndex.value == 2
                  ? SvgPicture.asset("assets/images/get help tab.svg")
                  : SvgPicture.asset(
                      "assets/images/get help. outline.svg",
                    )
              : profileController.myProfileModel.value.body!.user!.userType ==
                      'SolhProvider'
                  ? Icon(
                      CupertinoIcons.calendar_badge_plus,
                      color: bottomNavigatorController.activeIndex.value == 2
                          ? SolhColors.primary_green
                          : SolhColors.dark_grey,
                    )
                  : bottomNavigatorController.activeIndex.value == 2
                      ? SvgPicture.asset("assets/images/get help tab.svg")
                      : SvgPicture.asset(
                          "assets/images/get help. outline.svg",
                        );
        }),
        label: profileController.isProfileLoading.value ||
                profileController.myProfileModel.value.body == null
            ? 'Get Help'
            : profileController.myProfileModel.value.body!.user!.userType ==
                    'SolhProvider'
                ? 'My Schedule'.tr
                : 'Get Help'.tr);
    /* profileController.isProfileLoading.value
                ? BottomNavigationBarItem(
                    icon: ButtonLoadingAnimation(
                      ballColor: SolhColors.green,
                      ballSizeLowerBound: 3,
                      ballSizeUpperBound: 8,
                    ),
                  )
                : userBlocNetwork.getUserType == 'SolhProvider'
                    ? BottomNavigationBarItem(
                        icon: Obx((() => Icon(
                              CupertinoIcons.calendar_badge_plus,
                              color:
                                  bottomNavigatorController.activeIndex.value ==
                                          2
                                      ? SolhColors.green
                                      : SolhColors.grey102,
                            ))),
                        label: "My Schedule")
                    : BottomNavigationBarItem(
                        icon: Obx((() => bottomNavigatorController
                                    .activeIndex.value ==
                                2
                            ? SvgPicture.asset("assets/images/get help tab.svg")
                            : SvgPicture.asset(
                                "assets/images/get help. outline.svg",
                              ))),
                        label: "Get Help",
                      ), */
  }

  Widget getDrawer() {
    return Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyProfileScreenV2()));
          },
          child: Obx(() {
            return profileController.isProfileLoading.value
                ? Center(
                    child: SizedBox(
                        height: 15, width: 15, child: MyLoader(strokeWidth: 2)),
                  )
                : profileController.myProfileModel.value.body == null
                    ? InkWell(
                        onTap: () {
                          profileController.getMyProfile();
                        },
                        splashColor: Colors.transparent,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: SolhColors.primary_green),
                          child: Icon(
                            Icons.refresh_rounded,
                            color: SolhColors.white,
                            size: 20,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 4.w,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 3.8.w,
                          backgroundImage: CachedNetworkImageProvider(
                            profileController.myProfileModel.value.body!.user!
                                    .profilePicture ??
                                "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
                          ),
                        ),
                      );
          }),

          // bottomNavigatorController.isDrawerOpen.value
          //     ? bottomNavigatorController.isDrawerOpen.value = false
          //     : bottomNavigatorController.isDrawerOpen.value = true;
          // bottomNavigatorController.isDrawerOpen.value
          //     ? animationController.forward()
          //     : animationController.reverse();

          // ------------------------- Above comment for opening side drawer  -------------------------//

          // child: Container(
          //     decoration: BoxDecoration(shape: BoxShape.circle),
          //     height: 40,
          //     width: 40,
          //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          //     child: Icon(
          //       Icons.account_circle_outlined,
          //       color: SolhColors.primary_green,
          //     )),
        ));
  }

  openMoreSheet(BuildContext context) {
    persistentBottomSheetController =
        _scaffoldKey.currentState!.showBottomSheet((context) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ModalBarrier(
            color: Colors.black26,
            dismissible: false,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UpperCloseDecoration(),
                Divider(),
                SizedBox(
                  width: 100.w,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 8.0,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.find<GetHelpController>()
                              .getAlliedTherapyListMore();
                          Navigator.pushNamed(
                              context, AppRoutes.viewAllAlliedCategories,
                              arguments: {
                                "onTap": (value, name) {
                                  Navigator.pushNamed(
                                      context, AppRoutes.viewAllAlliedExpert,
                                      arguments: {
                                        "slug": value,
                                        "name": name,
                                        "type": 'specialization',
                                        "enableAppbar": true
                                      });
                                }
                              });
                        },
                        child: Column(
                          children: [
                            getBottomSheetIcon(
                                icon: 'assets/images/allied.svg'),
                            Text(
                              'Allied Therapies'.tr,
                              style: SolhTextStyles.QS_cap_semi,
                            )
                          ],
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.pushNamed(
                      //         context, AppRoutes.viewAllAlliedCategories,
                      //         arguments: {
                      //           "onTap": (value) {
                      //             Navigator.pushNamed(
                      //                 context, AppRoutes.viewAllAlliedExpert,
                      //                 arguments: {
                      //                   "slug": value,
                      //                   "name": value,
                      //                   "type": 'specialization',
                      //                   "enableAppbar": true
                      //                 });
                      //           }
                      //         });
                      //   },
                      //   child: Column(
                      //     children: [
                      //       getBottomSheetIcon(icon: 'assets/images/packages.svg'),
                      //       Text('Packages'.tr)
                      //     ],
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.psychologyTest);
                        },
                        child: Column(
                          children: [
                            getBottomSheetIcon(
                                icon: 'assets/images/self-assessment.svg'),
                            Text(
                              'Self Assessment'.tr,
                              style: SolhTextStyles.QS_cap_semi,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AnonymousDialog());
                        },
                        child: Column(
                          children: [
                            getBottomSheetIcon(
                                icon: 'assets/images/talk-now-sheet.svg'),
                            Text(
                              'Talk Now'.tr,
                              style: SolhTextStyles.QS_cap_semi,
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.videoPlaylist);
                        },
                        child: Column(
                          children: [
                            Obx(() {
                              return liveStreamController.liveStreamForUserModel
                                          .value.webinar ==
                                      null
                                  ? Container(
                                      height: 14,
                                    )
                                  : LiveBlink();
                            }),
                            getBottomSheetIcon(
                                icon: 'assets/images/know-us-more.svg'),
                            Text(
                              'Featured Videos'.tr,
                              style: SolhTextStyles.QS_cap_semi,
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 14,
                          ),
                          Obx(() {
                            return profileController.isProfileLoading.value
                                ? Center(
                                    child: SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: MyLoader(strokeWidth: 2)),
                                  )
                                : profileController.myProfileModel.value.body ==
                                        null
                                    ? InkWell(
                                        onTap: () {
                                          profileController.getMyProfile();
                                        },
                                        splashColor: Colors.transparent,
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: SolhColors.primary_green),
                                          child: Icon(
                                            CupertinoIcons.arrow_clockwise,
                                            color: SolhColors.white,
                                            size: 20,
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyProfileScreenV2()));
                                        },
                                        child: getBottomSheetIcon(
                                            icon:
                                                "assets/images/profile-bottom-sheet.svg"),
                                      );
                          }),
                          Text(
                            'My Profile'.tr,
                            style: SolhTextStyles.QS_cap_semi,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }, enableDrag: true, elevation: 5.0, backgroundColor: Colors.transparent);
  }

  getBottomSheetIcon({required String icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.brown,
        child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 29,
            child: SvgPicture.asset(icon)),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class UpperCloseDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 25,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 15),
            Container(
              height: 8,
              width: 50,
              decoration: BoxDecoration(
                  color: SolhColors.grey,
                  borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              width: 40,
              height: 50,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close),
              ),
            )
          ]),
    );
  }
}

class AnimatedHideContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 20),
          Container(
            height: 10,
            width: 50,
            decoration: BoxDecoration(
                color: SolhColors.grey,
                borderRadius: BorderRadius.circular(10)),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ]);
  }
}

/* import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import '../controllers/goal-setting/goal_setting_controller.dart';
import '../widgets_constants/constants/textstyles.dart';

class MasterScreen extends StatefulWidget {
  MasterScreen({this.index});
  final int? index;
  @override
  _MasterScreenState createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  GoalSettingController goalSettingController =
      Get.put(GoalSettingController());
  BottomNavigatorController bottomNavigatorController =
      Get.put(BottomNavigatorController());
  var backPressedTime;
  List<int> selectedIndex = [];

  @override
  void initState() {
    print("MasterScreen initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AutoTabsScaffold(
        routes: [
          HomeScreenRouter(),
          JournalingScreenRouter(),
          if (userBlocNetwork.getUserType == 'SolhProvider')
            DoctorsAppointmentsScreenRouter()
          else
            GetHelpScreenRouter(),
          MyGoalsScreenRouter(),
          MyProfileScreenRouter(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          // if (widget.index != null) tabsRouter.setActiveIndex(widget.index!);
          bottomNavigatorController.tabrouter = tabsRouter;
          return BottomNavigationBar(
            enableFeedback: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: SolhColors.green,
            showUnselectedLabels: true,
            // iconSize: 20,
            unselectedItemColor: SolhColors.black666,
            currentIndex: tabsRouter.activeIndex,
            unselectedLabelStyle: TextStyle(height: 1.5),
            selectedFontSize: 13,
            unselectedFontSize: 13,
            // backgroundColor: SolhColors.green,
            // onTap: (index) async {
            //   if (index == 2 || index == 3) {
            //     bool isLogin = await authBlocNetwork.checkLogin(context);
            //     if (isLogin) {
            //       if (index == 2)
            //         context.pushRoute(MyBagRouter());
            //       else
            //         tabsRouter.setActiveIndex(index);
            //     }
            //   } else {
            //     tabsRouter.setActiveIndex(index);
            //   }
            // },
            onTap: (index) => tabsRouter.setActiveIndex(index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    tabsRouter.activeIndex == 0
                        ? CupertinoIcons.house_fill
                        : CupertinoIcons.house,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: tabsRouter.activeIndex == 1
                      // ? SvgPicture.asset(
                      //     'assets/images/home_selected.svg',
                      //     fit: BoxFit.fitHeight,
                      //   )
                      ? SvgPicture.asset('assets/images/journaling.svg')
                      : SvgPicture.asset(
                          'assets/images/journalling outline.svg',
                          color: SolhColors.grey102),
                  label: "journaling"),
              userBlocNetwork.getUserType == 'SolhProvider'
                  ? BottomNavigationBarItem(
                      icon: tabsRouter.activeIndex == 2
                          ? Icon(
                              CupertinoIcons.calendar_badge_plus,
                              color: SolhColors.green,
                            )
                          : Icon(
                              CupertinoIcons.calendar_badge_plus,
                              color: SolhColors.grey102,
                            ),
                      label: "My Schedule")
                  : BottomNavigationBarItem(
                      icon: tabsRouter.activeIndex == 2
                          ? SvgPicture.asset("assets/images/get help tab.svg")
                          : SvgPicture.asset(
                              "assets/images/get help. outline.svg",
                              color: Colors.grey.shade600,
                            ),
                      label: "Get Help",
                    ),
              BottomNavigationBarItem(
                  icon: tabsRouter.activeIndex == 3
                      ? SvgPicture.asset(
                          'assets/images/groal tab vector.svg',
                          color: SolhColors.green,
                        )
                      : SvgPicture.asset(
                          'assets/images/groal tab vector.svg',
                          color: Colors.grey.shade600,
                        ),
                  label: "My Goals"),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.person_circle,
                    size: 24,
                  ),
                  label: "My profile")
            ],
          );
        },
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (bottomNavigatorController.tabrouter!.activeIndex != 0) {
      bottomNavigatorController.tabrouter!.setActiveIndex(0);
      return Future.value(false);
    } else {
      return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actionsPadding: EdgeInsets.all(8.0),
              content: Text(
                'Do you really want to exit app ?',
                style: SolhTextStyles.JournalingDescriptionText,
              ),
              actions: [
                TextButton(
                    child: Text(
                      'No',
                      style: SolhTextStyles.GreenButtonText,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }),
                TextButton(
                    child: Text(
                      'Yes',
                      style: SolhTextStyles.GreenButtonText,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    }),
              ],
            );
          });

    
    }
  }
}
 */
