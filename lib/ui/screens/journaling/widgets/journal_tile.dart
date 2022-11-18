import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/controllers/journals/journal_comment_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/connect/connect-screen.dart';
import 'package:solh/ui/screens/my-profile/profile/edit-profile.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
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
  DiscoverGroupController discoverGroupController = Get.find();
  bool isGroupJoined = false;

  @override
  void initState() {
    super.initState();
    if (widget._journalModel!.group != null) {
      if (discoverGroupController.joinedGroupModel.value.groupList != null) {
        discoverGroupController.joinedGroupModel.value.groupList!
            .forEach((element) {
          if (element.sId == widget._journalModel!.group!.sId) {
            isGroupJoined = true;
          }
        });
      }
    }
  }

  // bool checkConnectionExist(username) {
  //   bool connectionExits = true;

  //   for (var i in connectionController.myConnectionModel.value.myConnections!) {
  //     print('@' + i.userName.toString() + username.toString());
  //     if ('@' + i.userName.toString() == username) {
  //       connectionExits = false;
  //       break;
  //     } else {
  //       connectionExits = true;
  //     }
  //   }
  //   print(connectionExits);
  //   return connectionExits;
  // }

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
              widget._journalModel!.postedBy != null
                  ? Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: widget._journalModel!.postedBy != null &&
                                      widget._journalModel!.anonymousJournal !=
                                          null &&
                                      !widget
                                          ._journalModel!.anonymousJournal! &&
                                      widget._journalModel!.group == null &&
                                      widget._journalModel!.official!
                                  ? LinearGradient(colors: [
                                      Color(0xFFE1555A).withOpacity(0.25),
                                      Color(0xFF5F9B8C).withOpacity(0.25),
                                    ])
                                  : widget._journalModel!.postedBy != null &&
                                          widget._journalModel!.anonymousJournal !=
                                              null &&
                                          !widget._journalModel!
                                              .anonymousJournal! &&
                                          widget._journalModel!.postedBy!.userType ==
                                              "SolhProvider" &&
                                          widget._journalModel!.group == null
                                      ? LinearGradient(colors: [
                                          Color(0xFFDBF1FE),
                                          Color(0xFFDBF1FE)
                                        ])
                                      : widget._journalModel!.postedBy != null &&
                                              widget._journalModel!.anonymousJournal !=
                                                  null &&
                                              !widget._journalModel!
                                                  .anonymousJournal! &&
                                              widget._journalModel!.postedBy!
                                                      .userType ==
                                                  "SolhVolunteer"
                                          ? LinearGradient(colors: [
                                              Color(0xFFD7E6E2),
                                              Color(0xFFD7E6E2)
                                            ])
                                          : widget._journalModel!.group != null &&
                                                  journalPageController
                                                      .selectedGroupId
                                                      .value
                                                      .isEmpty
                                              ? LinearGradient(colors: [
                                                  Color(0xffF8EDFF),
                                                  Color(0xffF8EDFF)
                                                ])
                                              : LinearGradient(colors: [
                                                  Color.fromRGBO(0, 0, 0, 0),
                                                  Color.fromRGBO(0, 0, 0, 0),
                                                ]),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget._journalModel!.postedBy!.isProvider! ||
                                        widget._journalModel!.group != null
                                    ? SizedBox(
                                        height: 8,
                                      )
                                    : SizedBox(),
                                getUserImageAndName(),
                                widget._journalModel!.postedBy!.isProvider! ||
                                        widget._journalModel!.group != null
                                    ? Container(
                                        height: 10,
                                      )
                                    : Divider(
                                        color: widget._journalModel!.group !=
                                                    null ||
                                                widget._journalModel!
                                                            .anonymousJournal !=
                                                        null &&
                                                    widget._journalModel!
                                                        .anonymousJournal! ||
                                                widget._journalModel!.postedBy!
                                                        .userType! ==
                                                    'Seeker'
                                            ? Colors.grey[300]
                                            : Colors.transparent,
                                        height: widget._journalModel!.group !=
                                                    null ||
                                                widget._journalModel!
                                                            .anonymousJournal !=
                                                        null &&
                                                    widget._journalModel!
                                                        .anonymousJournal! ||
                                                widget._journalModel!.postedBy!
                                                        .userType! ==
                                                    'Seeker'
                                            ? 0.0
                                            : 2,
                                      ),
                              ],
                            ),
                          ),
                        ),
                        widget.isMyJournal ||
                                widget._journalModel!.group == null
                            ? Container()
                            : getUserNameBottom()
                      ],
                    )
                  : Container(),
              PostContentWidget(
                  journalModel: widget._journalModel ?? Journals(),
                  index: widget.index,
                  isMyJournal: widget.isMyJournal),
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
    return Container(
      child: Padding(
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
                      widget._journalModel!.anonymousJournal != null &&
                      !widget._journalModel!.anonymousJournal!
                  ? {
                      // connectionController.getUserAnalytics(
                      //     widget._journalModel!.postedBy!.sId!),
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ConnectProfileScreen(
                      //             uid: widget._journalModel!.postedBy!.uid!,
                      //             sId: widget._journalModel!.postedBy!.sId!)))
                      //   Navigator.pushNamed(context, AppRoutes.userProfile,
                      //       arguments: {
                      //         "uid": widget._journalModel!.postedBy!.uid!,
                      //         "sId": widget._journalModel!.postedBy!.sId!
                      //       })
                      // }
                      Navigator.pushNamed(context, AppRoutes.connectScreen,
                          arguments: {
                            // "uid": widget._journalModel!.postedBy!.uid!,
                            "sId": widget._journalModel!.postedBy!.sId!
                          })
                    }
                  : {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('You can not see this user'),
                        duration: Duration(milliseconds: 700),
                        backgroundColor: Colors.black.withOpacity(0.8),
                      )),
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
                              widget._journalModel!.postedBy!.anonymous !=
                                  null &&
                              widget._journalModel!.anonymousJournal!
                          ? widget._journalModel!.group != null &&
                                  journalPageController.selectedGroupId.value.length ==
                                      0
                              ? widget._journalModel!.group!.groupImage != null
                                  ? CachedNetworkImageProvider(
                                      widget._journalModel!.group!.groupImage!)
                                  : AssetImage('assets/images/group_placeholder.png')
                                      as ImageProvider
                              : CachedNetworkImageProvider(widget._journalModel!
                                      .postedBy!.anonymous!.profilePicture ??
                                  '')
                          : widget._journalModel!.group != null &&
                                  journalPageController.selectedGroupId.value.length ==
                                      0
                              ? CachedNetworkImageProvider(
                                  widget._journalModel!.group!.groupImage!)
                              : widget._journalModel!.postedBy != null
                                  ? widget._journalModel!.postedBy!.anonymous !=
                                              null &&
                                          widget._journalModel!.anonymousJournal!
                                      ? CachedNetworkImageProvider(widget._journalModel!.postedBy!.profilePicture!)
                                      : CachedNetworkImageProvider(widget._journalModel!.postedBy!.profilePicture!)
                                  : CachedNetworkImageProvider(widget._journalModel!.postedBy!.profilePicture ?? ''),
                      backgroundColor: SolhColors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.8,
                                    child: Text(
                                      widget._journalModel!.anonymousJournal != null &&
                                              widget._journalModel!.postedBy!.anonymous !=
                                                  null &&
                                              widget._journalModel!
                                                  .anonymousJournal!
                                          ? widget._journalModel!.group != null &&
                                                  journalPageController
                                                          .selectedGroupId
                                                          .value
                                                          .length ==
                                                      0
                                              ? widget._journalModel!.group!.groupName ??
                                                  ''
                                              : widget._journalModel!.postedBy!
                                                      .anonymous!.userName ??
                                                  ''
                                          : widget._journalModel!.group != null &&
                                                  journalPageController
                                                          .selectedGroupId
                                                          .value
                                                          .length ==
                                                      0
                                              ? widget._journalModel!.group!.groupName ??
                                                  ''
                                              : widget._journalModel!.postedBy !=
                                                      null
                                                  ? widget._journalModel!.postedBy!.anonymous != null &&
                                                          widget._journalModel!
                                                              .anonymousJournal!
                                                      ? widget
                                                              ._journalModel!
                                                              .postedBy!
                                                              .anonymous!
                                                              .userName ??
                                                          ''
                                                      : widget._journalModel!.postedBy!.name ?? ''
                                                  : '',
                                      style:
                                          SolhTextStyles.JournalingUsernameText,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 1.5.w),

                                  // if (widget._journalModel!.postedBy != null &&
                                  //     widget._journalModel!.postedBy!
                                  //             .userType ==
                                  //         "Expert")
                                  //   SolhExpertBadge(),
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
                                  widget._journalModel!.group != null &&
                                          journalPageController.selectedGroupId
                                                  .value.length ==
                                              0
                                      ? Icon(
                                          CupertinoIcons.person_3_fill,
                                          color: Color(0xFFA6A6A6),
                                        )
                                      : Container(),
                                  widget._journalModel!.postedBy != null &&
                                          widget._journalModel!.anonymousJournal !=
                                              null &&
                                          !widget
                                              ._journalModel!.anonymousJournal! &&
                                          widget._journalModel!.postedBy!
                                                  .userType ==
                                              "Official"
                                      ? SolhExpertBadge(
                                          usertype: 'Official',
                                        )
                                      : widget._journalModel!.postedBy != null &&
                                              widget._journalModel!
                                                      .anonymousJournal !=
                                                  null &&
                                              !widget._journalModel!
                                                  .anonymousJournal! &&
                                              widget._journalModel!.postedBy!
                                                      .userType ==
                                                  "SolhProvider"
                                          ? SolhExpertBadge(
                                              usertype: 'Counsellor',
                                            )
                                          : widget._journalModel!.postedBy !=
                                                      null &&
                                                  widget._journalModel!
                                                          .anonymousJournal !=
                                                      null &&
                                                  !widget._journalModel!
                                                      .anonymousJournal! &&
                                                  widget._journalModel!
                                                          .postedBy!.userType ==
                                                      "SolhVolunteer"
                                              ? SolhExpertBadge(
                                                  usertype: 'Volunteer',
                                                )
                                              : widget._journalModel!
                                                              .postedBy !=
                                                          null &&
                                                      widget
                                                              ._journalModel!
                                                              .postedBy!
                                                              .userType ==
                                                          "Seeker"
                                                  ? Container()
                                                  : Container(),
                                  widget._journalModel!.anonymousJournal !=
                                              null &&
                                          widget._journalModel!
                                                  .anonymousJournal ==
                                              true
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                            left: 3.w,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'https://solh.s3.amazonaws.com/groupMedia/1653644939579',
                                            fit: BoxFit.fitWidth,
                                            width: 12,
                                            height: 12,
                                            color: SolhColors.grey,
                                          ))
                                      : Container(),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
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
                              : PostMenuButton(
                                  journalId: widget._journalModel!.id ?? '',
                                  userId:
                                      widget._journalModel!.postedBy!.sId ?? '',
                                )
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
      ),
    );
  }

  Widget getUserNameBottom() {
    return InkWell(
      onTap: () {
        widget._journalModel!.postedBy!.sId !=
                    null && ////// this case is for user journal
                widget._journalModel!.anonymousJournal != null &&
                !widget._journalModel!.anonymousJournal!
            ? {
                // connectionController.getUserAnalytics(
                //     widget._journalModel!.postedBy!.sId!),
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ConnectProfileScreen(
                //             uid: widget._journalModel!.postedBy!.uid!,
                //             sId: widget._journalModel!.postedBy!.sId!)))
                // Navigator.pushNamed(context, AppRoutes.userProfile, arguments: {
                //   "uid": widget._journalModel!.postedBy!.uid!,
                //   "sId": widget._journalModel!.postedBy!.sId!
                // })
                Navigator.pushNamed(context, AppRoutes.connectScreen,
                    arguments: {"sId": widget._journalModel!.postedBy!.sId!})
              }
            : {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('You can not see this user'),
                  duration: Duration(milliseconds: 700),
                  backgroundColor: Colors.black.withOpacity(0.8),
                )),
              };
      },
      child: Row(
        children: [
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.black.withOpacity(0.1),
            margin: EdgeInsets.only(right: 10),
          )),
          widget._journalModel!.group != null &&
                  journalPageController.selectedGroupId.value.length == 0
              ? CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(
                    widget._journalModel!.anonymousJournal!
                        ? widget._journalModel!.postedBy!.anonymous!
                                .profilePicture ??
                            ''
                        : widget._journalModel!.postedBy!.profilePicture ?? '',
                  ),
                )
              : Container(
                  height: 30,
                ),
          widget._journalModel!.group != null &&
                  journalPageController.selectedGroupId.value.length == 0
              ? Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    widget._journalModel!.anonymousJournal == true
                        ? widget._journalModel!.postedBy!.anonymous!.userName ??
                            ''
                        : widget._journalModel!.postedBy!.name ?? '',
                  ),
                )
              : Container(),
        ],
      ),
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
          widget._journalModel!.postedBy != null
              ? widget._journalModel!.anonymousJournal != null &&
                      widget._journalModel!.anonymousJournal == true &&
                      widget._journalModel!.group == null
                  ? SizedBox()
                  : widget._journalModel!.postedBy!.uid !=
                          FirebaseAuth.instance.currentUser!.uid
                      ? journalPageController
                                  .selectedGroupId.value.isNotEmpty &&
                              widget._journalModel!.anonymousJournal != null &&
                              widget._journalModel!.anonymousJournal == true
                          ? Container()
                          : InkWell(
                              onTap: () async {
                                widget._journalModel!.group != null &&
                                        journalPageController
                                                .selectedGroupId.value.length ==
                                            0
                                    ? {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return GroupDetailsPage(
                                            ///// this case is for group journal
                                            group: GroupList(
                                              sId: widget
                                                  ._journalModel!.group!.sId,
                                              groupName: widget._journalModel!
                                                  .group!.groupName,
                                              groupMediaUrl: widget
                                                  ._journalModel!
                                                  .group!
                                                  .groupImage,
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
                                        left:
                                            MediaQuery.of(context).size.width /
                                                40,
                                      ),
                                      child: Text(
                                        widget._journalModel!.group != null &&
                                                journalPageController
                                                        .selectedGroupId
                                                        .value
                                                        .length ==
                                                    0
                                            ? isGroupJoined
                                                ? 'Go To Group'
                                                : 'join'
                                            : "Connect",
                                        style: SolhTextStyles
                                            .GreenBorderButtonText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                      : SizedBox(
                          width: 100,
                        )
              : SizedBox(),
        ],
      ),
    );
  }
}

