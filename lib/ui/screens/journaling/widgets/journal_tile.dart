import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/journals/journal_comment_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/connect/connect-screen.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:video_player/video_player.dart';
import '../../groups/group_detail.dart';
import 'solh_expert_badge.dart';

class JournalTile extends StatefulWidget {
  JournalTile({
    Key? key,
    required Journals? journalModel,
    required VoidCallback deletePost,
    required this.index,
    required this.isMyJournal,
  })  : _journalModel = journalModel,
        _deletePost = deletePost,
        super(key: key);

  final Journals? _journalModel;
  final VoidCallback _deletePost;
  final int index;
  List<String> feelingList = [];
  final bool isMyJournal;

  @override
  _JournalTileState createState() => _JournalTileState();
}

class _JournalTileState extends State<JournalTile> {
  JournalCommentController journalCommentController = Get.find();
  ConnectionController connectionController = Get.find();
  JournalPageController journalPageController = Get.find();

  @override
  void initState() {
    super.initState();
    getFeelings();
  }

  List getTexts() {
    List textList = widget._journalModel!.description!.split(' ');
    print('textList: $textList');

    return textList;
  }

  bool checkConnectionExist(username) {
    bool connectionExits = true;

    for (var i in connectionController.myConnectionModel.value.myConnections!) {
      print('@' + i.userName.toString() + username.toString());
      if ('@' + i.userName.toString() == username) {
        connectionExits = false;
        break;
      } else {
        connectionExits = true;
      }
    }
    print(connectionExits);
    return connectionExits;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Color(0xFFFFFF),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getUserImageAndName(),
              Divider(),
              getPostDetails(connectionController),
              getPostMedia(),
              widget.isMyJournal ? Container() : getPostActionButton(),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 1.h),
            height: 0.8.h,
            color: Color(0xFFF6F6F8)),
      ],
    );
  }

  void getFeelings() {
    widget._journalModel!.feelings!.forEach((element) {
      widget.feelingList.add(element.feelingName ?? '');
    });
    if (widget.feelingList.length > 4) {
      widget.feelingList.removeRange(4, widget.feelingList.length);
    }
    print(widget.feelingList);
  }

  Future<bool> _likeJournal() async {
    setState(() {});
    var response = await Network.makeHttpPostRequestWithToken(
        url: "${APIConstants.api}/api/like-journal",
        body: {"post": widget._journalModel!.id});
    if (response["status"] == false) setState(() {});
    return (response["status"]);
  }

  Future<bool> _unlikeJournal() async {
    var response = await Network.makeHttpDeleteRequestWithToken(
      body: {"postId": widget._journalModel!.id},
      url: "${APIConstants.api}/api/unlike-journal",
    );
    print(response);
    return true;
  }

  Widget getUserImageAndName() {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 35,
      ),
      child: GestureDetector(
        onTap: () => widget._journalModel!.group != null &&
                journalPageController.selectedGroupId.value.length == 0
            ? {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GroupDetailsPage(
                    ///// this case is for group journal
                    group: GroupList(
                      sId: widget._journalModel!.group!.sId,
                      groupName: widget._journalModel!.group!.groupName,
                      groupMediaUrl: widget._journalModel!.group!.groupImage,
                    ),
                  );
                }))
              }
            : widget._journalModel!.postedBy!.sId !=
                        null && ////// this case is for user journal
                    !widget._journalModel!.anonymousJournal! &&
                    widget._journalModel!.postedBy!.uid !=
                        FirebaseAuth.instance.currentUser!.uid
                ? {
                    connectionController
                        .getUserAnalytics(widget._journalModel!.postedBy!.sId!),
                    print(widget._journalModel!.postedBy!.sId),
                    // AutoRouter.of(context).push(ConnectScreenRouter(
                    //     uid: widget._journalModel!.postedBy!.uid ?? '',
                    //     sId: widget._journalModel!.postedBy!.sId ?? '')
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConnectProfileScreen(
                                uid: widget._journalModel!.postedBy!.uid!,
                                sId: widget._journalModel!.postedBy!.sId!)))
                  }
                : {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('You can not see this user'),
                      duration: Duration(milliseconds: 700),
                      backgroundColor: Colors.black.withOpacity(0.8),
                    )),
                    print('this post is anonymous'),
                    print(widget._journalModel!.postedBy!.sId),
                  },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFFD9D9D9),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: CircleAvatar(
                    backgroundImage: widget._journalModel!.anonymousJournal !=
                                null &&
                            widget._journalModel!.anonymousJournal! &&
                            widget._journalModel!.postedBy!.anonymous != null
                        ? CachedNetworkImageProvider(widget._journalModel!
                                .postedBy!.anonymous!.profilePicture ??
                            '')
                        : widget._journalModel!.group != null &&
                                journalPageController
                                        .selectedGroupId.value.length ==
                                    0
                            ? widget._journalModel!.group!.groupImage != null
                                ? CachedNetworkImageProvider(
                                    widget._journalModel!.group!.groupImage!)
                                : AssetImage(
                                        'assets/images/group_placeholder.png')
                                    as ImageProvider
                            : CachedNetworkImageProvider(widget
                                ._journalModel!.postedBy!.profilePicture!),
                    backgroundColor: SolhColors.white,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget._journalModel!.anonymousJournal !=
                                              null &&
                                          widget._journalModel!
                                              .anonymousJournal! &&
                                          widget._journalModel!.postedBy!
                                                  .anonymous !=
                                              null
                                      ? widget._journalModel!.postedBy!
                                              .anonymous!.userName ??
                                          ''
                                      : widget._journalModel!.group != null &&
                                              journalPageController
                                                      .selectedGroupId ==
                                                  ''
                                          ? widget._journalModel!.group!
                                                  .groupName ??
                                              ''
                                          : widget._journalModel!.postedBy !=
                                                  null
                                              ? widget._journalModel!.postedBy!
                                                      .name ??
                                                  ''
                                              : '',
                                  style: SolhTextStyles.JournalingUsernameText,
                                ),
                                widget._journalModel!.anonymousJournal !=
                                            null &&
                                        widget._journalModel!
                                                .anonymousJournal ==
                                            true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                          left: 3.w,
                                        ),
                                        child: Icon(
                                          Icons.lock_person,
                                          color: SolhColors.grey,
                                          size: 12,
                                        ),
                                      )
                                    : Container(),
                                SizedBox(width: 1.5.w),
                                if (widget._journalModel!.postedBy != null &&
                                    widget._journalModel!.postedBy!.userType ==
                                        "Expert")
                                  SolhExpertBadge(),
                              ],
                            ),
                            Row(
                              children: [
                                DateTime.tryParse(
                                            widget._journalModel!.createdAt ??
                                                '') !=
                                        null
                                    ? Text(
                                        timeago.format(DateTime.parse(
                                            widget._journalModel!.createdAt ??
                                                '')),
                                        style: SolhTextStyles
                                            .JournalingTimeStampText,
                                      )
                                    : Container(),
                                SizedBox(
                                  width: 1.5.w,
                                ),
                                widget._journalModel!.group != null
                                    ? Icon(
                                        CupertinoIcons.person_3_fill,
                                        color: Color(0xFFA6A6A6),
                                      )
                                    : Container()
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    widget._journalModel!.postedBy != null
                        ? widget._journalModel!.postedBy!.uid ==
                                    FirebaseAuth.instance.currentUser!.uid ||
                                widget._journalModel!.anonymousJournal !=
                                        null &&
                                    widget._journalModel!.anonymousJournal ==
                                        true &&
                                    widget._journalModel!.postedBy!.uid ==
                                        FirebaseAuth.instance.currentUser!.uid
                            ? PostMenuButton(
                                journalId: widget._journalModel!.id ?? '',
                                deletePost: widget._deletePost,
                              )
                            : Container()
                        : Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPostDetails(ConnectionController) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 35,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget._journalModel!.feelings != null
              ? Text(
                  "#Feeling " +
                      widget.feelingList
                          .toString()
                          .replaceAll("[", "")
                          .replaceAll("]", ""),
                  style: SolhTextStyles.PinkBorderButtonText)
              : Container(),
          // widget._journalModel!.description != null
          //     ? RichText(
          //         text: TextSpan(children: [
          //         TextSpan(
          //             text: getTexts()['text1'] ?? '',
          //             style: SolhTextStyles.JournalingDescriptionText,
          //             children: [
          //               getTexts().containsKey('text3')
          //                   ? TextSpan(
          //                       text: '@' + getTexts()['text3'],
          //                       recognizer: TapGestureRecognizer()
          //                         ..onTap = () async {
          //                           Navigator.push(
          //                               context,
          //                               MaterialPageRoute(
          //                                   builder: (context) =>
          //                                       ConnectProfileScreen(
          //                                         username: getTexts()['text3']
          //                                             .toString(),
          //                                         uid: '',
          //                                         sId: '',
          //                                       )));
          //                         },
          //                       style: TextStyle(color: Color(0xffE1555A)))
          //                   : TextSpan(text: ''),
          //               getTexts().containsKey('text2')
          //                   ? TextSpan(text: getTexts()['text2'])
          //                   : TextSpan(text: ''),
          //             ]),
          //       ]))

          // ? ReadMoreText(
          //     widget._journalModel!.description!,
          //     trimLines: 3,
          //     //trimLength: 100,
          //     style: SolhTextStyles.JournalingDescriptionText,
          //     colorClickableText: SolhColors.green,
          //     //trimMode: TrimMode.Length,
          //     trimMode: TrimMode.Line,
          //     trimCollapsedText: ' Read more',
          //     trimExpandedText: ' Less',
          //   )

          Wrap(
            children: widget._journalModel!.description!.length == 0
                ? []
                : getTexts().map((item) {
                    if (item.toString().trim()[0] == '@') {
                      if (checkConnectionExist(item)) {
                        print('it ran');
                        return Text(
                          item + ' ',
                          style: GoogleFonts.signika(
                              fontSize: 16, color: Color(0xff666666)),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConnectProfileScreen(
                                username:
                                    item.toString().substring(1, item.length),
                                uid: '',
                                sId: '',
                              ),
                            ),
                          );
                        },
                        child: Text(
                          item + " ",
                          style: GoogleFonts.signika(
                              fontSize: 16, color: Color(0xffE1555A)),
                        ),
                      );
                    } else {
                      return Text(
                        item + " " ?? '',
                        style: GoogleFonts.signika(
                            fontSize: 16, color: Color(0xff666666)),
                      );
                    }
                  }).toList(),
          )
        ],
      ),
    );
  }

  Widget getPostMedia() {
    return widget._journalModel!.mediaUrl != null &&
            widget._journalModel!.mediaUrl != ''
        ?
        //// For Video player ////
        widget._journalModel!.mediaType == 'video/mp4'
            ? InkWell(
                onTap: () {
                  widget.isMyJournal
                      ? journalPageController.playMyPostVideo(
                          widget.index,
                        )
                      : journalPageController.playVideo(
                          widget.index,
                        );
                  widget.isMyJournal
                      ? journalPageController.myVideoPlayerControllers.refresh()
                      : journalPageController.videoPlayerController.refresh();
                },
                child: Stack(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 80,
                        ),
                        child: VideoPlayer(
                          widget.isMyJournal
                              ? journalPageController.myVideoPlayerControllers
                                  .value[widget.index][widget.index]
                              : journalPageController.videoPlayerController
                                  .value[widget.index][widget.index],
                        )),
                    Obx(() {
                      return !widget.isMyJournal &&
                                  !journalPageController
                                      .videoPlayerController
                                      .value[widget.index][widget.index]!
                                      .value
                                      .isPlaying ||
                              widget.isMyJournal &&
                                  !journalPageController
                                      .myVideoPlayerControllers
                                      .value[widget.index][widget.index]!
                                      .value
                                      .isPlaying
                          ? getBlackOverlay()
                          : Container();
                    }),
                    Obx(() {
                      return !widget.isMyJournal &&
                                  !journalPageController
                                      .videoPlayerController
                                      .value[widget.index][widget.index]!
                                      .value
                                      .isPlaying ||
                              widget.isMyJournal &&
                                  !journalPageController
                                      .myVideoPlayerControllers
                                      .value[widget.index][widget.index]!
                                      .value
                                      .isPlaying
                          ? Positioned(
                              bottom: MediaQuery.of(context).size.height / 5,
                              left: MediaQuery.of(context).size.width / 2 -
                                  MediaQuery.of(context).size.width / 10,
                              child: IconButton(
                                onPressed: () {
                                  widget.isMyJournal
                                      ? journalPageController.playMyPostVideo(
                                          widget.index,
                                        )
                                      : journalPageController.playVideo(
                                          widget.index,
                                        );
                                  widget.isMyJournal
                                      ? journalPageController
                                          .myVideoPlayerControllers
                                          .refresh()
                                      : journalPageController
                                          .videoPlayerController
                                          .refresh();
                                },
                                icon: Image.asset(
                                  'assets/images/play_icon.png',
                                  fit: BoxFit.fill,
                                ),
                                iconSize: MediaQuery.of(context).size.width / 8,
                                color: SolhColors.green,
                              ),
                            )
                          : Container();
                    }),
                  ],
                ),
              )
            ///// Below for image only
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 0.5, color: Colors.grey.shade300)),
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 80,
                ),
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //   image:
                //       NetworkImage(widget._journalModel!.mediaUrl.toString()),
                //   fit: BoxFit.cover,
                // )),
                child: CachedNetworkImage(
                  imageUrl: widget._journalModel!.mediaUrl.toString(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => getShimmer(),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error)),
                ),
              )
        : Container(
            height: 1.h,
          );
  }

  Widget getPostActionButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 35,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              if (journalPageController.journalsList[widget.index].isLiked!) {
                journalPageController.journalsList[widget.index].isLiked =
                    false;
                journalPageController.journalsList[widget.index].likes =
                    journalPageController.journalsList[widget.index].likes! - 1;
                journalPageController.journalsList.refresh();
                await _unlikeJournal();
                setState(() {});
              } else {
                journalPageController.journalsList[widget.index].isLiked = true;
                journalPageController.journalsList[widget.index].likes =
                    journalPageController.journalsList[widget.index].likes! + 1;
                journalPageController.journalsList.refresh();
                await _likeJournal();
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 3.5,
              child: Container(
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.height / 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return Icon(
                        journalPageController
                                    .journalsList[widget.index].isLiked ==
                                true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: SolhColors.green,
                        size: 20,
                      );
                    }),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 40,
                      ),
                      child: Obx(() {
                        return Text(
                          journalPageController.journalsList[widget.index].likes
                              .toString(),
                          style: SolhTextStyles.GreenBorderButtonText,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => AutoRouter.of(context).push(CommentScreenRouter(
                journalModel: widget._journalModel, index: widget.index)),
            child: Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height / 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/journaling/post-comment.svg",
                    width: 17,
                    height: 17,
                    color: SolhColors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 40,
                    ),
                    child: Text(
                      widget._journalModel!.comments.toString(),
                      style: SolhTextStyles.GreenBorderButtonText,
                    ),
                  ),
                ],
              ),
              // onPressed: () {
              //   AutoRouter.of(context).push(CommentScreenRouter());
              // },
            ),
          ),
          widget._journalModel!.anonymousJournal != null &&
                  widget._journalModel!.anonymousJournal == true
              ? SizedBox()
              : widget._journalModel!.postedBy!.uid !=
                      FirebaseAuth.instance.currentUser!.uid
                  ? InkWell(
                      onTap: () async {
                        widget._journalModel!.group != null &&
                                journalPageController
                                        .selectedGroupId.value.length ==
                                    0
                            ? {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return GroupDetailsPage(
                                    ///// this case is for group journal
                                    group: GroupList(
                                      sId: widget._journalModel!.group!.sId,
                                      groupName: widget
                                          ._journalModel!.group!.groupName,
                                      groupMediaUrl: widget
                                          ._journalModel!.group!.groupImage,
                                    ),
                                  );
                                }))
                              }
                            : await connectionController.addConnection(
                                widget._journalModel!.postedBy!.sId!,
                              );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.5,
                        height: MediaQuery.of(context).size.height / 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/journaling/post-connect.svg",
                              width: 17,
                              height: 17,
                              color: SolhColors.green,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 40,
                              ),
                              child: Text(
                                widget._journalModel!.group != null &&
                                        journalPageController
                                                .selectedGroupId.value.length ==
                                            0
                                    ? 'join'
                                    : "Connect",
                                style: SolhTextStyles.GreenBorderButtonText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 100,
                    ),
        ],
      ),
    );
  }

  Widget getBlackOverlay() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 80,
      ),
      color: Colors.black.withOpacity(0.5),
    );
  }

  Widget getShimmer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 80,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}

