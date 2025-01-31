import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bottom-navigation/profile_icon.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/goal-setting/goal_setting_controller.dart';
import 'package:solh/controllers/homepage/offer_carousel_controller.dart';
import 'package:solh/controllers/journals/journal_comment_controller.dart';
import 'package:solh/controllers/mood-meter/mood_meter_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/controllers/psychology-test/psychology_test_controller.dart';
import 'package:solh/services/dynamic_link_sevice/dynamic_link_provider.dart';
import 'package:solh/services/errors/no_internet_page.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/restart_widget.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/home/homescreen.dart';
import 'package:solh/ui/screens/journaling/journaling.dart';
import 'package:solh/ui/screens/live_stream/live-stream-controller.dart/live_stream_controller.dart';
import 'package:solh/ui/screens/my-profile/appointments/controller/appointment_controller.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/my_profile_screenV2.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/guide_toor_widget.dart';
import 'package:solh/widgets_constants/live_blink.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

import '../controllers/chat-list/chat_list_controller.dart';
import '../controllers/connections/connection_controller.dart';
import '../controllers/getHelp/book_appointment.dart';
import '../controllers/getHelp/get_help_controller.dart';
import '../controllers/group/discover_group_controller.dart';
import '../controllers/journals/journal_page_controller.dart';
import '../features/lms/display/course_home/ui/screens/course_homepage.dart';
import '../routes/routes.dart';
import '../widgets_constants/constants/org_only_setting.dart';
import '../widgets_constants/constants/textstyles.dart';
import '../widgets_constants/loader/my-loader.dart';
import 'bottom_navigator_controller.dart';

class MasterScreen extends StatelessWidget {
  MasterScreen({super.key});

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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const MasterScreen2(),
      ),
    );
  }
}

class MasterScreen2 extends StatefulWidget {
  const MasterScreen2({super.key});

  @override
  State<MasterScreen2> createState() => _MasterScreen2State();
}

