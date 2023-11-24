import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/chat-list/chat_list_controller.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/getHelp/search_market_controller.dart';
import 'package:solh/controllers/goal-setting/goal_setting_controller.dart';
import 'package:solh/controllers/homepage/offer_carousel_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/controllers/psychology-test/psychology_test_controller.dart';
import 'package:solh/model/psychology-test/psychology_test_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/shared_prefrences/shared_prefrences_singleton.dart';
import 'package:solh/ui/screens/comment/comment-screen.dart';
import 'package:solh/ui/screens/get-help/view-all/allied_consultants.dart';
import 'package:solh/ui/screens/groups/manage_groups.dart';
import 'package:solh/ui/screens/home/blog_details.dart';
import 'package:solh/ui/screens/home/chat-anonymously/chat-anon-controller/chat_anon_controller.dart';
import 'package:solh/ui/screens/home/home_controller.dart';
import 'package:solh/ui/screens/live_stream/live-stream-controller.dart/live_stream_controller.dart';
import 'package:solh/ui/screens/my-goals/my-goals-screen.dart';
import 'package:solh/ui/screens/my-goals/select_goal.dart';
import 'package:solh/ui/screens/my-profile/connections/connections.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/setting.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/ui/screens/products/features/home/ui/views/widgets/products_carousel.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/default_org.dart';
import 'package:solh/widgets_constants/constants/locale.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/find_help_bar.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:upgrader/upgrader.dart';

