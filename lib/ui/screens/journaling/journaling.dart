import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/journals/journal-bloc.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/getHelp/get_help_controller.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/controllers/journals/feelings_controller.dart';
import 'package:solh/controllers/journals/journal_comment_controller.dart';
import 'package:solh/controllers/my_diary/my_diary_controller.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/services/journal/delete-journal.dart';
import 'package:solh/ui/screens/journaling/side_drawer.dart';
import 'package:solh/ui/screens/journaling/whats_in_your_mind_section.dart';
import 'package:solh/ui/screens/journaling/widgets/journal_tile.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../controllers/group/create_group_controller.dart';
import '../../../controllers/journals/journal_page_controller.dart';

class JournalingScreen extends StatefulWidget {
  const JournalingScreen({Key? key}) : super(key: key);

  @override
  _JournalingScreenState createState() => _JournalingScreenState();
}

class _JournalingScreenState extends State<JournalingScreen> {
  FeelingsController feelingsController = Get.put(FeelingsController());
  final CreateGroupController _controller = Get.put(CreateGroupController());
  final DiscoverGroupController discoverGroupController =
      Get.put(DiscoverGroupController());
  JournalPageController _journalPageController =
      Get.put(JournalPageController());
  MyDiaryController myDiaryController = Get.put(MyDiaryController());
  JournalCommentController journalCommentController =
      Get.put(JournalCommentController());
  ConnectionController connectionController = Get.put(ConnectionController());
  GetHelpController getHelpController = Get.put(GetHelpController());
  // final _newPostKey = GlobalKey<FormState>();

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
}

class Journaling extends StatefulWidget {
  const Journaling({Key? key}) : super(key: key);

  @override
  _JournalingState createState() => _JournalingState();
}

class _JournalingState extends State<Journaling> {
  JournalPageController _journalPageController = Get.find();
  DiscoverGroupController discoverGroupController = Get.find();
  List<String> groups = [
    'Solh',
    'Stress Buster',
    'Anxiety',
    'Depression',
    'Anger',
    'Happiness'
  ];

  bool _isDrawerOpen = false;
  bool _fetchingMore = false;

  void initState() {
    super.initState();
    _journalsScrollController = ScrollController();
    _refreshController = RefreshController();
    userBlocNetwork.getMyProfileSnapshot();
    journalsBloc.getJournalsSnapshot();

    _journalsScrollController.addListener(() async {
      // if (_journalsScrollController.position.pixels ==
      //         _journalsScrollController.position.minScrollExtent &&
      //     _refreshController.isRefresh) {
      //   print("refreshing");
      // }
      if (_journalsScrollController.position.pixels ==
              _journalsScrollController.position.maxScrollExtent &&
          !_fetchingMore) {
        setState(() {
          _fetchingMore = true;
        });
        await journalsBloc.getNextPageJournalsSnapshot();
        await _journalPageController
            .getAllJournals(++_journalPageController.pageNo);
        _journalPageController.journalsList.refresh();
        print("Reached at end");
        setState(() {
          _fetchingMore = false;
        });
      }
    });
  }

  void _onRefresh() async {
    // monitor network fetch
    //await journalsBloc.getJournalsSnapshot();
    _journalPageController.journalsList.clear();
    _journalPageController.pageNo = 1;
    _journalPageController.endPageLimit = 1;
    await _journalPageController.getAllJournals(1);
    _journalPageController.journalsList.refresh();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  late ScrollController _journalsScrollController;
  late RefreshController _refreshController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
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
                  body: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WhatsOnYourMindSection(),
                      groupRow(),
                      Expanded(
                        child: Obx(
                          () => !_journalPageController.isLoading.value
                              ? Obx(() {
                                  return _journalPageController
                                          .journalsList.isNotEmpty
                                      ? SmartRefresher(
                                          onRefresh: _onRefresh,
                                          controller: _refreshController,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              controller:
                                                  _journalsScrollController,
                                              itemCount: _journalPageController
                                                  .journalsList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return _journalPageController
                                                            .journalsList
                                                            .value[index]
                                                            .id !=
                                                        null
                                                    ? JournalTile(
                                                        journalModel:
                                                            _journalPageController
                                                                .journalsList
                                                                .value[index],
                                                        index: index,
                                                        deletePost: () async {
                                                          print(
                                                              "deleting post");
                                                          DeleteJournal
                                                              _deleteJournal =
                                                              DeleteJournal(
                                                                  journalId: _journalPageController
                                                                      .journalsList
                                                                      .value[
                                                                          index]
                                                                      .id!);
                                                          await _deleteJournal
                                                              .deletePost();
                                                          setState(() {
                                                            _journalPageController
                                                                .journalsList
                                                                .value
                                                                .removeAt(
                                                                    index);
                                                            _journalPageController
                                                                .journalsList
                                                                .refresh();
                                                          });
                                                        },
                                                      )
                                                    : Container();
                                              }),
                                        )
                                      : Container(
                                          child: Center(
                                            child: Text(
                                              "No Journals",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        );
                                })
                              : Center(
                                  child: MyLoader(),
                                ),
                        ),
                      ),
                      if (_fetchingMore) Center(child: MyLoader()),
                      SizedBox(height: Platform.isIOS ? 80 : 50),
                    ],
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
        ),
      ],
    );
  }

  SolhAppBar getAppBar() {
    return SolhAppBar(
      title: Row(
        children: [
          InkWell(
            onTap: () {
              print("side bar tapped");
              setState(() {
                _isDrawerOpen = !_isDrawerOpen;
              });
              print("opened");
            },
            child: SvgPicture.asset(
              "assets/icons/app-bar/app-bar-menu.svg",
              width: 26,
              height: 24,
              color: SolhColors.green,
            ),
          ),
          SizedBox(
            width: 2.h,
          ),
          Text(
            "Journaling",
            style: SolhTextStyles.AppBarText,
          ),
        ],
      ),
      isLandingScreen: true,
    );
  }

  Widget groupRow() {
    return Row(
      children: [
        getSolhGrouContainer(),
        Expanded(
          child: Obx(() {
            return discoverGroupController.joinedGroupModel.value.groupList !=
                    null
                ? discoverGroupController
                        .joinedGroupModel.value.groupList!.isNotEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.13,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: discoverGroupController
                                .joinedGroupModel.value.groupList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return getGroupContainer(discoverGroupController
                                  .joinedGroupModel.value.groupList![index]);
                            }),
                      )
                    : Container()
                : Container();
          }),
        ),
      ],
    );
  }

  Widget getGroupContainer(GroupList group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return Container(
            width: 60,
            height: 60,
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
              onTap: () async {
                _journalPageController.selectedGroupId.value = group.sId ?? '';
                _journalPageController.journalsList.clear();
                _journalPageController.pageNo = 1;
                _journalPageController.endPageLimit = 1;
                await _journalPageController.getAllJournals(1,
                    groupId: group.sId);
                _journalPageController.journalsList.refresh();
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
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
                      image: CachedNetworkImageProvider(group.groupMediaUrl ??
                          "https://picsum.photos/200/200"),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return Container(
            width: 60,
            height: 60,
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
                padding: const EdgeInsets.all(5.0),
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
                    padding: const EdgeInsets.all(4.0),
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
}
