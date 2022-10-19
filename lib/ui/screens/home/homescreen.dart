import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/goal-setting/goal_setting_controller.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/ui/screens/comment/comment-screen.dart';
import 'package:solh/ui/screens/get-help/view-all/view_all_volunteers.dart';
import 'package:solh/ui/screens/groups/group_detail.dart';
import 'package:solh/ui/screens/groups/manage_groups.dart';
import 'package:solh/ui/screens/home/blog_details.dart';
import 'package:solh/ui/screens/my-goals/my-goals-screen.dart';
import 'package:solh/ui/screens/my-goals/select_goal.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:upgrader/upgrader.dart';
import '../../../bloc/user-bloc.dart';
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
import '../../../model/journals/journals_response_model.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../get-help/get-help.dart';
import '../get-help/view-all/consultants.dart';
import '../journaling/side_drawer.dart';
import '../journaling/whats_in_your_mind_section.dart';
import '../journaling/widgets/solh_expert_badge.dart';
import '../mood-meter/mood_meter.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CreateGroupController _controller = Get.put(CreateGroupController());
  JournalPageController _journalPageController =
      Get.put(JournalPageController());
  final VideoTutorialController videoTutorialController =
      Get.put(VideoTutorialController());

  MyDiaryController myDiaryController = Get.put(MyDiaryController());
  GetHelpController getHelpController = Get.put(GetHelpController());
  final DiscoverGroupController discoverGroupController =
      Get.put(DiscoverGroupController());
  ConnectionController connectionController = Get.put(ConnectionController());
  FeelingsController feelingsController = Get.put(FeelingsController());
  BookAppointmentController bookAppointmentController = Get.find();

  JournalCommentController journalCommentController =
      Get.put(JournalCommentController());
  MoodMeterController moodMeterController = Get.find();
  late bool isMoodMeterShown;

  @override
  void initState() {
    super.initState();
    userBlocNetwork.getMyProfileSnapshot();
    openMoodMeter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SideDrawer(),
            HomePage(),
          ],
        ),
      ),
    );
  }

  Future<void> openMoodMeter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('lastDateShown') != null) {
      if (DateTime.fromMillisecondsSinceEpoch(prefs.getInt('lastDateShown')!)
              .day ==
          DateTime.now().day) {
        return;
      } else {
        if (moodMeterController.moodList.length > 0) {
          showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) {
                return Scaffold(body: MoodMeter());
              });
        }

        prefs.setBool('moodMeterShown', true);
        prefs.setInt('lastDateShown', DateTime.now().millisecondsSinceEpoch);
      }
    } else {
      // await moodMeterController.getMoodList();
      showGeneralDialog(
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) {
            return Scaffold(body: MoodMeter());
          });

      prefs.setBool('moodMeterShown', true);
      prefs.setInt('lastDateShown', DateTime.now().millisecondsSinceEpoch);
    }
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  BottomNavigatorController _controller = Get.find();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  JournalPageController _journalPageController = Get.find();
  GetHelpController getHelpController = Get.find();
  DiscoverGroupController discoverGroupController = Get.find();
  BottomNavigatorController _bottomNavigatorController = Get.find();
  BookAppointmentController bookAppointmentController = Get.find();
  GoalSettingController goalSettingController = Get.find();
  ConnectionController connectionController = Get.find();
  // bool _isDrawerOpen = false;
  List<String> feelingList = [];

  @override
  void initState() {
    super.initState();
    getAnnouncement();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedPositioned(
        duration: Duration(milliseconds: 300),
        left: _bottomNavigatorController.isDrawerOpen.value ? 78.w : 0,
        child: Container(
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Scaffold(
                appBar: getAppBar(),
                body: UpgradeAlert(
                  upgrader: Upgrader(
                      showIgnore: false,
                      onLater: () {
                        SystemNavigator.pop();
                        return true;
                      }),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      GetHelpDivider(),
                      WhatsOnYourMindSection(),
                      GetHelpDivider(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GetHelpCategory(
                            title: 'Trending Posts',
                          ),
                          InkWell(
                            onTap: () {
                              _bottomNavigatorController.tabrouter!
                                  .setActiveIndex(1);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Journaling',
                                      style: GoogleFonts.signika(
                                        color: SolhColors.green,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: SolhColors.green,
                                      size: 14,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Obx(() {
                        return _journalPageController.isTrendingLoading.value
                            ? getTrendingPostShimmer()
                            : getTrendingPostUI();
                      }),
                      GetHelpDivider(),
                      Obx(() {
                        return !connectionController
                                .isRecommnedationLoadingHome.value
                            ? connectionController.peopleYouMayKnowHome.value
                                            .reccomendation !=
                                        null &&
                                    connectionController.peopleYouMayKnowHome
                                        .value.reccomendation!.isNotEmpty
                                ? GetHelpCategory(
                                    title: 'Solh Mates',
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ViewAllVolunteers();
                                      }));
                                    },
                                  )
                                : Container()
                            : Container();
                      }),
                      Obx(() {
                        return !connectionController
                                .isRecommnedationLoadingHome.value
                            ? connectionController.peopleYouMayKnowHome.value
                                            .reccomendation !=
                                        null &&
                                    connectionController.peopleYouMayKnowHome
                                        .value.reccomendation!.isNotEmpty
                                ? getPeopleYouMayKnowUI()
                                : Container()
                            : getRecommnededShimmer();
                      }),
                      Obx(() {
                        return !connectionController
                                .isRecommnedationLoadingHome.value
                            ? connectionController.peopleYouMayKnowHome.value
                                            .reccomendation !=
                                        null &&
                                    connectionController.peopleYouMayKnowHome
                                        .value.reccomendation!.isNotEmpty
                                ? GetHelpDivider()
                                : Container()
                            : Container();
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GetHelpCategory(
                            title: 'Goals',
                          ),
                          InkWell(
                            onTap: () {
                              _bottomNavigatorController.tabrouter!
                                  .setActiveIndex(3);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Row(
                                children: [
                                  Text(
                                    'Goal Setting',
                                    style: GoogleFonts.signika(
                                      color: SolhColors.green,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: SolhColors.green,
                                    size: 14,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      getGoalSettingUI(goalSettingController),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SolhGreenButton(
                          child: Text('Add Goals +'),
                          height: 50,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectGoal()));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GetHelpDivider(),
                      Obx(() => discoverGroupController
                                      .discoveredGroupModel.value.groupList !=
                                  null &&
                              discoverGroupController.discoveredGroupModel.value
                                      .groupList!.length >
                                  0
                          ? GetHelpCategory(
                              title: 'Groups For You',
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ManageGroupPage()));
                              })
                          : Container()),
                      Obx(() {
                        return discoverGroupController
                                        .discoveredGroupModel.value.groupList !=
                                    null &&
                                discoverGroupController.discoveredGroupModel
                                        .value.groupList!.length >
                                    0
                            ? getRecommendedGroupsUI()
                            : Container();
                      }),
                      GetHelpDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GetHelpCategory(
                            title: 'Search by issues',
                          ),
                          InkWell(
                            onTap: () {
                              _bottomNavigatorController.tabrouter!
                                  .setActiveIndex(2);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Row(
                                children: [
                                  Text(
                                    'Get Help',
                                    style: GoogleFonts.signika(
                                      color: SolhColors.green,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: SolhColors.green,
                                    size: 14,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      getIssueUI(bookAppointmentController, getHelpController,
                          context),
                      SizedBox(
                        height: 10,
                      ),
                      GetHelpDivider(),
                      GetHelpCategory(
                        title: "Top Consultants",
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ConsultantsScreen(
                                      slug: '',
                                      type: 'topconsultant',
                                    ))),
                      ),
                      Container(
                        height: 17.h,
                        margin: EdgeInsets.only(bottom: 2.h),
                        child: Obx(() => Container(
                            child: getHelpController
                                        .topConsultantList.value.doctors !=
                                    null
                                ? getHelpController.topConsultantList.value
                                        .doctors!.isEmpty
                                    ? Center(
                                        child: Text(
                                            'No Consultant available for your country'),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: getHelpController
                                                    .topConsultantList
                                                    .value
                                                    .doctors!
                                                    .length >
                                                5
                                            ? 5
                                            : getHelpController
                                                .topConsultantList
                                                .value
                                                .doctors!
                                                .length,
                                        itemBuilder: (_, index) {
                                          // print(getHelpController
                                          //     .topConsultantList
                                          //     .value
                                          //     .doctors![index]
                                          //     .profilePicture);
                                          return TopConsultantsTile(
                                            bio: getHelpController
                                                    .topConsultantList
                                                    .value
                                                    .doctors![index]
                                                    .bio ??
                                                '',
                                            name: getHelpController
                                                    .topConsultantList
                                                    .value
                                                    .doctors![index]
                                                    .name ??
                                                '',
                                            mobile: getHelpController
                                                    .topConsultantList
                                                    .value
                                                    .doctors![index]
                                                    .contactNumber ??
                                                '',
                                            imgUrl: getHelpController
                                                .topConsultantList
                                                .value
                                                .doctors![index]
                                                .profilePicture,
                                            sId: getHelpController
                                                .topConsultantList
                                                .value
                                                .doctors![index]
                                                .sId,
                                          );
                                        })
                                : Container())),
                      ),
                      GetHelpDivider(),
                      GetHelpCategory(
                        title: 'Solh Buddies to Talk',
                      ),
                      getSolhBuddiesUI(),
                      GetHelpDivider(),
                      GetHelpCategory(
                        title: 'Recommended reads',
                      ),
                      getRecommendedReadsUI(),
                      SizedBox(
                        height: 100,
                      ),
                    ]),
                  ),
                ),
              ),
              if (_bottomNavigatorController.isDrawerOpen.value)
                GestureDetector(
                  // onTap: () => setState(() => _isDrawerOpen = false),
                  onTap: () {
                    _bottomNavigatorController.isDrawerOpen.value = false;
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  SolhAppBar getAppBar() {
    return SolhAppBar(
      title: Row(
        children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: InkWell(
              onTap: () {
                print("side bar tapped");
                _bottomNavigatorController.isDrawerOpen.value = true;
                print("opened");
              },
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                height: 40,
                width: 30,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: SvgPicture.asset(
                  "assets/icons/app-bar/app-bar-menu.svg",
                  width: 26,
                  height: 24,
                  color: SolhColors.green,
                ),
              ),
            ),
          ),
          // SizedBox(
          //   width: 2.h,
          // ),
          // Text(
          //   "Home",
          //   style: SolhTextStyles.AppBarText,
          // ),
        ],
      ),
      isLandingScreen: true,
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
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  height: 595,
                  width: 375,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                        Expanded(child: announcementMedia(value))
                      ]),
                ),
              );
            });
        prefs.setInt(
            'lastDateShownAnnouncement', DateTime.now().millisecondsSinceEpoch);
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                height: 595,
                width: 375,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                      Expanded(child: announcementMedia(value))
                    ]),
              ),
            );
          });
      prefs.setInt(
          'lastDateShownAnnouncement', DateTime.now().millisecondsSinceEpoch);
    }
  }

  Future<void> getAnnouncement() async {
    _journalPageController.getHeaderAnnounce();
    Map<String, dynamic> map = await _journalPageController.getAnnouncement();
    openAnnouncement(map);
  }

  announcementMedia(Map<String, dynamic> value) {
    return CachedNetworkImage(
      imageUrl: value['media'],
      fit: BoxFit.fill,
    );
  }

  Widget getTrendingPostUI() {
    return _journalPageController.trendingJournalsList.isNotEmpty
        ? Container(
            // height: MediaQuery.of(context).size.height * 0.55,
            height: 340,
            child: Obx(() {
              return Stack(
                children: [
                  _journalPageController.trendingJournalsList.length > 2
                      ? Positioned(
                          right: 15,
                          top: 70,
                          left: 30,
                          child: getPostCard2(
                              _journalPageController.trendingJournalsList[2]))
                      : Container(),
                  _journalPageController.trendingJournalsList.length > 1
                      ? Positioned(
                          right: 30,
                          top: 40,
                          left: 30,
                          child: getPostCard(
                              _journalPageController.trendingJournalsList[1]))
                      : Container(),
                  Positioned(
                      left: 2.h,
                      top: 10,
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
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  CommentScreen(journalModel: journal, index: 0)));
        },
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.5,
          height: 300,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: SolhColors.grey217,
                  offset: const Offset(
                    5.0,
                    0.0,
                  ),
                  blurRadius: 5.0,
                  spreadRadius: 0,
                )
              ],
              border: Border.all(
                color: SolhColors.greyS200,
              )),
          child: getPostContent(journal, 12),
        ),
      ),
      feedback: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: SolhColors.grey217,
                  offset: const Offset(
                    5.0,
                    0.0,
                  ),
                  blurRadius: 5.0,
                  spreadRadius: 0,
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
    );
  }

  getPostCard(Journals journal) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.4,
      height: 240,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!), color: Colors.white),
      ),
    );
  }

  Widget getPostContent(Journals journal, int maxLine) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getUserTile(journal),
        Divider(height: 1),
        journal.feelings!.length > 0
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: journal.feelings!
                      .map((e) => Text(
                            '${e.feelingName}',
                            style: SolhTextStyles.JournalingHashtagText,
                          ))
                      .toList(),
                ),
              )
            : Container(),
        journal.description!.trim().isEmpty
            ? SizedBox(
                height: 0,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  journal.description ?? '',
                  style: SolhTextStyles.LandingParaText,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  imageUrl: journal.mediaUrl ?? '',
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(),
                  placeholder: (context, url) => getImgShimmer(),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: getInteractionButton(journal))
            ],
          ),
        ),
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
                getHelpController.solhVolunteerList.value.provider!.length > 0
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
                          .solhVolunteerList.value.provider![index].commentCount
                          .toString(),
                      connections: getHelpController.solhVolunteerList.value
                          .provider![index].connectionsCount
                          .toString(),
                      likes: getHelpController
                          .solhVolunteerList.value.provider![index].likesCount
                          .toString(),

                      /// ye deepak ne phir dobara se activete karwaya hai ///  featured only
                      userType: getHelpController
                          .solhVolunteerList.value.provider![index].userType,
                    ))
            : solhBuddiesShimmer(context);
      }),
    );
  }

  Widget getGoalSettingUI(GoalSettingController goalSettingController) {
    return Obx(() {
      return goalSettingController.pesonalGoalModel.value.goalList != null
          ? (goalSettingController.pesonalGoalModel.value.goalList!.length == 0
              ? Text('No Goals found',
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
        child: ListView.separated(
            padding: EdgeInsets.only(left: 2.h),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GroupDetailsPage(
                            group: discoverGroupController
                                .discoveredGroupModel.value.groupList![index],
                          )));
                }),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: SolhColors.greyS200,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: discoverGroupController.discoveredGroupModel
                                      .value.groupList![index].groupMediaUrl !=
                                  null
                              ? CachedNetworkImage(
                                  imageUrl: discoverGroupController
                                          .discoveredGroupModel
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
                          discoverGroupController.discoveredGroupModel.value
                                  .groupList![index].groupName ??
                              '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.signika(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff222222),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.person_3,
                              color: SolhColors.green,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              discoverGroupController.discoveredGroupModel.value
                                  .groupList![index].groupMembers!.length
                                  .toString(),
                              style: SolhTextStyles.JournalingHintText,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            SvgPicture.asset(
                              'assets/images/eye.svg',
                              color: SolhColors.green,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              discoverGroupController.discoveredGroupModel.value
                                  .groupList![index].journalCount
                                  .toString(),
                              style: SolhTextStyles.JournalingHintText,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          discoverGroupController.discoveredGroupModel.value
                                  .groupList![index].groupDescription ??
                              '',
                          style: SolhTextStyles.JournalingHintText,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
            itemCount: discoverGroupController
                        .discoveredGroupModel.value.groupList!.length >
                    10
                ? 10
                : discoverGroupController
                    .discoveredGroupModel.value.groupList!.length));
  }

  Widget getPeopleYouMayKnowUI() {
    return Container(
      height: 270,
      margin: EdgeInsets.only(bottom: 2.h),
      child: Obx(() {
        return ListView.separated(
          padding: EdgeInsets.only(left: 2.h),
          separatorBuilder: (_, __) => SizedBox(width: 2.w),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: connectionController
              .peopleYouMayKnowHome.value.reccomendation!.length,
          itemBuilder: (context, index) => SolhVolunteers(
            bio: connectionController.peopleYouMayKnowHome.value.reccomendation!
                .elementAt(index)
                .bio,
            name: connectionController
                .peopleYouMayKnowHome.value.reccomendation!
                .elementAt(index)
                .name,
            mobile: '',
            imgUrl: connectionController
                .peopleYouMayKnowHome.value.reccomendation!
                .elementAt(index)
                .profilePicture,
            sId: connectionController.peopleYouMayKnowHome.value.reccomendation!
                .elementAt(index)
                .sId,
            uid: connectionController.peopleYouMayKnowHome.value.reccomendation!
                .elementAt(index)
                .uid,
            comments: connectionController
                .peopleYouMayKnowHome.value.reccomendation!
                .elementAt(index)
                .commentCount
                .toString(),
            connections: connectionController
                .peopleYouMayKnowHome.value.reccomendation!
                .elementAt(index)
                .connectionsCount
                .toString(),
            likes: connectionController
                .peopleYouMayKnowHome.value.reccomendation!
                .elementAt(index)
                .likesCount
                .toString(),
            userType: null,
          ),
        );
      }),
    );
  }

  getInteractionButton(Journals journal) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            border: Border.fromBorderSide(
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
                  Icon(
                    Icons.thumb_up_alt_outlined,
                    color: SolhColors.green,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    journal.likes.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: SolhColors.green,
                    ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 20,
                color: SolhColors.green,
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.chat_bubble,
                    color: SolhColors.green,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    journal.comments.toString(),
                    style: TextStyle(
                      color: SolhColors.green,
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

  getRecommnededShimmer() {
    return Container(
      height: 270,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 190,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: SolhColors.greyS200,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300]!,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 20,
                        width: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey[300]!,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 20,
                        width: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey[300]!,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.thumb_up_alt_outlined,
                                color: SolhColors.green,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: SolhColors.green,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 20,
                            color: SolhColors.green,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.chat_bubble,
                                color: SolhColors.green,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                '0',
                                style: TextStyle(
                                  color: SolhColors.green,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 20,
                        width: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey[300]!,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  solhBuddiesShimmer(BuildContext context) {
    return Container(
      height: 270,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(
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
                itemCount: connectionController.bloglist.value.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlogDetailsPage(
                                  id: connectionController
                                          .bloglist.value[index].id ??
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
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: connectionController
                                      .bloglist.value[index].image ??
                                  '',
                              height: 100,
                              width: 180,
                              fit: BoxFit.fitWidth,
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
                                  connectionController
                                          .bloglist.value[index].name ??
                                      '',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.eye,
                                      color: SolhColors.green,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      connectionController
                                          .bloglist.value[index].views
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: SolhColors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  connectionController
                                          .bloglist.value[index].description ??
                                      '',
                                  maxLines: 5,
                                  style: TextStyle(
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
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                !journal.anonymousJournal!
                    ? journal.postedBy!.profilePicture ?? ''
                    : journal.postedBy!.anonymous!.profilePicture ?? ''),
            backgroundColor: SolhColors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                !journal.anonymousJournal!
                    ? journal.postedBy!.name ?? ''
                    : 'Anonymous',
                style: SolhTextStyles.JournalingUsernameText,
              ),
              Row(
                children: [
                  Text(
                    timeago.format(DateTime.parse(journal.createdAt ?? '')),
                    style: SolhTextStyles.JournalingTimeStampText,
                  ),
                  VerticalDivider(
                    color: SolhColors.grey,
                  ),
                  journal.postedBy != null &&
                          !journal.anonymousJournal! &&
                          journal.postedBy!.userType == "Official"
                      ? SolhExpertBadge(
                          usertype: 'Official',
                        )
                      : journal.postedBy != null &&
                              !journal.anonymousJournal! &&
                              journal.postedBy!.userType == "SolhProvider"
                          ? SolhExpertBadge(
                              usertype: 'Counsellor',
                            )
                          : journal.postedBy != null &&
                                  !journal.anonymousJournal! &&
                                  journal.postedBy!.userType == "SolhVolunteer"
                              ? SolhExpertBadge(
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
    );
  }
}

Widget getIssueUI(bookAppointmentController, getHelpController, context) {
  return Container(
      margin: EdgeInsets.only(bottom: 1.5.h),
      child: Obx(() {
        return Wrap(
          runSpacing: 5,
          children: getHelpController.issueList.value.map<Widget>((issue) {
            return IssuesTile(
              title: issue.name ?? '',
              onPressed: () {
                bookAppointmentController.query = issue.name;
                AutoRouter.of(context).push(ConsultantsScreenRouter(
                    slug: issue.slug ?? '', type: 'issue'));
              },
            );
          }).toList(),
        );
      }));
}
