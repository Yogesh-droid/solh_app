import 'package:flutter/material.dart';
import 'package:solh/model/search/global_search_model.dart';
import 'package:solh/ui/screens/get-help/consultant_tile.dart';
import 'package:solh/ui/screens/get-help/view-all/allied_consultants.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../model/journals/journals_response_model.dart';
import '../../../routes/routes.dart';
import '../../../widgets_constants/group_card.dart';
import '../../../widgets_constants/search/people_tile.dart';
import '../../../widgets_constants/search/post_tile.dart';
import '../comment/comment-screen.dart';

class ViewAllSearchResults extends StatefulWidget {
  ViewAllSearchResults(
      {required String title,
      List<PostCount>? postCount,
      List<GroupCount>? groupCount,
      List<Connection>? connection,
      List<Providers>? providers,
      List<Providers>? alliedProviders,
      Key? key})
      : _title = title,
        _connection = connection,
        _groupCount = groupCount,
        _postCount = postCount,
        _providers = providers,
        _alliedProviders = alliedProviders,
        super(key: key);
  final String _title;
  final List<PostCount>? _postCount;
  final List<GroupCount>? _groupCount;
  final List<Connection>? _connection;
  final List<Providers>? _providers;
  final List<Providers>? _alliedProviders;

  @override
  State<ViewAllSearchResults> createState() => _ViewAllSearchResultsState();
}

class _ViewAllSearchResultsState extends State<ViewAllSearchResults> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: widget._postCount != null
          ? getPostView(widget._postCount)
          : widget._groupCount != null
              ? getGroupView(widget._groupCount)
              : widget._connection != null
                  ? getPeopleView(widget._connection)
                  : widget._providers != null
                      ? getConsultantView(widget._providers)
                      : widget._alliedProviders != null
                          ? getAlliedView(widget._alliedProviders)
                          : Container(),
    );
  }

  SolhAppBar getAppBar() {
    return SolhAppBar(
      isLandingScreen: false,
      title: Text(
        widget._title,
        style: SolhTextStyles.AppBarText,
      ),
    );
  }

  Widget getGroupView(List<GroupCount>? groupCount) {
    return ListView.builder(
        itemCount: groupCount!.length,
        itemBuilder: (context, index) => GroupCard(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.groupDetails,
                    arguments: {
                      "groupId": groupCount[index].sId,
                      // "group": GroupList(
                      //   sId: groupCount[index].sId,
                      //   groupName: groupCount[index].groupName,
                      //   groupMediaUrl: groupCount[index].groupMediaUrl,
                      // )
                    });
                /*  Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GroupDetailsPage(
                    ///// this case is for group journal
                    group: GroupList(
                      sId: groupCount[index].sId,
                      groupName: groupCount[index].groupName,
                      groupMediaUrl: groupCount[index].groupMediaUrl,
                    ),
                  );
                })); */
              },
              groupMediaUrl: groupCount[index].groupMediaUrl,
              groupName: groupCount[index].groupName,
              id: groupCount[index].sId,
              journalCount: groupCount[index].journalCount,
              membersCount: groupCount[index].groupMembers!.length,
            ));
  }

  Widget getConsultantView(List<Providers>? providers) {
    return ListView.builder(
        itemCount: providers!.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(18.0),
              child: ConsultantsTile(
                currency: providers[index].feeCurrency ?? '',
                feeAmount: providers[index].feeAmount ?? 0,
                id: providers[index].sId ?? '',
                name: providers[index].name ?? '',
                onTap: () {},
                prefix: providers[index].prefix ?? '',
                profilePic: providers[index].profilePicture ?? '',
                specialization: '',
                bio: providers[index].bio ?? '',
                fee: providers[index].fee ?? '',
              ),
              // child: PeopleTile(
              //   connection: providers[index],
              //   onTapped: () {
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //         builder: (context) => ConnectProfileScreen(
              //     //             uid: connection[index].uid ?? '',
              //     //             sId: connection[index].sId ?? '')));
              //     Navigator.pushNamed(context, AppRoutes.connectScreen,
              //         arguments: {
              //           "sId": connection[index].sId!,
              //           "uid": connection[index].uid!
              //         });
              //   },
              // )
            ));
  }

  Widget getAlliedView(List<Providers>? allied) {
    return ListView.builder(
        itemCount: allied!.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(18.0),
              child: AlliedConsultantTile(
                profilePic: allied[index].profilePicture ?? '',
                prefix: allied[index].prefix ?? '',
                name: allied[index].name ?? '',
                profession: allied[index].profession!.name ?? '',
                experience: allied[index].experience.toString(),
                feeAmount: allied[index].feeAmount ?? 0,
                id: allied[index].sId ?? '',
                preview: allied[index].preview,
              ),
              // child: PeopleTile(
              //   connection: allied[index],
              //   onTapped: () {
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //         builder: (context) => ConnectProfileScreen(
              //     //             uid: connection[index].uid ?? '',
              //     //             sId: connection[index].sId ?? '')));
              //     Navigator.pushNamed(context, AppRoutes.connectScreen,
              //         arguments: {
              //           "sId": connection[index].sId!,
              //           "uid": connection[index].uid!
              //         });
              //   },
              // )
            ));
  }

  Widget getPeopleView(List<Connection>? connection) {
    return ListView.builder(
        itemCount: connection!.length,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(18.0),
            child: PeopleTile(
              connection: connection[index],
              onTapped: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ConnectProfileScreen(
                //             uid: connection[index].uid ?? '',
                //             sId: connection[index].sId ?? '')));
                Navigator.pushNamed(context, AppRoutes.connectScreen,
                    arguments: {
                      "sId": connection[index].sId!,
                      "uid": connection[index].uid!
                    });
              },
            )));
  }

  Widget getPostView(List<PostCount>? postCount) {
    return ListView.builder(
        itemCount: postCount!.length,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(18.0),
            child: PostTile(
              onTapped: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => CommentScreen(
                          journalModel: Journals(
                              postedBy: PostedBy(
                                name: postCount[index].userId!.name ?? '',
                                sId: postCount[index].userId!.sId,
                                uid: postCount[index].userId!.uid,
                                profilePicture:
                                    postCount[index].userId!.profilePicture,
                                isProvider: postCount[index].userId!.isProvider,
                              ),
                              id: postCount[index].sId,
                              mediaUrl: postCount[index].mediaUrl,
                              description: postCount[index].description,
                              comments: postCount[index].comments,
                              group: postCount[index].groupPostedIn != null
                                  ? Group(
                                      sId: postCount[index].groupPostedIn!.sId,
                                      groupImage: postCount[index]
                                          .groupPostedIn!
                                          .groupMediaUrl,
                                      groupName: postCount[index]
                                          .groupPostedIn!
                                          .groupName)
                                  : null,
                              anonymousJournal: false),
                          index: 0)),
                );
              },
              postCount: postCount[index],
            )));
  }
}