//////  journalPageController.selectedGroupId.value.isEmpty

class PostContentWidget extends StatefulWidget {
  PostContentWidget(
      {Key? key,
      required this.journalModel,
      required this.index,
      required this.isMyJournal,
      this.isHomePage})
      : super(key: key);
  final Journals journalModel;
  final int index;
  final bool isMyJournal;
  final bool? isHomePage;

  @override
  State<PostContentWidget> createState() => _PostContentWidgetState();
}

class _PostContentWidgetState extends State<PostContentWidget> {
  List<String> feelingList = [];
  List<String> descriptionTexts = [];
  bool showMoreBtn = false;
  bool isExpanded = false;

  @override
  void initState() {
    getFeelings();
    getTexts();
    super.initState();
  }

  final JournalPageController journalPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 35,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.journalModel.feelings != null &&
                        widget.journalModel.feelings!.isNotEmpty
                    ? Text(
                        feelingList
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

                descriptionTexts.length == 1
                    ? ReadMoreText(
                        descriptionTexts[0],
                        trimLines: 5,
                        style: GoogleFonts.signika(
                            color: Color(0xff666666), fontSize: 14),
                      )
                    : Wrap(children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: widget.journalModel.description!.length == 0
                              ? []
                              : showMoreBtn
                                  ? isExpanded
                                      ? descriptionTexts.map((item) {
                                          return getDescriptionText(item);
                                        }).toList()
                                      : descriptionTexts
                                          .sublist(0, 30)
                                          .map((item) {
                                          return getDescriptionText(item);
                                        }).toList()
                                  : descriptionTexts.map((item) {
                                      return getDescriptionText(item);
                                    }).toList(),
                        ),
                        showMoreBtn
                            ? InkWell(
                                child: Text(
                                  !isExpanded ? '...show more' : '...show less',
                                  style: GoogleFonts.signika(
                                      color: SolhColors.green),
                                ),
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                              )
                            : Container()
                      ])
              ],
            ),
          ),
          widget.journalModel.mediaUrl != null &&
                  widget.journalModel.mediaUrl != ''
              ?
              //// For Video player ////
              widget.journalModel.mediaType == 'video/mp4'
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
                            ? journalPageController.myVideoPlayerControllers
                                .refresh()
                            : journalPageController.videoPlayerController
                                .refresh();
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width,
                            child: VideoPlayer(
                              widget.isMyJournal
                                  ? journalPageController
                                      .myVideoPlayerControllers
                                      .value[widget.index][widget.index]
                                  : journalPageController.videoPlayerController
                                      .value[widget.index][widget.index],
                            ),
                          ),
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
                                ? getBlackOverlay(context)
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
                                    bottom:
                                        MediaQuery.of(context).size.height / 5,
                                    left: MediaQuery.of(context).size.width /
                                            2 -
                                        MediaQuery.of(context).size.width / 10,
                                    child: IconButton(
                                      onPressed: () {
                                        widget.isMyJournal
                                            ? journalPageController
                                                .playMyPostVideo(
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
                                      iconSize:
                                          MediaQuery.of(context).size.width / 8,
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
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.5, color: Colors.grey.shade300)),
                      margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 80,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.journalModel.mediaUrl.toString(),
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) => getShimmer(context),
                        errorWidget: (context, url, error) => Center(
                          child: Image.asset(
                              'assets/images/no-image-available.png'),
                        ),
                      ),
                    )
              : Container(
                  height: 1.h,
                )
        ],
      ),
    );
  }

  List getTexts() {
    String desc = widget.journalModel.description!;
    List<String> textList = desc.split(' ');
    var regx = RegExp(r'@');
    // if (textList.length > 30) {
    //   showMoreBtn = true;
    // }

    if (regx.hasMatch(desc)) {
      if (textList.length > 30) {
        showMoreBtn = true;
      }
      descriptionTexts = textList;
    } else {
      descriptionTexts = [desc];
      textList = [desc];
    }
    descriptionTexts = textList;
    print('textList: $descriptionTexts');

    return textList;
  }

  void getFeelings() {
    widget.journalModel.feelings!.forEach((element) {
      feelingList.add(element.feelingName ?? '');
    });
    if (feelingList.length > 4) {
      feelingList.removeRange(4, feelingList.length);
    }
    print(feelingList);
  }

  Widget getBlackOverlay(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 200,
      ),
      color: Colors.black.withOpacity(0.5),
    );
  }

  Widget getShimmer(BuildContext context) {
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

  Widget getDescriptionText(
    item,
  ) {
    return item.toString().trim().isNotEmpty && item.toString().trim()[0] == '@'
        ? InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ConnectProfileScreen(
              //       username: item.toString().substring(1, item.length),
              //       uid: '',
              //       sId: '',
              //     ),
              //   ),
              // );
              Navigator.pushNamed(context, AppRoutes.connectScreen, arguments: {
                "userName": item.toString().substring(1, item.length),
                "sId": "123",
              });
            },
            child: Text(
              item + " ",
              style:
                  GoogleFonts.signika(fontSize: 16, color: Color(0xffE1555A)),
            ),
          )
        : Text(
            item + " " ?? '',
            style: GoogleFonts.signika(fontSize: 16, color: Color(0xff666666)),
          );
  }
}