import '../../../controllers/connections/connection_controller.dart';
import '../../../controllers/getHelp/get_help_controller.dart';
import '../../../controllers/group/create_group_controller.dart';
import '../../../controllers/group/discover_group_controller.dart';
import '../../../controllers/journals/feelings_controller.dart';
import '../../../controllers/journals/journal_comment_controller.dart';
import '../../../controllers/journals/journal_page_controller.dart';
import '../../../controllers/mood-meter/mood_meter_controller.dart';
import '../../../controllers/my_diary/my_diary_controller.dart';
import '../../../controllers/video/video_tutorial_controller.dart';
import '../../../features/mood_meter/ui/screens/mood_meter_v2.dart';
import '../../../model/journals/journals_response_model.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../../../widgets_constants/constants/org_only_setting.dart';
import '../get-help/get-help.dart';
import '../get-help/widgets/allied_card_with_discount.dart';
import '../global-search/global_search_page.dart';
import '../journaling/whats_in_your_mind_section.dart';
import '../journaling/widgets/solh_expert_badge.dart';
import '../psychology-test/test_question_page.dart';
import 'search_by_profession.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CreateGroupController controller = Get.put(CreateGroupController());
  final VideoTutorialController videoTutorialController =
      Get.put(VideoTutorialController());
  MyDiaryController myDiaryController = Get.put(MyDiaryController());
  FeelingsController feelingsController = Get.put(FeelingsController());
  BookAppointmentController bookAppointmentController = Get.find();
  JournalCommentController journalCommentController =
      Get.put(JournalCommentController());
  ChatListController chatListController = Get.put(ChatListController());
  BottomNavigatorController bottomNavigatorController = Get.find();
  PsychologyTestController psychologyTestController =
      Get.put(PsychologyTestController());
  GoalSettingController goalSettingController =
      Get.put(GoalSettingController());
  final MoodMeterController moodMeterController = Get.find();
  final ProfileController profileController = Get.find();

  final HomeController homeController = Get.find();
  LiveStreamController liveStreamController = Get.find();

  late bool isMoodMeterShown;

  @override
  void initState() {
    super.initState();

    profileController.myProfileModel.listen((profile) {
      if (profile.body!.user!.sId != null) {
        debugPrint('mood meter shown');
        openMoodMeter();
        getTrendingDecoration();
        homeController.getHomeProductsCarouserl();
        homeController.getHomeCarousel();
        liveStreamController.getLiveStreamForUserData();
        Prefs.setBool("isProfileCreated", true);
        Get.find<JournalPageController>()
            .getAllJournals(1, orgOnly: OrgOnlySetting.orgOnly ?? false);
        Get.find<JournalPageController>()
            .getTrendingJournals(orgToggle: OrgOnlySetting.orgOnly ?? false);
        homeController.getNotificationCount();
        Get.find<CartController>().getCart();
        Get.find<BottomNavigatorController>().getFeedbackStatus();
      }
    });

    /*  if (userBlocNetwork.id.isNotEmpty) {

    } */
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }

  Future<void> openMoodMeter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (moodMeterController.moodList.isEmpty) {
      await moodMeterController.getMoodList();
    }
    if (prefs.getInt('lastDateShown') != null) {
      if (DateTime.fromMillisecondsSinceEpoch(prefs.getInt('lastDateShown')!)
              .day ==
          DateTime.now().day) {
        return;
      } else {
        if (moodMeterController.moodList.isNotEmpty) {
          // ignore: use_build_context_synchronously
          showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) {
                return const Scaffold(body: MoodMeterV2());
              });
        }
        prefs.setBool('moodMeterShown', true);
        prefs.setInt('lastDateShown', DateTime.now().millisecondsSinceEpoch);
      }
    } else {
      prefs.setBool('moodMeterShown', true);
      prefs.setInt('lastDateShown', DateTime.now().millisecondsSinceEpoch);
    }
  }

  void getTrendingDecoration() {
    homeController.getTrendingDecoration();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final JournalPageController _journalPageController = Get.find();
  GetHelpController getHelpController = Get.find();
  DiscoverGroupController discoverGroupController = Get.find();
  final BottomNavigatorController _bottomNavigatorController = Get.find();
  BookAppointmentController bookAppointmentController = Get.find();
  GoalSettingController goalSettingController = Get.find();
  ConnectionController connectionController = Get.find();
  ChatAnonController chatAnonController = Get.put(ChatAnonController());
  SearchMarketController searchMarketController = Get.find();
  HomeController homeController = Get.find();
  PsychologyTestController psychologyTestController = Get.find();
  final ProfileController profileController = Get.find();

  // bool _isDrawerOpen = false;
  List<String> feelingList = [];
  bool switchToggle = false;
  @override
  void initState() {
    super.initState();
    getAnnouncement();
    FirebaseAnalytics.instance
        .logEvent(name: 'HomePageOpen', parameters: {'Page': 'HomeScreen'});
    checkForUserActive();
  }

  checkForUserActive() async {
    var response = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/checkUserProfile");
    print("checkForUserActive ${response["success"]}");
    if (response["success"] == false) {
      logOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
          showIgnore: false,
          durationUntilAlertAgain: const Duration(seconds: 10),
          onLater: () {
            exit(0);
          }),
      child: SingleChildScrollView(
        child: Column(children: [
          const GetHelpDivider(),
          FindHelpBar(
            onConnectionTapped: () {
              Get.find<ChatListController>().sosChatListController(1);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Connections()));
            },
            onMoodMeterTapped: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MoodMeterV2()));
              FirebaseAnalytics.instance.logEvent(
                  name: 'MoodMeterOpenTapped',
                  parameters: {'Page': 'MoodMeter'});
            },
            onTapped: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GlobalSearchPage()));
            },
          ),

          // LiveStreamForUserCard(),

          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ChatAnonymouslyCard(),
          ),
          const SizedBox(
            height: 10,
          ),
          const GetHelpDivider(),
          GetHelpCategory(
            title: 'Trending Posts'.tr,
            trailing: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultOrg.defaultOrg != null
                      ? PopupMenuButton<bool>(
                          child: const Icon(
                              CupertinoIcons.line_horizontal_3_decrease),
                          onSelected: (value) async {
                            OrgOnlySetting.orgOnly = value;
                            OrgOnlySetting.setOrgOnly(value);
                            _journalPageController.getTrendingJournals(
                                orgToggle: value);

                            _journalPageController.journalsList.clear();
                            _journalPageController.pageNo = 1;
                            _journalPageController.nextPage = 2;
                            _journalPageController
                                    .selectedGroupId.value.isNotEmpty
                                ? await _journalPageController.getAllJournals(1,
                                    groupId: _journalPageController
                                        .selectedGroupId.value,
                                    orgOnly: value)
                                : await _journalPageController.getAllJournals(1,
                                    orgOnly: value);
                            _journalPageController.journalsList.refresh();
                          },
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem<bool>(
                                textStyle: TextStyle(
                                    color: OrgOnlySetting.orgOnly != null
                                        ? !OrgOnlySetting.orgOnly!
                                            ? SolhColors.primary_green
                                            : SolhColors.black
                                        : SolhColors.black),
                                value: false,
                                child: const Text("All(Solh & Organization)"),
                              ),
                              PopupMenuItem<bool>(
                                textStyle: TextStyle(
                                    color: OrgOnlySetting.orgOnly != null
                                        ? OrgOnlySetting.orgOnly!
                                            ? SolhColors.primary_green
                                            : SolhColors.black
                                        : SolhColors.black),
                                value: true,
                                child: const Text("Organization only"),
                              )
                            ];
                          })
                      : const SizedBox(),
                  InkWell(
                    onTap: () async {
                      _bottomNavigatorController.activeIndex.value = 1;
                      FirebaseAnalytics.instance.logEvent(
                          name: 'TrendingTapped',
                          parameters: {'Page': 'HomePage'});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Row(
                          children: [
                            Text('Journaling'.tr,
                                style: SolhTextStyles.CTA
                                    .copyWith(color: SolhColors.primary_green)),
                            const Icon(
                              Icons.arrow_forward,
                              color: SolhColors.primary_green,
                              size: 14,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            return _journalPageController.isTrendingLoading.value
                ? getTrendingPostShimmer()
                : getTrendingPostUI();
          }),
          WhatsOnYourMindSection(),
          const GetHelpDivider(),
          getTestUI(),
          const SizedBox(
            height: 10,
          ),
          const GetHelpDivider(),
          OrgOfferCaurousel(),
          const GetHelpDivider(),
          GetHelpCategory(
            title: 'Goals'.tr,
            trailing: InkWell(
              onTap: () {
                _bottomNavigatorController.activeIndex.value = 3;
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Row(
                  children: [
                    Text(
                      'Goal Setting'.tr,
                      style: GoogleFonts.signika(
                        color: SolhColors.primary_green,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: SolhColors.primary_green,
                      size: 14,
                    )
                  ],
                ),
              ),
            ),
          ),
          getGoalSettingUI(goalSettingController),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SolhGreenButton(
              height: 32,
              width: 100,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectGoal()));
              },
              child: Text('Add Goals +'.tr),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const GetHelpDivider(),
          Obx(() =>
              discoverGroupController.homepageGroupModel.value.groupList != null
                  ? GetHelpCategory(
                      title: 'Groups For You'.tr,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ManageGroupPage()));
                      })
                  : Container()),
          Obx(() {
            return discoverGroupController.homepageGroupModel.value.groupList !=
                        null &&
                    discoverGroupController
                        .homepageGroupModel.value.groupList!.isNotEmpty
                ? getRecommendedGroupsUI()
                : Container();
          }),
          const SizedBox(
            height: 10,
          ),
          const GetHelpDivider(),

          Obx(() => Container(
                color: profileController.orgColor3.value.isNotEmpty
                    ? Color(int.parse("0xFF${profileController.orgColor3}"))
                    : Colors.transparent,
                child: GetHelpCategory(
                  title: 'Search for Support'.tr,
                  trailing: InkWell(
                    onTap: () {
                      getHelpController.isAllIssueShown.value
                          ? getHelpController.showLessIssues()
                          : getHelpController.showAllIssues();
                      getHelpController.isAllIssueShown.value =
                          !getHelpController.isAllIssueShown.value;
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(
                            right: 11.0, bottom: 11, top: 11, left: 11),
                        child: Obx(() {
                          return Text(
                            !getHelpController.isAllIssueShown.value
                                ? "Show More".tr
                                : "Show less".tr,
                            style: SolhTextStyles.CTA
                                .copyWith(color: SolhColors.primary_green),
                          );
                        })),
                  ),
                ),
              )),
          Obx(
            () => Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              color: profileController.orgColor3.value.isNotEmpty
                  ? Color(int.parse("0xFF${profileController.orgColor3}"))
                  : Colors.transparent,
              child: getIssueUI(
                  bookAppointmentController, getHelpController, context),
            ),
          ),
          const GetHelpDivider(),
          Padding(
            padding: EdgeInsets.all(4.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Search by Profession'.tr,
                      style: SolhTextStyles.QS_body_semi_1,
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          constraints: BoxConstraints(maxHeight: 70.h),
                          isScrollControlled: true,
                          context: context,
                          enableDrag: true,
                          isDismissible: true,
                          builder: (context) {
                            return showInfoDialog(context);
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.info,
                        size: 15,
                        color: SolhColors.grey,
                      ),
                    ),
                  ],
                ),
                // InkWell(
                //   onTap: () {
                //     _bottomNavigatorController.activeIndex.value = 2;
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                //     child: Row(
                //       children: [
                //         Text(
                //           'Get Help'.tr,
                //           style: GoogleFonts.signika(
                //             color: SolhColors.primary_green,
                //             fontWeight: FontWeight.w400,
                //           ),
                //         ),
                //         Icon(
                //           Icons.arrow_forward,
                //           color: SolhColors.primary_green,
                //           size: 14,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SearchByProfesssionUI(),
          const GetHelpDivider(),
          Obx((() => getHelpController.isAlliedShown.value
              ? AlliedExperts(onTap: (value, name, id) {
                  Navigator.pushNamed(context, AppRoutes.viewAllAlliedExpert,
                      arguments: {
                        "id": id,
                        "slug": value,
                        "name": name,
                        "type": 'specialization',
                        "enableAppbar": true
                      });
                })
              : const SizedBox())),
          const SizedBox(
            height: 8,
          ),
          Obx(() => getHelpController.isAlliedShown.value
              ? const GetHelpDivider()
              : const SizedBox()),
          Obx(
            (() => homeController.isCorouselShown.value
                ? const AlliedCarousel()
                : const SizedBox()),
          ),
          const GetHelpDivider(),
          Obx(
            () => Container(
              color: profileController.orgColor3.value.isNotEmpty
                  ? Color(int.parse("0xFF${profileController.orgColor3}"))
                  : Colors.transparent,
              child: GetHelpCategory(
                title: "In-house Experts".tr,
              ),
            ),
          ),
          Obx(() => Container(
                color: profileController.orgColor3.value.isNotEmpty
                    ? Color(int.parse("0xFF${profileController.orgColor3}"))
                    : Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: 35.h,
                margin: EdgeInsets.only(bottom: 2.h),
                child: Obx(() => Container(
                    child: getHelpController.topConsultantList.value.doctors !=
                            null
                        ? getHelpController
                                .topConsultantList.value.doctors!.isEmpty
                            ? Center(
                                child: Text(
                                    'No Consultant available for your country'
                                        .tr),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: getHelpController.topConsultantList
                                            .value.doctors!.length >
                                        5
                                    ? 5
                                    : getHelpController.topConsultantList.value
                                        .doctors!.length,
                                itemBuilder: (_, index) {
                                  return TopConsultantsTile(
                                    doctors: getHelpController.topConsultantList
                                        .value.doctors![index],
                                  );
                                })
                        : Container())),
              )),

          const GetHelpDivider(),
          ProductsCarousel(),
          /* GetHelpCategory(
            title: 'Solh Buddies to Talk',
          ),
          getSolhBuddiesUI(), */
          // GetHelpDivider(),
          GetHelpCategory(
            title: 'Latest Reads'.tr,
          ),
          getRecommendedReadsUI(),
          const GetHelpDivider(),
          //FeatureProductsWidget(),
          const SizedBox(
            height: 70,
          ),
        ]),
      ),
    );
  }

  Future<void> openAnnouncement(Map<String, dynamic> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('lastDateShownAnnouncement') != null) {
      if (DateTime.fromMillisecondsSinceEpoch(
                  prefs.getInt('lastDateShownAnnouncement')!)
              .day ==
          DateTime.now().day) {
        return;
      } else if (value['media'] == null) {
        return;
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                insetPadding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () async {
                    if (value["redirectTo"] == "gethelp") {
                      Navigator.of(context).pop();
                      Get.find<BottomNavigatorController>().activeIndex.value =
                          2;
                    } else if (value["redirectTo"] == "createpost") {
                      Navigator.of(context).pop();
                      await Navigator.pushNamed(
                          context, AppRoutes.createJournal);
                      Get.find<BottomNavigatorController>().activeIndex.value =
                          1;
                    } else if (value["redirectTo"] == "explorethyself") {
                      Navigator.of(context).pop();
                      await Navigator.pushNamed(
                          context, AppRoutes.psychologyTest);
                    } else if (value["redirectTo"] == "inhousepackages") {
                      Navigator.of(context).pop();
                      await Navigator.pushNamed(
                          context, AppRoutes.inhousePackage,
                          arguments: {"id": value["redirectKey"]});
                    } else if (value["redirectTo"] == "blog") {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BlogDetailsPage(id: value["redirectKey"])));
                    } else if (value["redirectTo"] == "group") {
                      Navigator.of(context).pop();
                      await Navigator.pushNamed(context, AppRoutes.groupDetails,
                          arguments: {
                            "groupId": value["redirectKey"],
                            // "isJoined": false
                          });
                    } else if (value["redirectTo"] == "knowusmore") {
                      Navigator.of(context).pop();
                      await Navigator.pushNamed(
                          context, AppRoutes.videoPlaylist);
                    }
                  },
                  child: Stack(alignment: Alignment.center, children: [
                    announcementMedia(value),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              color: SolhColors.grey_3, shape: BoxShape.circle),
                          child: const Center(
                            child: Icon(
                              Icons.close,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            });
        prefs.setInt(
            'lastDateShownAnnouncement', DateTime.now().millisecondsSinceEpoch);
      }
    } else {
      prefs.setInt(
          'lastDateShownAnnouncement', DateTime.now().millisecondsSinceEpoch);
    }
  }

  Future<void> getAnnouncement() async {
    _journalPageController.getHeaderAnnounce();
    Map<String, dynamic> map = await _journalPageController.getAnnouncement();
    map['media'].isEmpty ? () {} : openAnnouncement(map);
  }

  announcementMedia(Map<String, dynamic> value) {
    return InkWell(
      onTap: () async {
        if (value["redirectTo"] == "gethelp") {
          Navigator.of(context).pop();
          Get.find<BottomNavigatorController>().activeIndex.value = 2;
        } else if (value["redirectTo"] == "createpost") {
          Navigator.of(context).pop();
          await Navigator.pushNamed(context, AppRoutes.createJournal);
          Get.find<BottomNavigatorController>().activeIndex.value = 1;
        } else if (value["redirectTo"] == "group") {
          Navigator.of(context).pop();
          await Navigator.pushNamed(context, AppRoutes.groupDetails,
              arguments: {
                "groupId": value["redirectKey"],
                // "isJoined": false,
              });
        } else if (value["redirectTo"] == "explorethyself") {
          Navigator.of(context).pop();
          await Navigator.pushNamed(context, AppRoutes.psychologyTest);
        } else if (value["redirectTo"] == "inhousepackages") {
          Navigator.of(context).pop();
          await Navigator.pushNamed(context, AppRoutes.inhousePackage,
              arguments: {"id": value["redirectKey"]});
        } else if (value["redirectTo"] == "knowusmore") {
          Navigator.of(context).pop();
          if (value["redirectTo"] != "") {
            await Navigator.pushNamed(
              context,
              AppRoutes.videoPlaylist,
            );
          } else {
            await Navigator.pushNamed(
              context,
              AppRoutes.videoPlaylist,
            );
          }
        }
      },
      child: CachedNetworkImage(
        imageUrl: value['media'],
        fit: BoxFit.fill,
        placeholder: (context, url) {
          return Center(
            child: MyLoader(),
          );
        },
      ),
    );
  }

  Widget getTrendingPostUI() {
    return _journalPageController.trendingJournalsList.isNotEmpty
        ? SizedBox(
            height: 340,
            child: Obx(() {
              return Stack(
                alignment: Alignment.center,
                children: [
                  _journalPageController.trendingJournalsList.length > 2
                      ? Positioned(
                          child: getPostCard2(
                              _journalPageController.trendingJournalsList[2]))
                      : Container(),
                  _journalPageController.trendingJournalsList.length > 1
                      ? Positioned(
                          child: getPostCard(
                              _journalPageController.trendingJournalsList[1]))
                      : Container(),
                  Positioned(
                      child: getDraggable(
                          _journalPageController.trendingJournalsList[0]))
                ],
              );
            }))
        : Container();
  }

  Widget getDraggable(Journals journal) {
    return Draggable(
      affinity: Axis.horizontal,
      data: "data",
      feedback: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.5,
          height: 300,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: Colors.white,
              image: const DecorationImage(
                  fit: BoxFit.fill,
                  // image: journal.mediaUrl != null
                  //     ? CachedNetworkImageProvider(journal.mediaUrl ?? '')
                  //     : AssetImage(
                  //         'assets/images/backgroundScaffold.png',
                  //       ) as ImageProvider),
                  image: AssetImage('assets/images/backgroundScaffold.png')),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 5.0,
                  spreadRadius: 2,
                )
              ],
              border: Border.all(
                color: SolhColors.greyS200,
              )),
          child: getPostContent(journal, 12),
        ),
      ),
      childWhenDragging: Container(),
      onDragEnd: (data) {
        _journalPageController.trendingJournalsList.insert(
            _journalPageController.trendingJournalsList.length,
            _journalPageController.trendingJournalsList[0]);
        _journalPageController.trendingJournalsList.removeAt(0);

        _journalPageController.trendingJournalsList.refresh();
        print("dragged");
      },
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  CommentScreen(journalModel: journal, index: -1)));
        },
        child: Obx(() => Container(
              // height: MediaQuery.of(context).size.height * 0.5,
              height: 300,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          Get.find<ProfileController>()
                                  .orgColor1
                                  .value
                                  .isNotEmpty
                              ? Color(int.parse(
                                  "0xFF${Get.find<ProfileController>().orgColor2}"))
                              : SolhColors.primary_green,
                          BlendMode.color),
                      image: const AssetImage('assets/images/trending_bg.png')),
                  gradient: journal.postedBy!.userType == 'Official'
                      ? const LinearGradient(
                          stops: [0.1, 0.9],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 173, 215, 204),
                            Color.fromARGB(255, 201, 156, 157),
                          ],
                        )
                      : const LinearGradient(colors: [
                          SolhColors.greenShade4,
                          SolhColors.greenShade4,
                        ]),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 5.0,
                      spreadRadius: 2,
                    )
                  ],
                  border: Border.all(
                    color: SolhColors.greyS200,
                  )),
              child: getPostContent(journal, 12),
            )),
      ),
    );
  }

  Widget getPostCard(Journals journal) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.4,
      height: 240,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 5.0,
              spreadRadius: 2,
            )
          ],
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/trending_bg.png',
              )),
          border: Border.all(color: Colors.grey[200]!),
          color: Colors.white),
      child: getPostContent(journal, 10),
    );
  }

  getPostCard2(Journals journal) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.3,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 5.0,
              spreadRadius: 2,
            )
          ],
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/trending_bg.png',
              )),
          color: Colors.white),
      child: getPostContent(journal, 7),
    );
  }

  Widget getTrendingPostShimmer() {
    return Shimmer(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.grey[400]!,
          Colors.grey[500]!,
          Colors.grey[600]!,
          Colors.grey[700]!,
        ],
      ),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.5,
        height: 300,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!), color: Colors.white),
      ),
    );
  }

  Widget getPostContent(Journals journal, int maxLine) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getUserTile(journal),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromRGBO(255, 255, 255, 0.9)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                journal.feelings!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: Wrap(
                          children: journal.feelings!.length > 3
                              ? journal.feelings!
                                  .sublist(0, 3)
                                  .map((e) => Text(
                                        '${e.feelingName}',
                                        style: SolhTextStyles.QS_caption_bold
                                            .copyWith(
                                                color: SolhColors.primaryRed),
                                      ))
                                  .toList()
                              : journal.feelings!
                                  .map((e) => Text(
                                        '${e.feelingName}',
                                        style: SolhTextStyles.QS_caption_bold
                                            .copyWith(
                                                color: SolhColors.primaryRed),
                                      ))
                                  .toList(),
                        ),
                      )
                    : Container(),
                journal.description!.trim().isEmpty
                    ? const SizedBox(
                        height: 0,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: Text(
                          journal.description ?? '',
                          style: SolhTextStyles.QS_cap_semi,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                journal.mediaUrl == null
                    ? const SizedBox()
                    : journal.mediaUrl!.trim().isEmpty
                        ? const SizedBox()
                        : Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                  imageUrl: journal.mediaUrl ?? ''),
                            ),
                          )
              ],
            ),
          ),
        ))
      ],
    );
  }

  Widget getImgShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!), color: Colors.white),
      ),
    );
  }

  Widget getSolhBuddiesUI() {
    return Container(
      height: 270,
      margin: EdgeInsets.only(bottom: 2.h),
      child: Obx(() {
        return getHelpController.solhVolunteerList.value.provider != null &&
                getHelpController.solhVolunteerList.value.provider!.isNotEmpty
            ? ListView.separated(
                padding: EdgeInsets.only(left: 2.h),
                separatorBuilder: (_, __) => SizedBox(width: 2.w),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount:
                    getHelpController.solhVolunteerList.value.provider!.length,
                itemBuilder: (context, index) => SolhVolunteers(
                      bio: getHelpController
                              .solhVolunteerList.value.provider![index].bio ??
                          '',
                      name: getHelpController
                              .solhVolunteerList.value.provider![index].name ??
                          '',
                      mobile: getHelpController.solhVolunteerList.value
                              .provider![index].contactNumber ??
                          '',
                      imgUrl: getHelpController.solhVolunteerList.value
                          .provider![index].profilePicture,
                      sId: getHelpController
                          .solhVolunteerList.value.provider![index].sId,
                      uid: getHelpController
                          .solhVolunteerList.value.provider![index].uid,
                      comments: getHelpController
                          .solhVolunteerList.value.provider![index].postCount
                          .toString(),
                      connections: getHelpController.solhVolunteerList.value
                          .provider![index].connectionsCount
                          .toString(),
                      likes: getHelpController
                          .solhVolunteerList.value.provider![index].likesCount
                          .toString(),
                      userType: getHelpController
                          .solhVolunteerList.value.provider![index].userType,
                      post: getHelpController.solhVolunteerList.value
                              .provider![index].postCount ??
                          0,
                    ))
            : solhBuddiesShimmer(context);
      }),
    );
  }

  Widget getGoalSettingUI(GoalSettingController goalSettingController) {
    return Obx(() {
      return goalSettingController.pesonalGoalModel.value.goalList != null
          ? (goalSettingController.pesonalGoalModel.value.goalList!.isEmpty
              ? Text('Take the first step'.tr,
                  style: GoogleFonts.signika(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ))
              : GoalName())
          : Container();
    });
  }

  Widget getRecommendedGroupsUI() {
    return Container(
        padding: EdgeInsets.only(bottom: 2.h),
        height: MediaQuery.of(context).size.height * 0.4,
        child: discoverGroupController
                    .homepageGroupModel.value.groupList!.isEmpty ||
                discoverGroupController.homepageGroupModel.value.groupList ==
                    null
            ? const Center(
                child: Text(
                "No groups to explore !",
                style: SolhTextStyles.QS_body_1_bold,
              ))
            : ListView.separated(
                padding: EdgeInsets.only(left: 2.h),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (() {
                      /*   Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GroupDetailsPage(
                            group: discoverGroupController
                                .discoveredGroupModel.value.groupList![index],
                          ))); */
                      print(
                        discoverGroupController
                            .homepageGroupModel.value.groupList
                            .toString(),
                      );
                      Navigator.pushNamed(context, AppRoutes.groupDetails,
                          arguments: {
                            "groupId": discoverGroupController
                                .homepageGroupModel.value.groupList![index].sId,
                            // "isJoined": false
                          });
                    }),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: SolhColors.primary_green, width: 0.7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: discoverGroupController
                                          .homepageGroupModel
                                          .value
                                          .groupList![index]
                                          .groupMediaUrl !=
                                      null
                                  ? CachedNetworkImage(
                                      imageUrl: discoverGroupController
                                              .homepageGroupModel
                                              .value
                                              .groupList![index]
                                              .groupMediaUrl ??
                                          '',
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/images/no-image-available_err.png',
                                        fit: BoxFit.cover,
                                      ),
                                      placeholder: (context, url) =>
                                          getImgShimmer(),
                                    )
                                  : Image.asset(
                                      'assets/images/group_placeholder.png',
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              top: 8,
                            ),
                            child: Text(
                              discoverGroupController.homepageGroupModel.value
                                      .groupList![index].groupName ??
                                  '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: SolhTextStyles.QS_body_2_bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.person_3,
                                  color: SolhColors.primary_green,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  discoverGroupController.homepageGroupModel
                                      .value.groupList![index].groupMembers!
                                      .toString(),
                                  style: SolhTextStyles.QS_caption_bold,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                SvgPicture.asset(
                                  'assets/images/eye.svg',
                                  color: SolhColors.primary_green,
                                  height: 11,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  discoverGroupController.homepageGroupModel
                                      .value.groupList![index].journalCount
                                      .toString(),
                                  style: SolhTextStyles.QS_caption_bold,
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 8.0),
                          //   child: Text(
                          //     discoverGroupController.homepageGroupModel.value
                          //             .groupList![index].groupDescription ??
                          //         '',
                          //     style: SolhTextStyles.JournalingHintText,
                          //     maxLines: 3,
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
                          Obx(() {
                            return discoverGroupController.homepageGroupModel
                                    .value.groupList![index].isUserJoined!
                                ? Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SolhGreenBorderMiniButton(
                                            height: 35,
                                            child: Text(
                                              'Joined',
                                              style: SolhTextStyles.CTA
                                                  .copyWith(
                                                      color: SolhColors
                                                          .primary_green),
                                            )),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SolhGreenMiniButton(
                                            onPressed: () async {
                                              await Get.find<
                                                      CreateGroupController>()
                                                  .joinGroup(
                                                      groupId:
                                                          discoverGroupController
                                                              .homepageGroupModel
                                                              .value
                                                              .groupList![index]
                                                              .sId!,
                                                      isAnon: "false");
                                              discoverGroupController
                                                  .getHomePageGroup();
                                              // setState(() {});
                                            },
                                            height: 35,
                                            child: Obx(() {
                                              return Get.find<CreateGroupController>()
                                                          .isLoading
                                                          .value ||
                                                      discoverGroupController
                                                          .isHomePageGroupLoading
                                                          .value
                                                  ? const ButtonLoadingAnimation(
                                                      ballColor:
                                                          SolhColors.white,
                                                    )
                                                  : Text(
                                                      'Join',
                                                      style: SolhTextStyles.CTA
                                                          .copyWith(
                                                              color: SolhColors
                                                                  .white),
                                                    );
                                            })),
                                      ],
                                    ),
                                  );
                          })
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemCount: discoverGroupController
                            .homepageGroupModel.value.groupList!.length >
                        10
                    ? 10
                    : discoverGroupController
                        .homepageGroupModel.value.groupList!.length));
  }

  getInteractionButton(Journals journal) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            border: const Border.fromBorderSide(
              BorderSide(
                color: SolhColors.greyS200,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.thumb_up_alt_outlined,
                    color: SolhColors.primary_green,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    journal.likes.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: SolhColors.primary_green,
                    ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 20,
                color: SolhColors.primary_green,
              ),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.chat_bubble,
                    color: SolhColors.primary_green,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    journal.comments.toString(),
                    style: const TextStyle(
                      color: SolhColors.primary_green,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  solhBuddiesShimmer(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 10,
          );
        },
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: 150,
              width: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100]),
            ),
          );
        },
      ),
    );
  }

  getRecommendedReadsUI() {
    return Obx(() {
      return connectionController.isBlogLoading.value
          ? solhBuddiesShimmer(context)
          : Container(
              height: 270,
              margin: EdgeInsets.only(bottom: 2.h),
              child: ListView.separated(
                padding: EdgeInsets.only(left: 2.h),
                separatorBuilder: (_, __) => SizedBox(width: 2.w),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: connectionController.bloglist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlogDetailsPage(
                                  id: connectionController.bloglist[index].id ??
                                      0)));
                    },
                    child: Container(
                      height: 150,
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: SolhColors.white,
                        border: Border.all(
                          color: SolhColors.greyS200,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  connectionController.bloglist[index].image ??
                                      '',
                              height: 98,
                              width: 180,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[100]),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  connectionController.bloglist[index].name ??
                                      '',
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.eye,
                                      color: SolhColors.primary_green,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      connectionController.bloglist[index].views
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: SolhColors.primary_green,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  connectionController
                                          .bloglist[index].description ??
                                      '',
                                  maxLines: 5,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: SolhColors.grey,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
    });
  }

  getUserTile(Journals journal) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromRGBO(255, 255, 255, 0.90)),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  !journal.anonymousJournal!
                      ? journal.postedBy!.profilePicture ?? ''
                      : journal.postedBy!.anonymous!.profilePicture ?? ''),
              backgroundColor: SolhColors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  !journal.anonymousJournal!
                      ? journal.postedBy!.name ?? ''
                      : journal.postedBy!.anonymous!.userName ?? 'Anonymous',
                  style: SolhTextStyles.QS_caption_bold,
                ),
                Row(
                  children: [
                    Text(
                      timeago.format(DateTime.parse(journal.createdAt ?? '')),
                      style: SolhTextStyles.QS_caption_2_bold,
                    ),
                    journal.postedBy != null &&
                            !journal.anonymousJournal! &&
                            journal.postedBy!.userType == "Official"
                        ? const SolhExpertBadge(
                            usertype: 'Official',
                          )
                        : journal.postedBy != null &&
                                !journal.anonymousJournal! &&
                                journal.postedBy!.userType == "SolhProvider"
                            ? const SolhExpertBadge(
                                usertype: 'Counsellor',
                              )
                            : journal.postedBy != null &&
                                    !journal.anonymousJournal! &&
                                    journal.postedBy!.userType ==
                                        "SolhVolunteer"
                                ? const SolhExpertBadge(
                                    usertype: 'Volunteer',
                                  )
                                : journal.postedBy != null &&
                                        !journal.anonymousJournal! &&
                                        journal.postedBy!.userType == "Seeker"
                                    ? Container()
                                    : Container(),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getTestUI() {
    return Obx(() => psychologyTestController.isLoadingList.value
        ? const SizedBox()
        : Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(4.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Self Assessment'.tr,
                            style: SolhTextStyles.QS_body_semi_1,
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                constraints: BoxConstraints(maxHeight: 70.h),
                                isScrollControlled: true,
                                context: context,
                                enableDrag: true,
                                isDismissible: true,
                                builder: (context) {
                                  return showSelfAssessmentDisclaimer(context);
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.info,
                              size: 15,
                              color: SolhColors.grey,
                            ),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.psychologyTest),
                        child: Text(
                          "View all",
                          style: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.primary_green),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 180,
                child: ListView(
                  padding: const EdgeInsets.only(left: 10),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: psychologyTestController.testList.length > 5
                      ? List.generate(
                          5,
                          (index) => PsychoTestContainer(
                                test: psychologyTestController.testList[index],
                                psychologyTestController:
                                    psychologyTestController,
                              ))
                      : psychologyTestController.testList
                          .map(
                            (element) => PsychoTestContainer(
                              test: element,
                              psychologyTestController:
                                  psychologyTestController,
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          ));
  }
}

class PsychoTestContainer extends StatelessWidget {
  const PsychoTestContainer(
      {super.key, required this.test, required this.psychologyTestController});
  final TestList test;
  final PsychologyTestController psychologyTestController;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        psychologyTestController.selectedQuestion.clear();
        psychologyTestController.score.clear();
        psychologyTestController.submitAnswerModelList.clear();
        psychologyTestController.getQuestion(test.sId ?? '');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TestQuestionsPage(
            id: test.sId,
            testTitle: test.testTitle,
          );
        }));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 225,
                child: CachedNetworkImage(
                  imageUrl: test.testPicture ?? '',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              height: 90,
              width: 225,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(0.01),
                  Colors.black26,
                  Colors.black45,
                  Colors.black87,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      test.testTitle ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: SolhTextStyles.QS_body_1_bold.copyWith(
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.list_bullet,
                              size: 12,
                              color: Colors.white,
                            ),
                            Text(
                              " ${test.testQuestionNumber.toString()} ques.",
                              style: SolhTextStyles.QS_caption.copyWith(
                                  color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const SolhDot(
                          color: SolhColors.white,
                          size: 3,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.clock,
                              size: 12,
                              color: Colors.white,
                            ),
                            Text(
                              " ${test.testDuration} min",
                              style: SolhTextStyles.QS_caption.copyWith(
                                  color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget getIssueUI(
    bookAppointmentController, GetHelpController getHelpController, context) {
  return Obx(() {
    return Wrap(
      runSpacing: 5,
      children: getHelpController.issueList.map<Widget>((issue) {
        return IssuesTile(
          title: issue.name ?? '',
          onPressed: () {
            bookAppointmentController.query = issue.name;
            Navigator.pushNamed(context, AppRoutes.consultantAlliedParent,
                arguments: {
                  "id": issue.sId,
                  "slug": issue.sId ?? '',
                  "type": 'issue',
                  "enableAppbar": false
                });
          },
        );
      }).toList(),
    );
  });
}

class ChatAnonymouslyCard extends StatelessWidget {
  ChatAnonymouslyCard({Key? key}) : super(key: key);
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showDialog(context: context, builder: (context) => AnonymousDialog());
        },
        child: Obx(() => Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      profileController.orgColor1.value.isNotEmpty
                          ? Color(
                              int.parse("0xFF${profileController.orgColor1}"))
                          : SolhColors.primary_green,
                      BlendMode.color),
                  image: const AssetImage(
                      'assets/images/ScaffoldBackgroundGreen.png'),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 4.w, right: 4.w, top: 2.h, bottom: 1.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 60.w,
                          child: Text(
                            'Overwhelmed with emotions? Talk to a Solh counselor NOW'
                                .tr,
                            style: SolhTextStyles.QS_body_1_bold.copyWith(
                                color: SolhColors.white),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  profileController.orgColor1.value.isNotEmpty
                                      ? Color(int.parse(
                                          "0xFF${profileController.orgColor1}"))
                                      : SolhColors.primary_green,
                              border: Border.all(
                                  color: SolhColors.white, width: 1)),
                          child: const Center(
                              child: Icon(
                            CupertinoIcons.arrow_right,
                            color: SolhColors.white,
                          )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        getIssuesRowItem(
                            const Image(
                                image:
                                    AssetImage('assets/images/saddness.png')),
                            'Sadness'.tr),
                        getIssuesRowItem(
                            const Image(
                                image:
                                    AssetImage('assets/images/loneliness.png')),
                            'Loneliness'.tr),
                        getIssuesRowItem(
                            const Image(
                                image: AssetImage('assets/images/stress.png')),
                            'Stress'.tr),
                        getIssuesRowItem(
                            Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: SolhColors.white),
                              child: const Center(child: Text('20+')),
                            ),
                            'More'.tr)
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const Divider(
                      color: SolhColors.white,
                      thickness: 1,
                    ),
                    Text(
                      'Start chatting for free right away, with a Solh counselor.'
                          .tr,
                      style: SolhTextStyles.QS_caption.copyWith(
                          color: SolhColors.white, fontSize: 9.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )));
  }
}

getIssuesRowItem(Widget widget, String subtext) {
  return Column(
    children: [
      Container(
        height: 15.w,
        width: 15.w,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: widget,
      ),
      Text(
        subtext,
        style: SolhTextStyles.QS_caption.copyWith(color: SolhColors.white),
      )
    ],
  );
}

class AlliedExperts extends StatelessWidget {
  AlliedExperts({super.key, required this.onTap});
  final GetHelpController getHelpController = Get.find();
  final ProfileController profileController = Get.find();

  final Function(String slug, String name, String id) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Allied Experts'.tr,
                style: SolhTextStyles.QS_body_semi_1,
              ),
              InkWell(
                onTap: () {
                  getHelpController.getAlliedTherapyListMore();
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
                child: Text(
                  'Show More'.tr,
                  style: SolhTextStyles.CTA
                      .copyWith(color: SolhColors.primary_green),
                ),
              )
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(() => getHelpController
                      .getAlliedTherapyModel.value.specializationList ==
                  null
              ? Container()
              : GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      childAspectRatio: 2 / 2.6),
                  shrinkWrap: true,
                  itemCount: getHelpController
                      .getAlliedTherapyModel.value.specializationList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          onTap(
                              getHelpController.getAlliedTherapyModel.value
                                      .specializationList![index].slug ??
                                  '',
                              getHelpController.getAlliedTherapyModel.value
                                      .specializationList![index].name ??
                                  '',
                              getHelpController.getAlliedTherapyModel.value
                                      .specializationList![index].id ??
                                  '');
                        },
                        child: Obx(() => profileController.myProfileModel.value.body == null
                            ? const SizedBox()
                            : AlliedCardWithDiscount(
                                image: getHelpController
                                        .getAlliedTherapyModel
                                        .value
                                        .specializationList![index]
                                        .displayImage ??
                                    '',
                                name: getHelpController.getAlliedTherapyModel.value.specializationList![index].name ??
                                    '',
                                discount:
                                    profileController.myProfileModel.value.body!.userOrganisations!.isNotEmpty &&
                                            profileController
                                                    .myProfileModel
                                                    .value
                                                    .body!
                                                    .userOrganisations!
                                                    .first
                                                    .status ==
                                                'Approved'
                                        ? getHelpController
                                            .getAlliedTherapyModel
                                            .value
                                            .specializationList![index]
                                            .orgMarketPlaceOffer
                                        : null)));
                  },
                )),
        ],
      ),
    );
  }
}

