import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/journals/journal-bloc.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/getHelp/get_help_controller.dart';
import 'package:solh/controllers/journals/feelings_controller.dart';
import 'package:solh/controllers/journals/journal_comment_controller.dart';
import 'package:solh/controllers/my_diary/my_diary_controller.dart';
import 'package:solh/services/journal/delete-journal.dart';
import 'package:solh/ui/screens/journaling/side_drawer.dart';
import 'package:solh/ui/screens/journaling/whats_in_your_mind_section.dart';
import 'package:solh/ui/screens/journaling/widgets/journal_tile.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../controllers/journals/journal_page_controller.dart';

class JournalingScreen extends StatefulWidget {
  const JournalingScreen({Key? key}) : super(key: key);

  @override
  _JournalingScreenState createState() => _JournalingScreenState();
}

class _JournalingScreenState extends State<JournalingScreen> {
  FeelingsController feelingsController = Get.put(FeelingsController());
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
              body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expanded(
                  //   child: StreamBuilder<List<JournalModel?>>(
                  //       stream: journalsBloc.journalsStateStream,
                  //       builder: (context, journalSnapshot) {
                  //         if (journalSnapshot.hasData) {
                  //           print(
                  //               "Total Length of the journals: ${journalSnapshot.requireData.length}");
                  //           return SmartRefresher(
                  //             onRefresh: _onRefresh,
                  //             controller: _refreshController,
                  //             child: ListView.builder(
                  //                 controller: _journalsScrollController,
                  //                 itemCount:
                  //                     journalSnapshot.requireData.length + 1,
                  //                 itemBuilder:
                  //                     (BuildContext context, int index) {
                  //                   print("building tile: $index");
                  //                   if (index == 0)
                  //                     return WhatsOnYourMindSection();
                  //                   return JournalTile(
                  //                     journalModel: journalSnapshot
                  //                         .requireData[index - 1],
                  //                     deletePost: () async {
                  //                       print("deleting post");
                  //                       DeleteJournal _deleteJournal =
                  //                           DeleteJournal(
                  //                               journalId: journalSnapshot
                  //                                   .requireData[index - 1]!
                  //                                   .id);
                  //                       await _deleteJournal.deletePost();
                  //                       setState(() {
                  //                         journalSnapshot.requireData
                  //                             .removeAt(index - 1);
                  //                       });
                  //                     },
                  //                   );
                  //                 }),
                  //           );
                  //         }
                  //         if (journalSnapshot.hasError)
                  //           return Container(
                  //             child: Text(journalSnapshot.error.toString()),
                  //           );
                  //         return Container();
                  //       }),
                  // ),
                  WhatsOnYourMindSection(),
                  Expanded(
                    child: Obx(
                      () => !_journalPageController.isLoading.value
                          ? Obx(
                              () => _journalPageController
                                      .journalsList.isNotEmpty
                                  ? SmartRefresher(
                                      onRefresh: _onRefresh,
                                      controller: _refreshController,
                                      child: ListView.builder(
                                          controller: _journalsScrollController,
                                          itemCount: _journalPageController
                                              .journalsList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            print("building tile: ");
                                            // if (index == 0)
                                            //   return WhatsOnYourMindSection();
                                            return JournalTile(
                                              journalModel:
                                                  _journalPageController
                                                      .journalsList
                                                      .value[index],
                                              index: index,
                                              deletePost: () async {
                                                print("deleting post");
                                                DeleteJournal _deleteJournal =
                                                    DeleteJournal(
                                                        journalId:
                                                            _journalPageController
                                                                .journalsList
                                                                .value[index]
                                                                .id!);
                                                await _deleteJournal
                                                    .deletePost();
                                                setState(() {
                                                  _journalPageController
                                                      .journalsList.value
                                                      .removeAt(index);
                                                  _journalPageController
                                                      .journalsList
                                                      .refresh();
                                                });
                                              },
                                            );
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
                                    ),
                            )
                          : Center(
                              child: MyLoader(),
                            ),
                    ),

                    // if (journalSnapshot.hasError)
                    //   return Container(
                    //     child: Text(journalSnapshot.error.toString()),
                    //   );
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
}
