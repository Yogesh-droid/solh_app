import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/controllers/journals/feelings_controller.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/services/journal/delete-journal.dart';
import 'package:solh/ui/screens/groups/manage_groups.dart';
import 'package:solh/ui/screens/journaling/side_drawer.dart';
import 'package:solh/ui/screens/journaling/whats_in_your_mind_section.dart';
import 'package:solh/ui/screens/journaling/widgets/journal_tile.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../controllers/journals/journal_comment_controller.dart';
import '../../../controllers/journals/journal_page_controller.dart';
import '../../../controllers/mood-meter/mood_meter_controller.dart';

class JournalingScreen extends StatefulWidget {
  const JournalingScreen({Key? key}) : super(key: key);

  @override
  _JournalingScreenState createState() => _JournalingScreenState();
}

class _JournalingScreenState extends State<JournalingScreen> {
  FeelingsController feelingsController = Get.find();
  JournalCommentController journalCommentController = Get.find();
  MoodMeterController moodMeterController = Get.find();
  late bool isMoodMeterShown;

  final DiscoverGroupController discoverGroupController = Get.find();

  ConnectionController connectionController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SideDrawer(),
            Journaling(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    moodMeterController.getMoodAnalytics(7);
    super.initState();
  }
}

class Journaling extends StatefulWidget {
  const Journaling({Key? key}) : super(key: key);

  @override
  _JournalingState createState() => _JournalingState();
}

class _JournalingState extends State<Journaling> {
  JournalPageController _journalPageController = Get.find();
  DiscoverGroupController discoverGroupController = Get.find();
  MoodMeterController moodMeterController = Get.find();
  BottomNavigatorController bottomNavigatorController = Get.find();
  late ScrollController _journalsScrollController;
  late RefreshController _refreshController;
  bool _fetchingMore = false;

  void initState() {
    super.initState();
    _journalsScrollController = ScrollController();
    _refreshController = RefreshController();

    /////   Loop for fetching groups shown on home screen discover + joined groups ////

    // journalsBloc.getJournalsSnapshot();
    //openMoodMeter();
    _journalsScrollController.addListener(() async {
      if (_journalsScrollController.position.pixels ==
          _journalsScrollController.position.minScrollExtent) {
        print("refreshing");
        _journalPageController.isScrollingStarted.value = false;
      }
      if (_journalsScrollController.position.pixels > 0) {
        _journalPageController.isScrollingStarted.value = true;
      }
      if (_journalsScrollController.position.pixels ==
              _journalsScrollController.position.maxScrollExtent &&
          !_fetchingMore) {
        print("fetching more");
        setState(() {
          _fetchingMore = true;
        });
        //await journalsBloc.getNextPageJournalsSnapshot();
        await _journalPageController.getAllJournals(
            ++_journalPageController.pageNo,
            groupId: _journalPageController.selectedGroupId.value != ''
                ? _journalPageController.selectedGroupId.value
                : null);
        _journalPageController.journalsList.refresh();
        print("Reached at end");
        setState(() {
          _fetchingMore = false;
        });
      }

      if (_journalsScrollController.position.pixels ==
          _journalsScrollController.position.maxScrollExtent) {
        print("refreshing");
        _journalPageController.isScrollingStarted.value = false;
      }
    });

    // if (_journalPageController.selectedGroupId.value != '') {
    //   _customScrollController.jumpTo(80 *
    //       _groupsShownOnHome
    //           .indexOf(_journalPageController.selectedGroupId.value)
    //           .toDouble());
    // }

    userBlocNetwork.getMyProfileSnapshot();
  }

