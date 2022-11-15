import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solh/controllers/search/global_search_controller.dart';
import 'package:solh/model/search/global_search_model.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/global-search/view_all_search_results.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/group_card.dart';
import 'package:solh/widgets_constants/search/people_tile.dart';
import 'package:solh/widgets_constants/search/post_tile.dart';
import 'package:solh/widgets_constants/solh_search.dart';
import '../../../model/group/get_group_response_model.dart';
import '../../../model/journals/journals_response_model.dart';
import '../../../routes/routes.dart';
import '../comment/comment-screen.dart';
import '../connect/connect-screen.dart';
import '../groups/group_detail.dart';

class GlobalSearchPage extends StatefulWidget {
  GlobalSearchPage({Key? key}) : super(key: key);

  @override
  State<GlobalSearchPage> createState() => _GlobalSearchPageState();
}

class _GlobalSearchPageState extends State<GlobalSearchPage> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final GlobalSearchController globalSearchController =
      Get.put(GlobalSearchController());

  @override
  void initState() {
    globalSearchController.globalSearchModel.value = GlobalSearchModel();
    focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff6f6f8),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                getSearchField(),
                getSearchResult(context),
              ],
            ),
          ),
        ));
  }

  Widget getSearchField() {
    return SolhSearch(
      textController: searchController,
      focusNode: focusNode,
      onCloseBtnTap: () {
        searchController.clear();
      },
      onSubmitted: (value) {
        globalSearchController.getTexSearch(value);
      },
    );
  }

  Widget getSearchResult(BuildContext context) {
    return Obx(() => globalSearchController.isSearching.value
        ? LinearProgressIndicator()
        : Expanded(
            child: globalSearchController.globalSearchModel.value.connection ==
                        null &&
                    globalSearchController.globalSearchModel.value.groupCount ==
                        null &&
                    globalSearchController.globalSearchModel.value.postCount ==
                        null
                ? Container(
                    child: Center(
                        child: Text(
                      'Search for People, Posts or groups ...',
                      style: TextStyle(color: Colors.grey),
                    )),
                  )
                : globalSearchController
                            .globalSearchModel.value.connection!.isEmpty &&
                        globalSearchController
                            .globalSearchModel.value.groupCount!.isEmpty &&
                        globalSearchController
                            .globalSearchModel.value.postCount!.isEmpty
                    ? Container(
                        child: Center(child: Text('No Result Found')),
                      )
                    : ListView(shrinkWrap: false, children: [
                        globalSearchController
                                    .globalSearchModel.value.connection !=
                                null
                            ? getPeopleView(
                                context,
                                globalSearchController
                                    .globalSearchModel.value.connection)
                            : Container(),
                        globalSearchController
                                    .globalSearchModel.value.groupCount !=
                                null
                            ? getGroupView(
                                context,
                                globalSearchController
                                    .globalSearchModel.value.groupCount)
                            : Container(),
                        globalSearchController
                                    .globalSearchModel.value.postCount !=
                                null
                            ? getPostView(
                                context,
                                globalSearchController
                                    .globalSearchModel.value.postCount)
                            : Container()
                      ]),
          ));
  }

  Widget getSearchShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[300]!,
      child: ListView(
        shrinkWrap: true,
        children: List.generate(
            20,
            (index) => Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 10,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 10,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 10,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 10,
                      color: Colors.grey,
                    ),
                  ],
                )),
      ),
    );
  }

  Widget getPeopleView(BuildContext context, List<Connection>? connection) {
    return connection!.isNotEmpty
        ? Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: SolhColors.white),
                child: Column(children: [
                  GetHelpCategory(
                    title: 'Peoples',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAllSearchResults(
                                    title: 'Peoples',
                                    connection: connection,
                                  )));
                    },
                  ),
                  Column(
                    children: List.generate(
                        globalSearchController.globalSearchModel.value
                                    .connection!.length >=
                                2
                            ? 2
                            : globalSearchController
                                .globalSearchModel.value.connection!.length,
                        (index) => getPeopleTile(
                            context,
                            globalSearchController
                                .globalSearchModel.value.connection![index])),
                  )
                ]),
              ),
            ],
          )
        : Container();
  }

  Widget getGroupView(BuildContext context, List<GroupCount>? groupCount) {
    return groupCount!.isNotEmpty
        ? Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: SolhColors.white),
                child: Column(children: [
                  GetHelpCategory(
                    title: 'Groups',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAllSearchResults(
                                    title: 'Groups',
                                    groupCount: groupCount,
                                  )));
                    },
                  ),
                  Column(
                      children: List.generate(
                          groupCount.length >= 2 ? 2 : groupCount.length,
                          (index) => GroupCard(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return GroupDetailsPage(
                                      ///// this case is for group journal
                                      group: GroupList(
                                        sId: groupCount[index].sId,
                                        groupName: groupCount[index].groupName,
                                        groupMediaUrl:
                                            groupCount[index].groupMediaUrl,
                                      ),
                                    );
                                  }));
                                },
                                groupMediaUrl: groupCount[index].groupMediaUrl,
                                groupName: groupCount[index].groupName,
                                id: groupCount[index].sId,
                                journalCount: groupCount[index].journalCount,
                                membersCount:
                                    groupCount[index].groupMembers!.length,
                              )))
                ]),
              ),
            ],
          )
        : Container();
  }

  Widget getPostView(BuildContext context, List<PostCount>? postCount) {
    return postCount!.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: SolhColors.white),
                child: Column(children: [
                  GetHelpCategory(
                    title: 'Posts',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAllSearchResults(
                                    title: 'Posts',
                                    postCount: postCount,
                                  )));
                    },
                  ),
                  Divider(
                    color: SolhColors.grey,
                  ),
                  Column(
                      children: List.generate(
                          postCount.length >= 2 ? 2 : postCount.length,
                          (index) => getPostTile(context, postCount[index])))
                ]),
              ),
            ],
          )
        : Container();
  }

  ///////////////////////////////////////////////////////////////
  ///

  Widget getPeopleTile(BuildContext context, Connection e) {
    return Padding(
        padding: const EdgeInsets.all(18.0),
        child: PeopleTile(
          connection: e,
          onTapped: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ConnectProfileScreen(
            //             uid: e.uid ?? '', sId: e.sId ?? '')));
            Navigator.pushNamed(context, AppRoutes.connectScreen,
                arguments: {"uid": e.uid!, "sId": e.sId!});
          },
        ));
  }

  Widget getPostTile(BuildContext context, PostCount postCount) {
    return PostTile(
      onTapped: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => CommentScreen(
                  journalModel: Journals(
                      postedBy: PostedBy(
                        name: postCount.userId!.name ?? '',
                        sId: postCount.userId!.sId,
                        uid: postCount.userId!.uid,
                        profilePicture: postCount.userId!.profilePicture,
                        isProvider: postCount.userId!.isProvider,
                      ),
                      id: postCount.sId,
                      mediaUrl: postCount.mediaUrl,
                      description: postCount.description,
                      comments: postCount.comments,
                      group: postCount.groupPostedIn != null
                          ? Group(
                              sId: postCount.groupPostedIn!.sId,
                              groupImage:
                                  postCount.groupPostedIn!.groupMediaUrl,
                              groupName: postCount.groupPostedIn!.groupName)
                          : null,
                      anonymousJournal: false),
                  index: 0)),
        );
      },
      postCount: postCount,
    );
  }
}