class _MasterScreen2State extends State<MasterScreen2>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final JournalPageController journalPageController =
      Get.put(JournalPageController());
  final MoodMeterController meterController = Get.find();
  final BottomNavigatorController bottomNavigatorController =
      Get.put(BottomNavigatorController());

  final LiveStreamController liveStreamController = Get.find();

  final MoodMeterController moodMeterController =
      Get.put(MoodMeterController());

  late TabController tabController;
  late AnimationController animationController;
  PersistentBottomSheetController? persistentBottomSheetController;
  final ProfileController profileController = Get.put(ProfileController());

  List<Widget> bottomWidgetList = [];

  @override
  void initState() {
    debugPrint('init master');
    Connectivity().checkConnectivity().then((result) async {
      if (result == ConnectivityResult.none) {
        try {
          final result = await InternetAddress.lookup('example.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            debugPrint('connected');
          }
        } on SocketException catch (_) {
          onConnectionFailed();
        }
      }
    });

    Connectivity().onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.none) {
        try {
          final result = await InternetAddress.lookup('example.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            debugPrint('connected');
          }
        } on SocketException catch (_) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Internet is not connected")));
          onConnectionFailed();
        }
      } else {}
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController
          .getMyProfile()
          .then((value) => DynamicLinkProvider.instance.initDynamicLink());
      showFeedbackForm();
    });
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    bottomWidgetList.addAll([
      const HomeScreen(),
      const Journaling(),
      GetHelpScreen(),
      const CourseHomePage(),
      // const MyGoalsScreen(),
      // MyProfileScreenV2()
    ]);
    super.initState();
  }

  void showFeedbackForm() {
    Future.delayed(
      const Duration(seconds: 10),
      () {
        bottomNavigatorController.shouldShowFeedbackForm
            ? showBottomSheet(
                constraints: BoxConstraints(maxHeight: 60.h),
                backgroundColor: SolhColors.greenShade5,
                context: context,
                builder: (context) => feedbackForm(),
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: Obx(
        () => Scaffold(
          key: _scaffoldKey,
          appBar: bottomNavigatorController.activeIndex.value != 3
              ? SolhAppBar(
                  title: const ProfileIcon(),
                  isLandingScreen: true,
                )
              : null,
          body: IndexedStack(
              index: bottomNavigatorController.activeIndex.value,
              children: bottomWidgetList),
          bottomNavigationBar: getBottomBar(context),
        ),
      ),
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
    } else if (bottomNavigatorController.activeIndex.value != 0) {
      bottomNavigatorController.activeIndex.value = 0;
      return Future.value(false);
    } else {
      return await showDialog(
          context: context,
          builder: (context) {
            return Stack(
              children: [
                AlertDialog(
                  actionsPadding: const EdgeInsets.all(8.0),
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
                    const SizedBox(width: 30),
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
                setState(
                  () async {
                    setState(() async {
                      bottomNavigatorController.givenStars.value = index;

                      await Network.makePostRequestWithToken(
                          url: '${APIConstants.api}/api/custom/create-feedback',
                          body: {
                            "rating":
                                (bottomNavigatorController.givenStars.value + 1)
                                    .toString(),
                            "feedBackComment": '',
                          });

                      await Network.makePostRequestWithToken(
                          url: '${APIConstants.api}/api/custom/create-feedback',
                          body: {
                            "rating":
                                (bottomNavigatorController.givenStars.value + 1)
                                    .toString(),
                            "feedBackComment": '',
                          });
                    });
                  },
                );
              },
              child: Icon(
                bottomNavigatorController.givenStars.value < index
                    ? Icons.star_border
                    : Icons.star,
                size: 10.w,
                color: const Color(0xfff0ba00),
              ),
            ),
          ));
    });
  }

  Widget feedbackForm() {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.cancel,
                size: 25,
                color: SolhColors.grey_2,
              )),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    'Those who support us want to know if we are supporting you well. Please review us and give feedback.',
                    style: SolhTextStyles.QS_body_2_semi,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                getStarsRow(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextField(
                    controller:
                        bottomNavigatorController.feedbackTextEditingController,
                    maxLines: 5,
                    minLines: 2,
                    decoration: TextFieldStyles.greenF_greyUF_4R.copyWith(
                      hintText: 'Your feedback :)'.tr,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: SolhColors.grey_3,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => bottomNavigatorController.isSubmittingFeedback.value
                    ? const SolhGreenButton(
                        child: ButtonLoadingAnimation(
                        ballColor: SolhColors.white,
                      ))
                    : SolhGreenButton(
                        onPressed: () async {
                          if (bottomNavigatorController
                              .feedbackTextEditingController.text
                              .trim()
                              .isNotEmpty) {
                            await bottomNavigatorController.submitRating({
                              "rating":
                                  (bottomNavigatorController.givenStars.value +
                                          1)
                                      .toString(),
                              "feedBackComment": bottomNavigatorController
                                  .feedbackTextEditingController.text
                                  .trim(),
                            });

                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          } else {
                            SolhSnackbar.error(
                              "Opps!",
                              "Can't submit with empty comment. Enter a comment to submit or skip from above",
                            );
                            // Navigator.of(context).pop();
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
            ),
          ),
        ],
      ),
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
                  default:
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: GuideToorWidget(
                    description:
                        'Welcome to your comprehensive mental wellness hub! Tap into your journey to better mental health.',
                    icon: SvgPicture.asset('assets/images/home_solid.svg'),
                    id: 'home',
                    title: 'HOME',
                    child: Obx(
                      () => bottomNavigatorController.activeIndex.value == 0
                          ? SvgPicture.asset('assets/images/home_solid.svg',
                              height: 20)
                          : SvgPicture.asset('assets/images/home_outlined.svg',
                              height: 20),
                    ),
                  ),
                  label: "Home".tr,
                ),
                BottomNavigationBarItem(
                  icon: GuideToorWidget(
                    description:
                        'Express yourself publicly, anonymously, or in your personal "My Diary"  in a committed non-judgmental, safe space.',
                    icon: SvgPicture.asset(
                      'assets/images/journaling.svg',
                      height: 18,
                    ),
                    id: 'journaling',
                    title: 'JOURNALING',
                    child: Obx(
                      () => bottomNavigatorController.activeIndex.value == 1
                          ? SvgPicture.asset(
                              'assets/images/journaling.svg',
                              height: 20,
                            )
                          : SvgPicture.asset(
                              'assets/images/journalling outline.svg',
                              height: 20,
                            ),
                    ),
                  ),
                  label: "Journaling".tr,
                ),
                getHelpItem(),
                BottomNavigationBarItem(
                    icon: GuideToorWidget(
                      description:
                          'Set Goals, manage them, and accomplish what you always wanted to. Celebrate milestones, and stay locked onto your goals for a more fulfilling life.',
                      icon: SvgPicture.asset(
                          'assets/images/groal tab vector.svg'),
                      id: 'my_goal',
                      title: 'Courses',
                      child: Obx(() => SvgPicture.asset(
                          /* 'assets/images/groal tab vector.svg',
                          color:
                              bottomNavigatorController.activeIndex.value == 3
                                  ? SolhColors.primary_green
                                  : Colors.grey.shade600, */
                          'assets/images/course_icon.svg',
                          height: 20,
                          colorFilter: ColorFilter.mode(
                              bottomNavigatorController.activeIndex.value == 3
                                  ? SolhColors.primary_green
                                  : Colors.grey.shade600,
                              BlendMode.srcIn))),
                    ),
                    // label: "My Goals".tr,
                    label: "Courses".tr),
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
              color: const Color.fromARGB(255, 247, 247, 247),
              height: 60,
              width: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GuideToorWidget(
                    description:
                        'Discover diverse resources and dive into the activities that stimulate your well-being',
                    icon: const Icon(
                      Icons.menu,
                      color: SolhColors.primary_green,
                    ),
                    id: 'more',
                    title: 'MORE',
                    child: Icon(
                      Icons.menu,
                      color: Colors.grey.shade600,
                      size: 18,
                    ),
                  ),
                  Obx(() {
                    return liveStreamController
                                .liveStreamForUserModel.value.webinar ==
                            null
                        ? Text(
                            "More".tr,
                            style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(fontSize: 12)),
                          )
                        : const LiveBlink();
                  }),
                ],
              )),
        ),
      ))
    ]);
  }

  BottomNavigationBarItem getHelpItem() {
    return BottomNavigationBarItem(
        icon: GuideToorWidget(
          description:
              'Explore personalized therapy packages and connect with a mental health expert (Clinical and Allied Therapists).',
          icon: SvgPicture.asset("assets/images/get help tab.svg"),
          id: 'get_help',
          title: 'GET HELP',
          child: Obx(() {
            return profileController.isProfileLoading.value ||
                    profileController.myProfileModel.value.body == null
                ? bottomNavigatorController.activeIndex.value == 2
                    ? SvgPicture.asset("assets/images/get help tab.svg",
                        height: 20)
                    : SvgPicture.asset("assets/images/get help. outline.svg",
                        height: 20)
                : profileController.myProfileModel.value.body!.user!.userType ==
                        'SolhProvider'
                    ? Icon(
                        CupertinoIcons.calendar_badge_plus,
                        color: bottomNavigatorController.activeIndex.value == 2
                            ? SolhColors.primary_green
                            : SolhColors.dark_grey,
                      )
                    : bottomNavigatorController.activeIndex.value == 2
                        ? SvgPicture.asset(
                            "assets/images/get help tab.svg",
                            height: 20,
                          )
                        : SvgPicture.asset(
                            "assets/images/get help. outline.svg",
                            height: 20,
                          );
          }),
        ),
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

  openMoreSheet(BuildContext context) {
    persistentBottomSheetController =
        _scaffoldKey.currentState!.showBottomSheet((context) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const ModalBarrier(
            color: Colors.black26,
            dismissible: false,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60.h,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const UpperCloseDecoration(),
                const Divider(),
                SizedBox(
                  width: 100.w,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 8.0,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 14),
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
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: SolhColors.primary_green),
                                          child: const Icon(
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
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.OrgSetting);
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 14),
                            getBottomSheetIcon(
                                icon: 'assets/images/organization-icon.svg'),
                            Text(
                              'Organization'.tr,
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
                                  ? Container(height: 14)
                                  : const LiveBlink();
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
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.psychologyTest);
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 14),
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
                            const SizedBox(height: 14),
                            getBottomSheetIcon(
                                icon: 'assets/images/talk-now-sheet.svg'),
                            Text(
                              'Talk Now'.tr,
                              style: SolhTextStyles.QS_cap_semi,
                            )
                          ],
                        ),
                      ),
                      /* InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.myGoalScreen);
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 14),
                            getBottomSheetIcon(
                                icon: 'assets/images/goals_icon.svg'),
                            Text(
                              'My Goals'.tr,
                              style: SolhTextStyles.QS_cap_semi,
                            )
                          ],
                        ),
                      ), */
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.productsHome);
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 14),
                            getBottomSheetIcon(
                                icon: 'assets/images/product_svg_red.svg'),
                            Text(
                              "Products".tr,
                              style: SolhTextStyles.QS_cap_semi,
                            )
                          ],
                        ),
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

  void onConnectionFailed() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Internet is not connected"),
        behavior: SnackBarBehavior.floating));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => NoInternetPage(onRetry: () {
                  Get.find<PsychologyTestController>().getTestList();
                  Get.find<PsychologyTestController>().getAttendedTestList();
                  Get.find<ChatListController>().sosChatListController(1);
                  Get.find<ChatListController>().chatListController(1);
                  bottomNavigatorController.getFeedbackStatus();
                  Get.find<MoodMeterController>().getMoodList();
                  Get.find<ConnectionController>().getMyConnection();
                  Get.find<ConnectionController>().getAllConnection();
                  Get.find<ConnectionController>().getRecommendedBlogs();
                  Get.find<GoalSettingController>().getPersonalGoals();
                  Get.find<GoalSettingController>().getGoalsCat();
                  Get.find<GoalSettingController>().getFeaturedGoals();
                  Get.find<GoalSettingController>()
                      .task
                      .add({TextEditingController(): '1'});
                  Get.find<OfferCarouselController>().getOffers();
                  Get.find<JournalCommentController>().getReactionList();
                  Get.find<AppointmentController>().getUserAppointments();
                  Get.find<DiscoverGroupController>().getJoinedGroups();
                  Get.find<DiscoverGroupController>().getDiscoverGroups();
                  Get.find<DiscoverGroupController>().getCreatedGroups();
                  Get.find<JournalPageController>().getHeaderAnnounce();
                  Get.find<GetHelpController>().getIssueList();
                  Get.find<GetHelpController>().getSpecializationList();
                  Get.find<GetHelpController>().getAlliedTherapyList();
                  Get.find<GetHelpController>().getTopConsultant();
                  Get.find<GetHelpController>().getSolhVolunteerList();
                  Get.find<GetHelpController>().getCountryList();
                  Get.find<JournalPageController>().getAllJournals(1,
                      orgOnly: OrgOnlySetting.orgOnly ?? false);
                  Get.find<JournalPageController>().getTrendingJournals(
                      orgToggle: OrgOnlySetting.orgOnly ?? false);
                  RestartWidget.restartApp(context);
                })));
  }
}

class UpperCloseDecoration extends StatelessWidget {
  const UpperCloseDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 25,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 15),
            Container(
              height: 8,
              width: 50,
              decoration: BoxDecoration(
                  color: SolhColors.grey,
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              width: 40,
              height: 50,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close),
              ),
            )
          ]),
    );
  }
}

class AnimatedHideContainer extends StatelessWidget {
  const AnimatedHideContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
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
              icon: const Icon(Icons.close))
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