class AlliedCarousel extends StatefulWidget {
  const AlliedCarousel({super.key});

  @override
  State<AlliedCarousel> createState() => _AlliedCarouselState();
}

class _AlliedCarouselState extends State<AlliedCarousel> {
  int _current = 0;

  CarouselController carouselController = CarouselController();
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.isBannerLoading.value
        ? Container()
        : homeController.homePageCarouselModel.value.packageCarouselList == null
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  homeController.homePageCarouselModel.value
                          .packageCarouselList!.isEmpty
                      ? Container()
                      : CarouselSlider.builder(
                          carouselController: carouselController,
                          itemCount: homeController.homePageCarouselModel.value
                              .packageCarouselList!.length,
                          itemBuilder: ((context, index, realIndex) {
                            return InkWell(
                              onTap: () {
                                if (homeController
                                        .homePageCarouselModel
                                        .value
                                        .packageCarouselList![index]
                                        .routeName ==
                                    "providerList") {
                                  Navigator.pushNamed(
                                      context, AppRoutes.viewAllAlliedExpert,
                                      arguments: {
                                        "slug": homeController
                                                .homePageCarouselModel
                                                .value
                                                .packageCarouselList![index]
                                                .routeKey ??
                                            '',
                                        "name": homeController
                                                .homePageCarouselModel
                                                .value
                                                .packageCarouselList![index]
                                                .routeKey ??
                                            '',
                                        "type": 'specialization',
                                        "enableAppbar": true
                                      });
                                  //       Navigator.pushNamed(context, AppRoutes.viewAllAlliedExpert,
                                  // arguments: {
                                  //   "slug": value,
                                  //   "name": value,
                                  //   "type": 'specialization',
                                  //   "enableAppbar": true
                                  // });
                                } else {
                                  print(
                                      'routekey ${homeController.homePageCarouselModel.value.packageCarouselList![index].routeKey}');
                                  Navigator.pushNamed(
                                      context, AppRoutes.inhousePackage,
                                      arguments: {
                                        "id": homeController
                                            .homePageCarouselModel
                                            .value
                                            .packageCarouselList![index]
                                            .routeKey
                                      });
                                }
                              },
                              child: SizedBox(
                                  height: 20.h,
                                  width: 100.w,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(homeController
                                                .homePageCarouselModel
                                                .value
                                                .packageCarouselList![index]
                                                .image ??
                                            '')),
                                  )),
                            );
                          }),
                          options: CarouselOptions(
                              autoPlay: false,
                              padEnds: true,
                              viewportFraction: 0.75,
                              enlargeCenterPage: true,
                              onPageChanged: ((index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              })),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: homeController.dotList
                        .map((e) => Container(
                              height: e == _current ? 6 : 5,
                              width: e == _current ? 6 : 5,
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: e == _current
                                    ? SolhColors.dark_grey
                                    : SolhColors.grey_3,
                              ),
                            ))
                        .toList(),
                  )
                ],
              ));
  }
}