  void _onRefresh() async {
    // monitor network fetch
    //await journalsBloc.getJournalsSnapshot();
    _journalPageController.journalsList.clear();
    _journalPageController.pageNo = 1;
    _journalPageController.endPageLimit = 1;
    _journalPageController.selectedGroupId.value.length > 0
        ? await _journalPageController.getAllJournals(1,
            groupId: _journalPageController.selectedGroupId.value)
        : await _journalPageController.getAllJournals(
            1,
          );
    _journalPageController.journalsList.refresh();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          left: bottomNavigatorController.isDrawerOpen.value ? 78.w : 0,
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
                  body: SmartRefresher(
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    child: ListView(
                      controller: _journalsScrollController,
                      children: [
                        Column(
                          children: [
                            groupRow(),
                            Obx(() {
                              return !_journalPageController.isLoading.value
                                  ? Obx(() {
                                      return _journalPageController
                                              .journalsList.value.isNotEmpty
                                          ? ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: _journalPageController
                                                  .journalsList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return _journalPageController
                                                                .journalsList
                                                                .value[index]
                                                                .id !=
                                                            null &&
                                                        !userBlocNetwork
                                                            .hiddenPosts
                                                            .contains(
                                                                _journalPageController
                                                                    .journalsList
                                                                    .value[
                                                                        index]
                                                                    .id)
                                                    ? getJournalTile(index)
                                                    : Container();
                                              })
                                          : Center(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 25.h,
                                                  ),
                                                  Obx(() {
                                                    return Text(
                                                      _journalPageController
                                                                  .selectedGroupId
                                                                  .value ==
                                                              ''
                                                          ? "No Journals"
                                                          : 'No Post',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xFFD9D9D9)),
                                                    );
                                                  })
                                                ],
                                              ),
                                            );
                                    })
                                  : getShimmer(context);
                            }),
                          ],
                        ),
                        if (_fetchingMore) Center(child: MyLoader()),
                        SizedBox(height: Platform.isIOS ? 80 : 50),
                      ],
                    ),
                  ),
                ),
                if (bottomNavigatorController.isDrawerOpen.value)
                  GestureDetector(
                    // onTap: () => setState(() => _isDrawerOpen = false),
                    onTap: () {
                      bottomNavigatorController.isDrawerOpen.value = false;
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
        ));
  }

  SolhAppBar getAppBar() {
    return SolhAppBar(
      height: MediaQuery.of(context).size.height / 6.5,
      title: Row(
        children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: InkWell(
              onTap: () {
                print("side bar tapped");
                bottomNavigatorController.isDrawerOpen.value = true;
                // setState(() {
                //   _isDrawerOpen = !_isDrawerOpen;
                // });
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
          // SizedBox(
          //   width: 2,
          // ),
          // Text(
          //   "Journaling",
          //   style: SolhTextStyles.AppBarText,
          // ),
        ],
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(0), child: WhatsOnYourMindSection()),
      isLandingScreen: true,
    );
  }

  Widget groupRow() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      child: Obx(() {
        return CustomScrollView(
          controller: _journalPageController.customeScrollController,
          scrollDirection: Axis.horizontal,
          slivers: [
            SliverToBoxAdapter(
              child: Divider(),
            ),
            SliverToBoxAdapter(
              child: getSolhGrouContainer(),
            ),
            SliverToBoxAdapter(
              child: getGroupAddButton(),
            ),
            discoverGroupController.joinedGroupModel.value.groupList != null
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                    return getGroupContainer(discoverGroupController
                        .joinedGroupModel.value.groupList![index]);
                  },
                        childCount: discoverGroupController
                            .joinedGroupModel.value.groupList!.length))
                : getGroupShimmer(context),
            discoverGroupController.createdGroupModel.value.groupList != null
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                    return getGroupContainer(discoverGroupController
                        .createdGroupModel.value.groupList![index]);
                  },
                        childCount: discoverGroupController
                            .createdGroupModel.value.groupList!.length))
                : getGroupShimmer(context),
          ],
        );
      }),
    );
  }

  Widget getGroupContainer(GroupList group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return Container(
            width: 76,
            height: 64,
            decoration:
                _journalPageController.selectedGroupId.value == group.sId
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            SolhColors.green,
                            Colors.red.withOpacity(0.3),
                            Colors.red.withOpacity(0.8),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ))
                    : BoxDecoration(),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: !_journalPageController.isLoading.value
                  ? () async {
                      // _customScrollViewPosition =
                      //     _customScrollController.position.pixels;
                      // print(_customScrollViewPosition);
                      _journalPageController.selectedGroupId.value =
                          group.sId ?? '';
                      _journalPageController.journalsList.clear();
                      _journalPageController.pageNo = 1;
                      _journalPageController.endPageLimit = 1;
                      await _journalPageController.getAllJournals(1,
                          groupId: group.sId);
                      _journalPageController.journalsList.refresh();
                      //_customScrollController.jumpTo(_customScrollViewPosition);
                      // _customScrollController.animateTo(200,
                      //     duration: Duration(milliseconds: 500),
                      //     curve: Curves.easeInOut);
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: _journalPageController.selectedGroupId.value ==
                            group.sId
                        ? Border()
                        : Border.all(
                            color: SolhColors.green,
                            width: 2,
                          ),
                    image: DecorationImage(
                      image: group.groupMediaUrl != null
                          ? CachedNetworkImageProvider(group.groupMediaUrl ??
                              "https://picsum.photos/200/200")
                          : AssetImage("assets/images/group_placeholder.png")
                              as ImageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
        SizedBox(
          height: 5,
        ),
        Container(
            width: 70,
            child: Obx(() {
              return Text(
                "${group.groupName}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color:
                      _journalPageController.selectedGroupId.value == group.sId
                          ? Color(0xFF222222)
                          : Color(0xFF666666),
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              );
            })),
      ],
    );
  }

  Widget getSolhGrouContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return Container(
            width: 76,
            height: 64,
            decoration: _journalPageController.selectedGroupId.value == ''
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        SolhColors.green,
                        Colors.red.withOpacity(0.3),
                        Colors.red.withOpacity(0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ))
                : BoxDecoration(),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () async {
                _journalPageController.selectedGroupId.value = '';
                _journalPageController.journalsList.clear();
                _journalPageController.pageNo = 1;
                _journalPageController.endPageLimit = 1;
                await _journalPageController.getAllJournals(1);
                _journalPageController.journalsList.refresh();
              },
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: _journalPageController.selectedGroupId == ''
                        ? Border()
                        : Border.all(
                            color: SolhColors.green,
                            width: 2,
                          ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Image.asset(
                      'assets/images/logo/solh-logo.png',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
        SizedBox(
          height: 5,
        ),
        Container(
          width: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return Text(
                  "Solh",
                  style: TextStyle(
                    fontSize: 14,
                    color: _journalPageController.selectedGroupId == ''
                        ? Color(0xFF222222)
                        : Color(0xFF666666),
                    fontWeight: FontWeight.w400,
                    height: 1.23, //Figma Line Height 17.25
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                );
              }),
              SizedBox(
                width: 5,
              ),
              Image.asset(
                'assets/icons/profile/verified.png',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> deletePost(int index) async {
    print("deleting post");
    DeleteJournal _deleteJournal = DeleteJournal(
        journalId: _journalPageController.journalsList.value[index].id!);
    await _deleteJournal.deletePost();
    // _journalPageController
    //     .videoPlayerController
    //     .value
    //     .removeAt(index - 1);
    // _journalPageController
    //     .journalsList.value
    //     .removeAt(index - 1);
    // _journalPageController
    //     .videoPlayerController
    //     .refresh();
    // _journalPageController
    //     .journalsList
    //     .refresh();
    _journalPageController.journalsList.clear();
    _journalPageController.pageNo = 1;
    _journalPageController.endPageLimit = 1;
    await _journalPageController.getAllJournals(1,
        groupId: _journalPageController.selectedGroupId.value.length > 0
            ? _journalPageController.selectedGroupId.value
            : null);
  }

  Widget getJournalTile(int index) {
    return JournalTile(
      journalModel: _journalPageController.journalsList.value[index],
      index: index,
      deletePost: () async {
        deletePost(index);
      },
      isMyJournal: false,
    );
  }

  getShimmer(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ])),
          );
        });
  }

  getGroupShimmer(BuildContext context) {
    return SliverToBoxAdapter(
        child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
    ));
  }

  Widget getGroupAddButton() {
    return Column(
      children: [
        Container(
          width: 76,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: SolhColors.white,
              width: 2,
            ),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageGroupPage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: SolhColors.green,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: SolhColors.green,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Discover",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
            fontWeight: FontWeight.w400,
            height: 1.23, //Figma Line Height 17.25
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Future<void> openMoodMeter() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getInt('lastDateShown') != null) {
  //     if (DateTime.fromMillisecondsSinceEpoch(prefs.getInt('lastDateShown')!)
  //             .day ==
  //         DateTime.now().day) {
  //       return;
  //     } else {
  //       await moodMeterController.getMoodList();
  //       if (moodMeterController.moodList.length > 0) {
  //         /* showModalBottomSheet(
  //             isScrollControlled: true,
  //             context: context,
  //             builder: (context) {
  //               return Container(
  //                 height: MediaQuery.of(context).size.height * 0.8,
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(20),
  //                     topRight: Radius.circular(20),
  //                   ),
  //                   image: DecorationImage(
  //                     image: AssetImage('assets/intro/png/mood_meter_bg.png'),
  //                     fit: BoxFit.fill,
  //                   ),
  //                 ),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Expanded(child: Container()),
  //                         InkWell(
  //                           onTap: () {
  //                             Navigator.pop(context);
  //                           },
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                 color: Colors.grey[200],
  //                                 shape: BoxShape.circle,
  //                               ),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.all(3.0),
  //                                 child: Icon(
  //                                   Icons.close,
  //                                   color: Colors.grey,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Container(
  //                       height: MediaQuery.of(context).size.height * 0.8,
  //                       child: MoodMeter(),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             }); */

  //         showGeneralDialog(
  //             context: context,
  //             pageBuilder: (context, animation, secondaryAnimation) {
  //               return Scaffold(body: MoodMeter());
  //             });
  //       }

  //       prefs.setBool('moodMeterShown', true);
  //       prefs.setInt('lastDateShown', DateTime.now().millisecondsSinceEpoch);
  //     }
  //   } else {
  //     await moodMeterController.getMoodList();
  //     showGeneralDialog(
  //         context: context,
  //         pageBuilder: (context, animation, secondaryAnimation) {
  //           return Scaffold(body: MoodMeter());
  //         });

  //     prefs.setBool('moodMeterShown', true);
  //     prefs.setInt('lastDateShown', DateTime.now().millisecondsSinceEpoch);
  //   }
  // }
}
