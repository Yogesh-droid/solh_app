import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/journals/my-journal-bloc.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/services/journal/delete-journal.dart';
import 'package:solh/ui/screens/comment/comment-screen.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/journaling/widgets/journal_tile.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../../../controllers/journals/journal_page_controller.dart';
import '../../../../model/journals/journals_response_model.dart';
import '../../../../widgets_constants/constants/colors.dart';

class PostScreen extends StatefulWidget {
  PostScreen({Key? key, Map<dynamic, dynamic>? args})
      : sId = args!['sId'],
        super(key: key);
  final String? sId;
// FirebaseAuth.instance.currentUser!.uid
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  JournalPageController _journalPageController = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getMyJournals(widget.sId);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getNextPageJournals(widget.sId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('posts ran');
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Posts".tr,
              style: SolhTextStyles.AppBarText.copyWith(
                  color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
      body: StreamBuilder<List<Journals?>>(
          stream: myJournalsBloc.journalsStateStream,
          builder: (_, journalsSnapshot) {
            if (journalsSnapshot.hasData &&
                myJournalsBloc.isFetchingPost == false) {
              if (journalsSnapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                  "Well, there's nothing here! Why don't you begin today?".tr,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ));
              }
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: journalsSnapshot.requireData.length,
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CommentScreen(
                                        journalModel:
                                            journalsSnapshot.data![index],
                                        index: index)));
                              },
                              child: Column(
                                children: [
                                  JournalTile(
                                    journalModel: journalsSnapshot.data![index],
                                    index: index,
                                    deletePost: () async {
                                      await deletePost(
                                          index,
                                          _journalPageController,
                                          myJournalsBloc);
                                    },
                                    isMyJournal: true,
                                  ),
                                  Container(
                                    height: 24,
                                    color: Colors.white,
                                    width: 100.w,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: SolhColors.primary_green,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              journalsSnapshot
                                                  .data![index]!.likes
                                                  .toString(),
                                              style: SolhTextStyles
                                                  .GreenBorderButtonText,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/journaling/post-comment.svg",
                                              width: 17,
                                              height: 17,
                                              color: SolhColors.primary_green,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              journalsSnapshot
                                                  .data![index]!.comments
                                                  .toString(),
                                              style: SolhTextStyles
                                                  .GreenBorderButtonText,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  GetHelpDivider()
                                ],
                              ),
                            );
                          }),
                    ),
                    StreamBuilder<bool>(
                        stream: myJournalsBloc.moreLoaderStream,
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? snapshot.requireData
                                  ? Container(
                                      height: 50,
                                      child: MyLoader(),
                                    )
                                  : Container()
                              : Container();
                        })
                  ],
                ),
              );
            } else {
              return Center(child: MyLoader());
            }
          }),
    );
  }

  Future<void> getMyJournals(String? sId) async {
    print('fetching my posts');
    await myJournalsBloc.getJournalsSnapshot(sId);
  }

  void getNextPageJournals(String? sId) async {
    await myJournalsBloc.getNextPageJournalsSnapshot(sId);
  }
}

Future<void> deletePost(
  int index,
  _journalPageController,
  MyJournalsBloc myJournalsBloc,
) async {
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
  myJournalsBloc.fetchDetailsFirstTime(userBlocNetwork.id);
  _journalPageController.journalsList.clear();
  _journalPageController.pageNo = 1;
  _journalPageController.endPageLimit = 1;
  await _journalPageController.getAllJournals(1,
      groupId: _journalPageController.selectedGroupId.value.length > 0
          ? _journalPageController.selectedGroupId.value
          : null);
}