class AnonymousDialog extends StatelessWidget {
  AnonymousDialog({super.key});
  final ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: (() => Navigator.of(context).pop()),
                child: const Icon(
                  CupertinoIcons.xmark,
                )),
          ],
        ),
        SizedBox(
          height: 3.w,
        ),
        Text(
          'Talk Now'.tr,
          style: SolhTextStyles.QS_big_body.copyWith(color: SolhColors.pink224),
        ),
        SizedBox(
          height: 3.w,
        ),
        Text(
          'Get connected to a Solh counselor'.tr,
          style: SolhTextStyles.QS_body_semi_1,
        ),
        SizedBox(
          height: 5.w,
        ),
        RichText(
            text: TextSpan(
                text: "DISCLAMER".tr,
                style: SolhTextStyles.QS_body_semi_1,
                children: [
              TextSpan(
                  text:
                      ': We are not a medical emergency or suicide prevention service . If you are feeling suicidal, please call a helpline such as the National Suicide Prevention Lifeline at 1-800-273-8255 or the Vandrevala Foundation Helpline at 1-860-266-2345 or Aasra at +91-22-2754-6669 immediately.'
                          .tr,
                  style: SolhTextStyles.QS_body_2_semi)
            ])),
        SizedBox(
          height: 15.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SolhGreenBorderMiniButton(
              onPressed: (() => Navigator.of(context).pop()),
              child: Text(
                'Cancel'.tr,
                style: SolhTextStyles.CTA,
              ),
            ),
            SizedBox(
              width: 6.w,
            ),
            SolhGreenMiniButton(
              onPressed: () {
                // profileController.myProfileModel.value.body!.user!.anonymous ==
                //         null
                //     ? Navigator.pushNamed(context, AppRoutes.anonymousProfile,
                //         arguments: {
                //             "formAnonChat": true,
                //             "indexOfpage": 0,
                //           })
                //     : Navigator.pushNamed(context, AppRoutes.waitingScreen,
                //         arguments: {
                //             "formAnonChat": true,
                //             "indexOfpage": 0,
                //           });
                Navigator.of(context).pop();
                profileController.myProfileModel.value.body!.user!.anonymous ==
                        null
                    ? Navigator.pushNamed(context, AppRoutes.anonymousProfile,
                        arguments: {
                            "formAnonChat": true,
                            "indexOfpage": 0,
                          })
                    : Navigator.pushNamed(context, AppRoutes.waitingScreen,
                        arguments: {
                            "formAnonChat": true,
                            "indexOfpage": 0,
                          });
                FirebaseAnalytics.instance.logEvent(
                    name: 'AnonymousChatCardTapped',
                    parameters: {'Page': 'HomePage'});
              },
              child: Text(
                'Connect'.tr,
                style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
              ),
            ),
          ],
        )
      ]),
    );
  }
}