class PostMenuButton extends StatelessWidget {
  const PostMenuButton(
      {Key? key, required String journalId, required VoidCallback deletePost})
      : _journalId = journalId,
        _deletePost = deletePost,
        super(key: key);

  final String _journalId;
  final VoidCallback _deletePost;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: SolhColors.grey102,
        ),
        iconSize: 20,
        color: SolhColors.white,
        padding: EdgeInsets.zero,
        offset: Offset(10, 0),
        itemBuilder: (context) => [
              // PopupMenuItem(
              //   child: Container(
              //     alignment: Alignment.centerRight,
              //     padding: EdgeInsets.only(
              //       right: MediaQuery.of(context).size.width/20,
              //       bottom: MediaQuery.of(context).size.height/30,
              //     ),
              //     decoration: BoxDecoration(
              //       border: Border(bottom: BorderSide(color: SolhColors.grey239),
              //       )
              //     ),
              //     child: SizedBox(
              //       width: 18,
              //       height: 18,
              //       child: IconButton(
              //         onPressed: () => Navigator.pop(context),
              //         icon: Icon(
              //           Icons.close,
              //         ),
              //         iconSize: 18,
              //         color: SolhColors.grey102,
              //         splashRadius: 16,
              //         ),
              //     ),
              //   ),
              //   value: 0,
              //   textStyle: SolhTextStyles.JournalingPostMenuText,
              //   padding: EdgeInsets.zero,
              // ),
              PopupMenuItem(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20,
                    vertical: MediaQuery.of(context).size.height / 80,
                  ),
                  child: Text(
                    "Delete this post",
                  ),
                ),
                onTap: _deletePost,
                value: 1,
                textStyle: SolhTextStyles.JournalingPostMenuText,
                padding: EdgeInsets.zero,
              ),
              // PopupMenuItem(
              //   child: Container(
              //     alignment: Alignment.centerLeft,
              //     padding: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width / 20,
              //       vertical: MediaQuery.of(context).size.height / 80,
              //     ),
              //     decoration: BoxDecoration(
              //         border: Border(
              //       bottom: BorderSide(color: SolhColors.grey239),
              //     )),
              //     child: Text(
              //       "Don't see this post again",
              //     ),
              //   ),
              //   value: 2,
              //   textStyle: SolhTextStyles.JournalingPostMenuText,
              //   padding: EdgeInsets.zero,
              // ),
              // PopupMenuItem(
              //   child: Container(
              //     alignment: Alignment.centerLeft,
              //     padding: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width / 20,
              //       vertical: MediaQuery.of(context).size.height / 80,
              //     ),
              //     decoration: BoxDecoration(
              //         border: Border(
              //       bottom: BorderSide(color: SolhColors.grey239),
              //     )),
              //     child: Text(
              //       "Block this person",
              //     ),
              //   ),
              //   value: 3,
              //   textStyle: SolhTextStyles.JournalingPostMenuText,
              //   padding: EdgeInsets.zero,
              // ),
              // PopupMenuItem(
              //   child: Container(
              //     alignment: Alignment.centerLeft,
              //     padding: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width / 20,
              //       vertical: MediaQuery.of(context).size.height / 80,
              //     ),
              //     decoration: BoxDecoration(
              //         border: Border(
              //       bottom: BorderSide(color: SolhColors.grey239),
              //     )),
              //     child: Text(
              //       "Report this post",
              //     ),
              //   ),
              //   value: 4,
              //   textStyle: SolhTextStyles.JournalingPostMenuText,
              //   padding: EdgeInsets.zero,
              // ),
            ]);
  }
}
