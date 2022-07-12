import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/controllers/goal-setting/goal_setting_controller.dart';
import 'package:solh/ui/screens/groups/group_detail.dart';
import 'package:solh/ui/screens/groups/manage_groups.dart';
import 'package:solh/ui/screens/my-goals/add_select_goal.dart';
import 'package:solh/ui/screens/my-goals/my-goals-controller/my_goal_controller.dart';
import 'package:solh/ui/screens/my-goals/my-goals-screen.dart';
import 'package:solh/ui/screens/my-goals/select_goal.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
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
import '../../../model/journals/journals_response_model.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../get-help/get-help.dart';
import '../get-help/view-all/consultants.dart';
import '../journaling/side_drawer.dart';
import '../journaling/whats_in_your_mind_section.dart';
import '../mood-meter/mood_meter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CreateGroupController _controller = Get.put(CreateGroupController());
  JournalPageController _journalPageController =
      Get.put(JournalPageController());
  MyDiaryController myDiaryController = Get.put(MyDiaryController());
  GetHelpController getHelpController = Get.put(GetHelpController());
  final DiscoverGroupController discoverGroupController =
      Get.put(DiscoverGroupController());
  ConnectionController connectionController = Get.put(ConnectionController());
  FeelingsController feelingsController = Get.put(FeelingsController());

  JournalCommentController journalCommentController =
      Get.put(JournalCommentController());
  MoodMeterController moodMeterController = Get.find();
  late DateTime _lastDateMoodMeterShown;
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
        await moodMeterController.getMoodList();
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
      await moodMeterController.getMoodList();
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
  bool _isDrawerOpen = false;
  List<String> feelingList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      left: _isDrawerOpen ? 78.w : 0,
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
              body: SingleChildScrollView(
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
                  GetHelpCategory(
                    title: 'Solh Buddies',
                  ),
                  getSolhBuddiesUI(),
                  GetHelpDivider(),
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
                  getGoalSettingUI(),
                  SizedBox(
                    height: 10,
                  ),
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
                          title: 'Recommended groups',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ManageGroupPage()));
                          })
                      : Container()),
                  Obx(() {
                    return discoverGroupController
                                    .discoveredGroupModel.value.groupList !=
                                null &&
                            discoverGroupController.discoveredGroupModel.value
                                    .groupList!.length >
                                0
                        ? getRecommendedGroupsUI()
                        : Container();
                  }),
                  GetHelpDivider(),
                  // GetHelpCategory(
                  //     title: 'People You May Know', onPressed: () {}),
                  // getPeopleYouMayKnowUI(),
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
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 6,
                                  itemBuilder: (_, index) {
                                    print(getHelpController.topConsultantList
                                        .value.doctors![index].profilePicture);
                                    return TopConsultantsTile(
                                      bio: getHelpController.topConsultantList
                                              .value.doctors![index].bio ??
                                          '',
                                      name: getHelpController.topConsultantList
                                              .value.doctors![index].name ??
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
                                      sId: getHelpController.topConsultantList
                                          .value.doctors![index].sId,
                                    );
                                  })
                              : Container(
                                  child: Center(
                                  child: Text('No Doctors Found'),
                                )),
                        )),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ]),
              ),
            ),
            if (_isDrawerOpen)
              GestureDetector(
                onTap: () => setState(() => _isDrawerOpen = false),
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
                setState(() {
                  _isDrawerOpen = !_isDrawerOpen;
                });
                print("opened");
              },
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                height: 40,
                width: 40,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: SvgPicture.asset(
                  "assets/icons/app-bar/app-bar-menu.svg",
                  width: 26,
                  height: 24,
                  color: SolhColors.green,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.h,
          ),
          Text(
            "Home",
            style: SolhTextStyles.AppBarText,
          ),
        ],
      ),
      isLandingScreen: true,
    );
  }

  Widget getTrendingPostUI() {
    BottomNavigatorController _controller = Get.find();
    return Container(
        height: MediaQuery.of(context).size.height * 0.55,
        child: Obx(() {
          return Stack(
            children: [
              // getDragTarget(),
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
                  left: 20,
                  top: 10,
                  child: getDraggable(
                      _journalPageController.trendingJournalsList[0]))
            ],
          );
        }));
  }

  // Widget getDragTarget() {
  //   return Positioned(
  //     left: 0,
  //     child: DragTarget(
  //       onWillAccept: (data) {
  //         return true;
  //       },
  //       onAccept: (data) {
  //         print("accepted");
  //         // _journalPageController.trendingJournalsList
  //         //     .insert(10, _journalPageController.trendingJournalsList[0]);
  //         // _journalPageController.trendingJournalsList.removeAt(0);

  //         // _journalPageController.trendingJournalsList.refresh();
  //       },
  //       onLeave: (data) {
  //         print("left");
  //       },
  //       builder: (context, candidateData, rejectedData) {
  //         return Container(
  //           height: MediaQuery.of(context).size.height,
  //           width: MediaQuery.of(context).size.width * 0.7,
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget getDraggable(Journals journal) {
    return Draggable(
      affinity: Axis.horizontal,
      data: "data",
      child: InkWell(
        onTap: () {
          _bottomNavigatorController.tabrouter!.setActiveIndex(1);
        },
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
          child: getPostContent(journal),
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
          child: getPostContent(journal),
        ),
      ),
      childWhenDragging: Container(),
      onDragEnd: (data) {
        _journalPageController.trendingJournalsList
            .insert(10, _journalPageController.trendingJournalsList[0]);
        _journalPageController.trendingJournalsList.removeAt(0);

        _journalPageController.trendingJournalsList.refresh();
        print("dragged");
      },
    );
  }

  getPostCard(Journals journal) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!), color: Colors.white),
      child: getPostContent(journal),
    );
  }

  getPostCard2(Journals journal) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!), color: Colors.white),
      child: getPostContent(journal),
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

  Widget getPostContent(Journals journal) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        journal.feelings!.length > 0
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: journal.feelings!
                      .map((e) => Text(
                            '# ${e.feelingName}',
                            style: SolhTextStyles.JournalingHashtagText,
                          ))
                      .toList(),
                ),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            journal.description ?? '',
            style: SolhTextStyles.LandingParaText,
            maxLines: 3,
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: journal.mediaUrl ?? '',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/no-image-available_err.png',
                  fit: BoxFit.cover,
                ),
                placeholder: (context, url) => getImgShimmer(),
              ),
            ),
          ),
        )
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
      height: 35.h,
      margin: EdgeInsets.only(bottom: 2.h),
      child: Container(child: Obx(() {
        return getHelpController.solhVolunteerList.value.provider != null &&
                getHelpController.solhVolunteerList.value.provider!.length > 0
            ? ListView.separated(
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
                  imgUrl: getHelpController
                      .solhVolunteerList.value.provider![index].profilePicture,
                  sId: getHelpController
                      .solhVolunteerList.value.provider![index].sId,
                  uid: getHelpController
                      .solhVolunteerList.value.provider![index].uid,
                  comments: getHelpController
                      .solhVolunteerList.value.provider![index].commentCount
                      .toString(),
                  connections: getHelpController
                      .solhVolunteerList.value.provider![index].connectionsCount
                      .toString(),
                  likes: getHelpController
                      .solhVolunteerList.value.provider![index].likesCount
                      .toString(),
                ),
              )
            : Container(
                child: Center(
                  child: Text('No Volunteers Found'),
                ),
              );
      })),
    );
  }

  Widget getGoalSettingUI() {
    return Container(
      child: GoalName(),
    );
  }

  Widget getRecommendedGroupsUI() {
    return Container(
        padding: EdgeInsets.only(left: 2.h, bottom: 2.h),
        height: MediaQuery.of(context).size.height * 0.4,
        child: ListView.separated(
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
                          style: SolhTextStyles.AppBarText,
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
                            Image.asset(
                              'assets/icons/group/edit.png',
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
                .discoveredGroupModel.value.groupList!.length));
  }

  Widget getPeopleYouMayKnowUI() {
    return Container();
  }
}