Widget showInfoDialog(context) {
  log(AppLocale.appLocale.languageCode);
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Container(
                height: 6,
                width: 30,
                decoration: BoxDecoration(
                    color: SolhColors.grey,
                    borderRadius: BorderRadius.circular(8)),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.cancel_sharp,
                    size: 30,
                    color: SolhColors.grey,
                  ))
            ],
          ),
          Html(
              data: AppLocale.appLocale.languageCode == "hi"
                  ? infoHtmlHindi
                  : infoHtml),
        ],
      ),
    ),
  );
}

Widget showSelfAssessmentDisclaimer(context) {
  log(AppLocale.appLocale.languageCode);
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Container(
                height: 6,
                width: 30,
                decoration: BoxDecoration(
                    color: SolhColors.grey,
                    borderRadius: BorderRadius.circular(8)),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.cancel_sharp,
                    size: 30,
                    color: SolhColors.grey,
                  ))
            ],
          ),
          Html(
              data: AppLocale.appLocale.languageCode == "hi"
                  ? disclaimerHtmlHindi
                  : disclaimerHtml),
          const SizedBox(
            height: 90,
          )
        ],
      ),
    ),
  );
}

class OrgOfferCaurousel extends StatelessWidget {
  OrgOfferCaurousel({super.key});
  final CarouselController carouselController = CarouselController();
  final _controller = Get.put(OfferCarouselController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      log(_controller.isGettingOffers.value.toString(),
          name: '_controller.isGettingOffers.value');
      return _controller.isGettingOffers.value
          ? MyLoader()
          : _controller.offerCarouselModel.value.data == null
              ? const SizedBox()
              : _controller.offerCarouselModel.value.data!.isEmpty
                  ? Container()
                  : Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              child: Text(
                                'Offers',
                                style: SolhTextStyles.QS_body_semi_1,
                              ),
                            ),
                          ],
                        ),
                        CarouselSlider.builder(
                          carouselController: carouselController,
                          itemCount:
                              _controller.offerCarouselModel.value.data!.length,
                          itemBuilder: ((context, index, realIndex) {
                            return SizedBox(
                                height: 20.h,
                                width: 100.w,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(_controller
                                              .offerCarouselModel
                                              .value
                                              .data![index]
                                              .image ??
                                          '')),
                                ));
                          }),
                          options: CarouselOptions(
                            autoPlay: false,
                            padEnds: true,
                            viewportFraction: 0.75,
                            enlargeCenterPage: true,
                            onPageChanged: ((index, reason) {
                              // setState(() {
                              //   _current = index;
                              // });
                            }),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        )
                      ],
                    );
    });
  }
}
