import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/comment/comment-screen.dart';
import 'package:solh/ui/screens/my-profile/profile/edit-profile.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';
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
  final TextEditingController reasonController = TextEditingController();
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

  /*  Future<bool> _likeJournal() async {
    setState(() {});
    var response = await Network.makeHttpPostRequestWithToken(
        url: "${APIConstants.api}/api/like-journal",
        body: {"post": widget._journalModel!.id});
    if (response["status"] == false) setState(() {});
    FirebaseAnalytics.instance
        .logEvent(name: 'LikeTapped', parameters: {'Page': 'JournalTile'});
    return (response["status"]);
  }

  Future<bool> _unlikeJournal() async {
    var response = await Network.makeHttpDeleteRequestWithToken(
      body: {"postId": widget._journalModel!.id},
      url: "${APIConstants.api}/api/unlike-journal",
    );
    print(response);
    return true;
  } */

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
                  Navigator.pushNamed(context, AppRoutes.groupDetails,
                      arguments: {
                        "group": GroupList(
                          sId: widget._journalModel!.group!.sId,
                          groupName: widget._journalModel!.group!.groupName,
                          groupMediaUrl:
                              widget._journalModel!.group!.groupImage,
                        ),
                      })
                }
              : widget._journalModel!.postedBy!.sId !=
                          null && ////// this case is for user journal
                      widget._journalModel!.anonymousJournal != null &&
                      !widget._journalModel!.anonymousJournal!
                  ? {
                      Navigator.pushNamed(context, AppRoutes.connectScreen,
                          arguments: {
                            "uid": widget._journalModel!.postedBy!.uid!,
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
                                              : Get.find<ProfileController>()
                                                          .myProfileModel
                                                          .value
                                                          .body !=
                                                      null
                                                  ? widget._journalModel!
                                                              .postedBy!.sId ==
                                                          Get.find<ProfileController>()
                                                              .myProfileModel
                                                              .value
                                                              .body!
                                                              .user!
                                                              .sId
                                                      ? 'You'
                                                      : widget
                                                              ._journalModel!
                                                              .postedBy!
                                                              .anonymous!
                                                              .userName ??
                                                          ''
                                                  : widget
                                                          ._journalModel!
                                                          .postedBy!
                                                          .anonymous!
                                                          .userName ??
                                                      ''
                                          : widget._journalModel!.group != null &&
                                                  journalPageController.selectedGroupId.value.length == 0
                                              ? widget._journalModel!.group!.groupName ?? ''
                                              : widget._journalModel!.postedBy != null
                                                  ? widget._journalModel!.postedBy!.anonymous != null && widget._journalModel!.anonymousJournal!
                                                      ? Get.find<ProfileController>().myProfileModel.value.body == null
                                                          ? widget._journalModel!.postedBy!.anonymous!.userName ?? ''
                                                          : widget._journalModel!.postedBy!.sId == Get.find<ProfileController>().myProfileModel.value.body!.user!.sId
                                                              ? 'You'
                                                              : widget._journalModel!.postedBy!.anonymous!.userName ?? ''
                                                      : Get.find<ProfileController>().myProfileModel.value.body == null
                                                          ? widget._journalModel!.postedBy!.anonymous == null
                                                              ? widget._journalModel!.postedBy!.name ?? ''
                                                              : widget._journalModel!.postedBy!.anonymous!.userName ?? ''
                                                          : widget._journalModel!.postedBy!.sId == Get.find<ProfileController>().myProfileModel.value.body!.user!.sId
                                                              ? 'You'
                                                              : widget._journalModel!.postedBy!.name ?? ''
                                                  : '',
                                      style:
                                          SolhTextStyles.JournalingUsernameText,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 1.5.w),
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
                Navigator.pushNamed(context, AppRoutes.connectScreen,
                    arguments: {
                      "sId": widget._journalModel!.postedBy!.sId!,
                      "uid": widget._journalModel!.postedBy!.uid!
                    })
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
            onTap: () {
              journalPageController.getUsersLikedPost(
                  widget._journalModel!.id ?? '', 1);
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: LikesModalSheet(
                        onTap: (value) async {
                          Navigator.of(context).pop();
                          String message =
                              await journalCommentController.likePost(
                                  journalId: widget._journalModel!.id ?? '',
                                  reaction: value);
                          if (message == 'journal liked successfully') {
                            journalPageController.journalsList[widget.index]
                                .likes = journalPageController
                                    .journalsList[widget.index].likes! +
                                1;
                            journalPageController
                                .journalsList[widget.index].isLiked = true;
                            journalPageController.journalsList.refresh();
                            FirebaseAnalytics.instance.logEvent(
                                name: 'LikeTapped',
                                parameters: {'Page': 'JournalTile'});
                          } else {
                            Utility.showToast(message);
                          }
                        },
                      ),
                    );
                  });
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 3.5,
              child: Container(
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.height / 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => SvgPicture.asset(
                          journalPageController
                                  .journalsList[widget.index].isLiked!
                              ? 'assets/images/reactions_liked.svg'
                              : 'assets/images/reactions.svg',
                        )),
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
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CommentScreen(
                    journalModel: widget._journalModel, index: widget.index);
              }));
              FirebaseAnalytics.instance.logEvent(
                  name: 'CommentIconTapped',
                  parameters: {'Page': 'journaling'});
            },
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
                      color: SolhColors.primary_green,
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
                )),
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
                                        Navigator.pushNamed(
                                            context, AppRoutes.groupDetails,
                                            arguments: {
                                              "group": GroupList(
                                                sId: widget
                                                    ._journalModel!.group!.sId,
                                                groupName: widget._journalModel!
                                                    .group!.groupName,
                                                groupMediaUrl: widget
                                                    ._journalModel!
                                                    .group!
                                                    .groupImage,
                                              ),
                                            })
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
                                        'assets/images/connect.svg'),
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