class PostMenuButton extends StatelessWidget {
  PostMenuButton(
      {Key? key,
      required String journalId,
      VoidCallback? deletePost,
      String? userId})
      : _journalId = journalId,
        _deletePost = deletePost,
        _userId = userId ?? '',
        super(key: key);

  final String _journalId;
  final VoidCallback? _deletePost;
  final String _userId;
  final JournalCommentController journalCommentController = Get.find();
  final JournalPageController journalPageController = Get.find();
  final TextEditingController reasonController = TextEditingController();

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
              PopupMenuItem(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20,
                    vertical: MediaQuery.of(context).size.height / 80,
                  ),
                  child: Text(
                    _deletePost != null
                        ? "Delete this post"
                        : "Report this post",
                  ),
                ),
                onTap: _deletePost != null
                    ? _deletePost
                    : () {
                        journalCommentController.isReportingPost.value = false;
                        showDialog(
                          context: context,
                          builder: (context) => ReportPostDialog(context,
                              journalId: _journalId, type: 'post'),
                        );
                      },
                value: 1,
                textStyle: SolhTextStyles.JournalingPostMenuText,
                padding: EdgeInsets.zero,
              ),
              PopupMenuItem(
                height: _deletePost != null ? 0 : 48,
                child: _deletePost == null
                    ? Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 20,
                          vertical: MediaQuery.of(context).size.height / 80,
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(color: SolhColors.grey239),
                        )),
                        child: Text(
                          "Report this person",
                        ),
                      )
                    : Container(),
                onTap: _deletePost != null
                    ? null
                    : () {
                        journalCommentController.isReportingPost.value = false;
                        showDialog(
                          context: context,
                          builder: (context) => ReportPostDialog(context,
                              journalId: _userId, type: 'user'),
                        );
                      },
                value: 2,
                textStyle: SolhTextStyles.JournalingPostMenuText,
                padding: EdgeInsets.zero,
              ),
              PopupMenuItem(
                height: _deletePost != null ? 0 : 48,
                child: _deletePost == null
                    ? Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 20,
                          vertical: MediaQuery.of(context).size.height / 80,
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(color: SolhColors.grey239),
                        )),
                        child: Text(
                          "Don't show this post again",
                        ),
                      )
                    : Container(),
                onTap: _deletePost == null
                    ? () {
                        journalPageController.journalsList
                            .removeWhere((element) => element.id == _journalId);
                        journalPageController.journalsList.refresh();
                        userBlocNetwork.hiddenPosts.add(_journalId);
                        journalPageController.hidePost(
                          journalId: _journalId,
                        );
                      }
                    : null,
                value: 3,
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
              //       "Report this post",
              //     ),
              //   ),
              //   value: 4,
              //   textStyle: SolhTextStyles.JournalingPostMenuText,
              //   padding: EdgeInsets.zero,
              // ),
            ]);
  }

  ReportPostDialog(BuildContext context,
      {required String journalId, required String type}) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 20,
          vertical: MediaQuery.of(context).size.height / 80,
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: SolhColors.white,
        ),
        child: Column(children: [
          Align(
              alignment: Alignment.topRight,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: SolhColors.black,
                  ))),
          SizedBox(height: 10),
          Text(
            "We are sorry for your inconvenience due to this post/person. Please let us know what is the problem with this post/person.",
            style: SolhTextStyles.JournalingPostMenuText,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          TextFieldB(
            label: 'Reason',
            maxLine: 4,
            textEditingController: reasonController,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          SolhGreenButton(
            child: Obx(() {
              return !journalCommentController.isReportingPost.value
                  ? Text(
                      'Report',
                      style: SolhTextStyles.GreenButtonText,
                    )
                  : Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: SolhColors.white,
                        strokeWidth: 1,
                      ));
            }),
            onPressed: journalCommentController.isReportingPost.value
                ? null
                : () async {
                    await journalCommentController.reportPost(
                        journalId: journalId,
                        reason: reasonController.text,
                        type: type);
                    Navigator.pop(context);
                  },
          ),
        ]),
      ),
    );
  }
}