class LikesModalSheet extends StatelessWidget {
  final JournalPageController journalPageController = Get.find();
  final JournalCommentController journalCommentController = Get.find();

  LikesModalSheet({required this.onTap});
  final Function(String) onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                  child: Column(
                    children: [
                      Container(
                        height: 5,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Post Liked By',
                              style: GoogleFonts.signika(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Obx((){
                  return journalCommentController.isReactionLoading.value?ButtonLoadingAnimation() :  ( journalCommentController.reactionlistModel.value.data != null
                    ? Wrap(
                        alignment: WrapAlignment.start,
                        children: journalCommentController
                            .reactionlistModel.value.data!
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    onTap(e.sId ?? '');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 0.5.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 1.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: SolhColors.primary_green),
                                      borderRadius: BorderRadius.circular(18),
                                      color: Color(0xFFFBFBFB),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          e.reactionName ?? '',
                                          style: SolhTextStyles.QS_cap_semi,
                                        ),
                                        SizedBox(width: 3),
                                        SvgPicture.network(
                                            e.reactionImage ?? '')
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      )
                    : Container());
                }),
            
                Divider(),
              Obx(() => journalPageController.isLikedUserListLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          :   (journalPageController.likedUserList.value.result == null
                    ? Container()
                    : journalPageController
                            .likedUserList.value.result!.data!.isEmpty
                        ? Container()
                        : Expanded(
                            child: ListView.builder(
                                itemCount: journalPageController
                                    .likedUserList.value.result!.data!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              backgroundImage: NetworkImage(
                                                  journalPageController
                                                          .likedUserList
                                                          .value
                                                          .result!
                                                          .data![index]
                                                          .user!
                                                          .profilePicture ??
                                                      ''),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 30, 0),
                                              child: Text(
                                                journalPageController
                                                            .likedUserList
                                                            .value
                                                            .result!
                                                            .data![index]
                                                            .user!
                                                            .sId ==
                                                        Get.find<
                                                                ProfileController>()
                                                            .myProfileModel
                                                            .value
                                                            .body!
                                                            .user!
                                                            .sId
                                                    ? "You"
                                                    : journalPageController
                                                            .likedUserList
                                                            .value
                                                            .result!
                                                            .data![index]
                                                            .user!
                                                            .name ??
                                                        '',
                                                style: GoogleFonts.signika(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            SvgPicture.network(
                                                journalPageController
                                                        .likedUserList
                                                        .value
                                                        .result!
                                                        .data![index]
                                                        .reaction!
                                                        .reactionImage ??
                                                    '')
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ))
      )],
            )
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
          widget.journalModel.feelings != null &&
                  widget.journalModel.feelings!.isNotEmpty &&
                  widget.journalModel.description!.length == 0
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.journalModel.feelings != null &&
                            widget.journalModel.feelings!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 8.0),
                            child: Text(
                              feelingList
                                  .toString()
                                  .replaceAll("[", "")
                                  .replaceAll("]", ""),
                              style: SolhTextStyles.QS_body_2_bold.copyWith(
                                  color: SolhColors.primaryRed),
                            ),
                          )
                        : Container(),
                    descriptionTexts[0].trim().isEmpty
                        ? SizedBox()
                        : widget.journalModel.description!.length != 0
                            ? descriptionTexts.length == 1
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                        top: 2.0,
                                        bottom: 8.0),
                                    child: ReadMoreText(
                                        descriptionTexts[0].trim(),
                                        trimLines: 5,
                                        style: SolhTextStyles.QS_body_2_semi),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                        top: 8.0,
                                        bottom: 8.0),
                                    child: Wrap(children: [
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.end,
                                        children: widget.journalModel
                                                    .description!.length ==
                                                0
                                            ? []
                                            : showMoreBtn
                                                ? isExpanded
                                                    ? descriptionTexts
                                                        .map((item) {
                                                        return getDescriptionText(
                                                            item);
                                                      }).toList()
                                                    : descriptionTexts
                                                        .sublist(0, 30)
                                                        .map((item) {
                                                        return getDescriptionText(
                                                            item);
                                                      }).toList()
                                                : descriptionTexts.map((item) {
                                                    return getDescriptionText(
                                                        item);
                                                  }).toList(),
                                      ),
                                      showMoreBtn
                                          ? InkWell(
                                              child: Text(
                                                !isExpanded
                                                    ? '...show more'
                                                    : '...show less',
                                                style: GoogleFonts.signika(
                                                    color: SolhColors
                                                        .primary_green),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  isExpanded = !isExpanded;
                                                });
                                              },
                                            )
                                          : Container()
                                    ]),
                                  )
                            : SizedBox(),
                  ],
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
                      //////   we need to remove widget.isMyJournal  ? Container():  to play my post in //////
                      child: widget.isMyJournal
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AspectRatio(
                                    aspectRatio: double.parse(
                                        widget.journalModel.aspectRatio ??
                                            (16 / 9).toString()),
                                    child: VideoPlayer(
                                      widget.isMyJournal
                                          ? journalPageController
                                                  .myVideoPlayerControllers
                                                  .value[widget.index]
                                              [widget.index]!
                                          : journalPageController
                                                  .videoPlayerController
                                                  .value[widget.index]
                                              [widget.index]!,
                                    ),
                                  ),
                                  Obx(() {
                                    return !widget.isMyJournal &&
                                                !journalPageController
                                                    .videoPlayerController
                                                    .value[widget.index]
                                                        [widget.index]!
                                                    .value
                                                    .isPlaying ||
                                            widget.isMyJournal &&
                                                !journalPageController
                                                    .myVideoPlayerControllers
                                                    .value[widget.index]
                                                        [widget.index]!
                                                    .value
                                                    .isPlaying
                                        ? getBlackOverlay(
                                            context,
                                            aspectRatio: double.parse(widget
                                                    .journalModel.aspectRatio ??
                                                (16 / 9).toString()),
                                          )
                                        : Container();
                                  }),
                                  Obx(() {
                                    return !widget.isMyJournal &&
                                                !journalPageController
                                                    .videoPlayerController
                                                    .value[widget.index]
                                                        [widget.index]!
                                                    .value
                                                    .isPlaying ||
                                            widget.isMyJournal &&
                                                !journalPageController
                                                    .myVideoPlayerControllers
                                                    .value[widget.index]
                                                        [widget.index]!
                                                    .value
                                                    .isPlaying
                                        ? Positioned(
                                            child: IconButton(
                                              onPressed: () async {
                                                widget.isMyJournal
                                                    ? journalPageController
                                                        .playMyPostVideo(
                                                        widget.index,
                                                      )
                                                    : journalPageController
                                                        .playVideo(
                                                        widget.index,
                                                      );
                                                widget.isMyJournal
                                                    ? journalPageController
                                                        .myVideoPlayerControllers
                                                        .refresh()
                                                    : journalPageController
                                                        .videoPlayerController
                                                        .refresh();
                                                FirebaseAnalytics.instance
                                                    .logEvent(
                                                        name: 'playVideoTapped',
                                                        parameters: {
                                                      'Page': 'Journaling'
                                                    });
                                              },
                                              icon: Image.asset(
                                                'assets/images/play_icon.png',
                                                fit: BoxFit.fill,
                                              ),
                                              iconSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                              color: SolhColors.primary_green,
                                            ),
                                          )
                                        : Container();
                                  }),
                                ],
                              ),
                            ),
                    )
                  ///// Below for image only
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: Colors.grey.shade300)),
                        // margin: EdgeInsets.symmetric(
                        //   vertical: MediaQuery.of(context).size.height / 80,
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: widget.journalModel.mediaUrl.toString(),
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) => getShimmer(context),
                          errorWidget: (context, url, error) => Center(
                            child: Image.asset(
                              'assets/images/no-image-available.png',
                            ),
                          ),
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
    String desc = widget.journalModel.description!.trim();
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

  Widget getBlackOverlay(BuildContext context, {required double aspectRatio}) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        color: Colors.black.withOpacity(0.5),
      ),
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
  final FocusNode reasonFieldFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: SolhColors.dark_grey,
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
                        Future.delayed(Duration(microseconds: 200), () {
                          reasonFieldFocus.requestFocus();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ReportPostDialog(context,
                                  journalId: _journalId, type: 'post');
                            },
                          );
                        });
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
                        Future.delayed(Duration(milliseconds: 200), () {
                          reasonFieldFocus.requestFocus();
                          showDialog(
                            context: context,
                            builder: (context) => ReportPostDialog(context,
                                journalId: _userId, type: 'user'),
                          );
                        });
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
                          "Block this person",
                        ),
                      )
                    : Container(),
                onTap: _deletePost != null
                    ? null
                    : () async {
                        Map<String, dynamic> map =
                            await Get.find<ConnectionController>()
                                .blockUser(sId: _userId);

                        print(map);
                        if (map['success']) {
                          FirebaseAnalytics.instance.logEvent(
                              name: 'UserBlockTapped',
                              parameters: {'Page': 'JournalTile'});
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Person Successfully Blocked'),
                            backgroundColor: SolhColors.primary_green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Oops !! Something Went Wrong'),
                            backgroundColor: SolhColors.primary_green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                          ));
                        }
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('Post Successfully Removed From Your Feed '),
                          backgroundColor: SolhColors.primary_green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                        ));
                      }
                    : null,
                value: 3,
                textStyle: SolhTextStyles.JournalingPostMenuText,
                padding: EdgeInsets.zero,
              ),
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
            focusNode: reasonFieldFocus,
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
                    reasonFieldFocus.unfocus();
                    await journalCommentController.reportPost(
                        journalId: journalId,
                        reason: reasonController.text,
                        type: type);
                    reasonController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Successfully Reported'),
                      backgroundColor: SolhColors.primary_green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                    ));
                    Navigator.pop(context);
                  },
          ),
        ]),
      ),
    );
  }
}
