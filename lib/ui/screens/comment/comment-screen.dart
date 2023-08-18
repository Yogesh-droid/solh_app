import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/journals/journal_comment_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/comment.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/model/journals/get_jouranal_comment_model.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/services/errors/no_internet_page.dart';
import 'package:solh/services/errors/not_found.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../controllers/profile/anon_controller.dart';
import '../../../routes/routes.dart';
import '../journaling/create-journal.dart';
import '../journaling/widgets/comment_menu_btn.dart';
import '../journaling/widgets/journal_tile.dart';
import '../journaling/widgets/solh_expert_badge.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen(
      {Key? key, required Journals? journalModel, required this.index})
      : _journalModel = journalModel,
        super(key: key);

  final Journals? _journalModel;
  final int index;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final JournalPageController _journalPageController = Get.find();
  bool? _isLoginedUserJournal;

  final JournalCommentController journalCommentController = Get.find();
  final AnonController _anonController = Get.find();
  final ProfileController profileController = Get.find();
  final FocusNode _commentFocusnode = FocusNode();
  final TextEditingController _commentEditingController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool isFetchingMore = false;
  int pageNo = 1;

  // @override
  // void initState() {
  //   super.initState();
  //   journalCommentController.commentList.clear();
  //   journalCommentController.repliesList.clear();
  //   journalCommentController.nextPage = 1;
  //   journalCommentController.previousPage = -2;
  //   _scrollController.addListener(() async {
  //     if (_scrollController.position.pixels ==
  //         _scrollController.position.maxScrollExtent) {
  //       print("current pixels are ${_scrollController.position.pixels}");
  //       print("max position is  ${_scrollController.position.maxScrollExtent}");
  //       pageNo++;
  //       setState(() {
  //         isFetchingMore = true;
  //       });
  //       await getComments();
  //       setState(() {
  //         isFetchingMore = false;
  //       });
  //     }
  //   });

  //     getComments();
  //     if (_isLoginedUserJournal = widget._journalModel!.postedBy != null) {
  //       _isLoginedUserJournal = widget._journalModel!.postedBy!.uid ==
  //           FirebaseAuth.instance.currentUser!.uid;
  //     }
  //     journalCommentController.repliedTo.value = '';
  //     journalCommentController.isReplying.value = false;
  //   }

  // }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      journalCommentController.commentList.clear();
      journalCommentController.repliesList.clear();
      journalCommentController.nextPage = 1;
      journalCommentController.previousPage = -2;
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          print("current pixels are ${_scrollController.position.pixels}");
          print(
              "max position is  ${_scrollController.position.maxScrollExtent}");
          pageNo++;
          setState(() {
            isFetchingMore = true;
          });
          await getComments();
          setState(() {
            isFetchingMore = false;
          });
        }
      });
      getComments();
      if (_isLoginedUserJournal = widget._journalModel!.postedBy != null) {
        _isLoginedUserJournal = widget._journalModel!.postedBy!.uid ==
            FirebaseAuth.instance.currentUser!.uid;
      }
      journalCommentController.repliedTo.value = '';
      journalCommentController.isReplying.value = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
          title: Text(
            "Comments".tr,
            style: SolhTextStyles.AppBarText,
          ),
          isLandingScreen: false,
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
              child: Column(
                children: [
                  getUserNameAndImage(),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: Obx(() => !journalCommentController.isLoading.value
                          ? journalCommentController.getJournalcommentStatus > 0
                              ? getError(journalCommentController
                                  .getJournalcommentStatus)
                              : CustomScrollView(
                                  controller: _scrollController,
                                  slivers: [
                                    SliverToBoxAdapter(
                                      child: PostForComment(
                                        journalModel: widget._journalModel,
                                        index: widget.index,
                                      ),
                                    ),
                                    journalCommentController
                                                    .getJouranalsCommentModel
                                                    .value
                                                    .body !=
                                                null &&
                                            journalCommentController
                                                    .getJouranalsCommentModel
                                                    .value
                                                    .body!
                                                    .bestComment !=
                                                null
                                        ? SliverToBoxAdapter(child: Obx(() {
                                            return CommentBoxWidget(
                                              journalModel:
                                                  widget._journalModel!,
                                              isUserPost:
                                                  _isLoginedUserJournal!,
                                              // commentModel: Comments.fromJson(
                                              //     journalCommentController
                                              //         .getJouranalsCommentModel
                                              //         .value
                                              //         .toJson()),
                                              commentModel: Comments(
                                                commentBody:
                                                    journalCommentController
                                                        .getJouranalsCommentModel
                                                        .value
                                                        .body!
                                                        .bestComment!
                                                        .commentBody,
                                                commentBy:
                                                    journalCommentController
                                                        .getJouranalsCommentModel
                                                        .value
                                                        .body!
                                                        .bestComment!
                                                        .commentBy,
                                                commentDate:
                                                    journalCommentController
                                                        .getJouranalsCommentModel
                                                        .value
                                                        .body!
                                                        .bestComment!
                                                        .commentDate,
                                                commentOn:
                                                    journalCommentController
                                                        .getJouranalsCommentModel
                                                        .value
                                                        .body!
                                                        .bestComment!
                                                        .commentOn,
                                                commentTime:
                                                    journalCommentController
                                                        .getJouranalsCommentModel
                                                        .value
                                                        .body!
                                                        .bestComment!
                                                        .commentTime,
                                                commentUser:
                                                    journalCommentController
                                                        .getJouranalsCommentModel
                                                        .value
                                                        .body!
                                                        .bestComment!
                                                        .commentUser,
                                                createdAt:
                                                    journalCommentController
                                                        .getJouranalsCommentModel
                                                        .value
                                                        .body!
                                                        .bestComment!
                                                        .createdAt,
                                                likes: journalCommentController
                                                    .getJouranalsCommentModel
                                                    .value
                                                    .body!
                                                    .bestComment!
                                                    .likes,
                                                parentId:
                                                    journalCommentController
                                                        .getJouranalsCommentModel
                                                        .value
                                                        .body!
                                                        .bestComment!
                                                        .parentId,
                                                replyNum:
                                                    journalCommentController
                                                        .getJouranalsCommentModel
                                                        .value
                                                        .body!
                                                        .bestComment!
                                                        .replyNum,
                                                sId: journalCommentController
                                                    .getJouranalsCommentModel
                                                    .value
                                                    .body!
                                                    .bestComment!
                                                    .sId,
                                                user: journalCommentController
                                                    .getJouranalsCommentModel
                                                    .value
                                                    .body!
                                                    .bestComment!
                                                    .user,
                                              ),
                                              deleteComment: () async {
                                                await journalCommentController
                                                    .deleteComment(
                                                        journalId: widget
                                                                ._journalModel!
                                                                .id ??
                                                            '',
                                                        commentId:
                                                            journalCommentController
                                                                    .getJouranalsCommentModel
                                                                    .value
                                                                    .body!
                                                                    .bestComment!
                                                                    .sId ??
                                                                '',
                                                        isReply: false);
                                                getComments();
                                                _journalPageController
                                                    .journalsList.value
                                                    .forEach((element) {
                                                  if (element.id ==
                                                      widget
                                                          ._journalModel!.id) {
                                                    element.comments =
                                                        element.comments! - 1;
                                                  }
                                                });
                                                _journalPageController
                                                    .journalsList
                                                    .refresh();
                                                print("deleted");
                                              },
                                              makeBestComment: () {},
                                              bestComment:
                                                  journalCommentController
                                                      .getJouranalsCommentModel
                                                      .value
                                                      .body!
                                                      .bestComment,
                                              onReplyTapped: (id, name, sId) {
                                                journalCommentController
                                                    .isReplying.value = true;
                                                journalCommentController
                                                        .commentId =
                                                    journalCommentController
                                                        .getJouranalsCommentModel
                                                        .value
                                                        .body!
                                                        .bestComment!
                                                        .sId!;
                                                journalCommentController
                                                    .parentId = sId;
                                                journalCommentController
                                                    .repliedTo.value = name;
                                              },
                                              index: 0,
                                              onDeleteTapped: (String id,
                                                  bool? isReply) async {
                                                await journalCommentController
                                                    .deleteComment(
                                                        journalId: widget
                                                                ._journalModel!
                                                                .id ??
                                                            '',
                                                        commentId: id,
                                                        isReply:
                                                            isReply ?? true);
                                                getComments();
                                                _journalPageController
                                                    .journalsList.value
                                                    .forEach((element) {
                                                  if (element.id ==
                                                      widget
                                                          ._journalModel!.id) {
                                                    element.comments =
                                                        element.comments! - 1;
                                                  }
                                                });
                                                _journalPageController
                                                    .journalsList
                                                    .refresh();
                                                print("deleted");
                                              },
                                            );
                                          }))
                                        : SliverToBoxAdapter(),
                                    journalCommentController
                                            .commentList.isNotEmpty
                                        ? Obx(() {
                                            return SliverList(
                                                delegate:
                                                    SliverChildBuilderDelegate(
                                                        (_, index) =>
                                                            CommentBoxWidget(
                                                              deleteComment:
                                                                  () async {
                                                                await journalCommentController.deleteComment(
                                                                    journalId: widget
                                                                            ._journalModel!
                                                                            .id ??
                                                                        '',
                                                                    commentId: journalCommentController
                                                                            .commentList[
                                                                                index]
                                                                            .sId ??
                                                                        '',
                                                                    isReply:
                                                                        false);
                                                                getComments();
                                                                _journalPageController
                                                                    .journalsList
                                                                    .value
                                                                    .forEach(
                                                                        (element) {
                                                                  if (element
                                                                          .id ==
                                                                      widget
                                                                          ._journalModel!
                                                                          .id) {
                                                                    element.comments =
                                                                        element.comments! -
                                                                            1;
                                                                  }
                                                                });

                                                                _journalPageController
                                                                    .journalsList
                                                                    .refresh();
                                                                print(
                                                                    "deleted");
                                                              },
                                                              makeBestComment:
                                                                  () async {
                                                                await journalCommentController.makeBestComment(
                                                                    journalId: widget
                                                                            ._journalModel!
                                                                            .id ??
                                                                        '',
                                                                    commentId: journalCommentController
                                                                            .commentList[index]
                                                                            .sId ??
                                                                        '');
                                                              },
                                                              journalModel: widget
                                                                  ._journalModel!,
                                                              onReplyTapped:
                                                                  (id, name,
                                                                      sId) {
                                                                print(journalCommentController
                                                                    .isReplying
                                                                    .value);
                                                                journalCommentController
                                                                    .isReplying
                                                                    .value = true;
                                                                journalCommentController
                                                                        .commentId =
                                                                    journalCommentController
                                                                        .commentList[
                                                                            index]
                                                                        .sId!;
                                                                journalCommentController
                                                                    .repliedTo
                                                                    .value = name;
                                                                journalCommentController
                                                                        .parentId =
                                                                    sId;
                                                                _commentFocusnode
                                                                    .requestFocus();
                                                              },
                                                              commentModel:
                                                                  journalCommentController
                                                                          .commentList[
                                                                      index],
                                                              isUserPost:
                                                                  _isLoginedUserJournal ??
                                                                      false,
                                                              index: index,
                                                              onDeleteTapped:
                                                                  (String id,
                                                                      bool?
                                                                          isReply) async {
                                                                await journalCommentController.deleteComment(
                                                                    journalId: widget
                                                                            ._journalModel!
                                                                            .id ??
                                                                        '',
                                                                    commentId:
                                                                        id,
                                                                    isReply:
                                                                        isReply ??
                                                                            true);

                                                                if (isReply ==
                                                                    true) {
                                                                  print(
                                                                      'is reply true hai ye to zkkddncdcndsncdsndkndkn');
                                                                  journalCommentController.getReply(
                                                                      postId: journalCommentController
                                                                          .commentList[
                                                                              index]
                                                                          .sId!,
                                                                      pageNo: 1,
                                                                      index:
                                                                          index);
                                                                } else {
                                                                  print(
                                                                      'is reply false hai ye to zkkddncdcndsncdsndkndkn');
                                                                  // getComments();
                                                                  journalCommentController
                                                                      .commentList
                                                                      .removeAt(
                                                                          index);
                                                                  journalCommentController
                                                                      .commentList
                                                                      .refresh();
                                                                  _journalPageController
                                                                      .journalsList
                                                                      .value
                                                                      .forEach(
                                                                          (element) {
                                                                    if (element
                                                                            .id ==
                                                                        widget
                                                                            ._journalModel!
                                                                            .id) {
                                                                      element.comments =
                                                                          element.comments! -
                                                                              1;
                                                                    }
                                                                  });
                                                                  _journalPageController
                                                                      .journalsList
                                                                      .refresh();

                                                                  print(
                                                                      "deleted");
                                                                }
                                                              },
                                                            ),
                                                        childCount:
                                                            journalCommentController
                                                                .commentList
                                                                .length));
                                          })
                                        : SliverToBoxAdapter(),
                                    if (isFetchingMore)
                                      SliverToBoxAdapter(
                                        child: MyLoader(),
                                      )
                                  ],
                                )
                          : Center(
                              child: MyLoader(),
                            ))),
                  Container(
                    padding: EdgeInsets.only(left: 4.w),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: SolhColors.primary_green)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getAnonymousIcon(),
                        Container(height: 40, child: VerticalDivider()),
                        Expanded(
                          child: Obx(() => TextField(
                                controller: _commentEditingController,
                                focusNode: _commentFocusnode,
                                // autofocus: true,
                                decoration: InputDecoration(
                                  hintText:
                                      journalCommentController.isReplying.value
                                          ? 'Reply ...'
                                          : "Comment",
                                  border: InputBorder.none,
                                ),
                                minLines: 1,
                                maxLines: 6,
                              )),
                        ),
                        Obx((() => journalCommentController.isReplying.value
                            ? IconButton(
                                onPressed: () {
                                  journalCommentController.isReplying.value =
                                      false;
                                  journalCommentController.repliedTo.value = '';
                                },
                                icon: Icon(Icons.close))
                            : Container())),
                        _isLoading
                            ? Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 9, 12),
                                height: 8.w,
                                width: 8.w,
                                child: MyLoader(
                                  strokeWidth: 2.5,
                                ))
                            : Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: MaterialButton(
                                  //padding: EdgeInsets.all(2),
                                  highlightElevation: 0,
                                  minWidth: 0,
                                  height: 45,
                                  focusElevation: 0,
                                  elevation: 0,
                                  shape: CircleBorder(),
                                  color: Color(0xFF0F4F4F4),
                                  highlightColor: Colors.grey[400],
                                  onPressed: () async {
                                    if (_commentEditingController.text != '') {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      journalCommentController.isReplying.value
                                          ? await journalCommentController
                                              .addReply(
                                                  parentId:
                                                      journalCommentController
                                                          .commentId,
                                                  journalId:
                                                      widget._journalModel!.id!,
                                                  commentBody:
                                                      _commentEditingController
                                                          .text,
                                                  userId:
                                                      journalCommentController
                                                          .parentId,
                                                  index:
                                                      journalCommentController
                                                          .hiddenReplyList
                                                          .indexWhere(
                                                              (element) =>
                                                                  element ==
                                                                  true))
                                          : await journalCommentController
                                              .addComment(
                                                  journalId:
                                                      widget._journalModel!.id!,
                                                  commentBody:
                                                      _commentEditingController
                                                          .text);
                                      _commentEditingController.clear();
                                      _scrollController.jumpTo(_scrollController
                                          .position.maxScrollExtent);

                                      getComments(shouldRefresh: true, page: 1);
                                      _journalPageController.journalsList.value
                                          .forEach((element) {
                                        if (element.id ==
                                            widget._journalModel!.id) {
                                          element.comments =
                                              element.comments! + 1;
                                        }
                                      });
                                      _journalPageController.journalsList
                                          .refresh();
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  },

                                  child: Icon(
                                    Icons.send,
                                    size: 20,
                                    color: SolhColors.primary_green,
                                  ),
                                ),
                              )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> getComments({bool? shouldRefresh, int? page}) async {
    await journalCommentController.getJournalComment(
        postId: widget._journalModel!.id!,
        pageNo: pageNo,
        shouldRefresh: shouldRefresh,
        page: page);
  }

  getUserNameAndImage() {
    return Container(
      child: GestureDetector(
        onTap: () => widget._journalModel!.group != null &&
                _journalPageController.selectedGroupId.value.length == 0
            ? {
                Navigator.pushNamed(context, AppRoutes.groupDetails,
                    arguments: {
                      "group": GroupList(
                        sId: widget._journalModel!.group!.sId,
                        groupName: widget._journalModel!.group!.groupName,
                        groupMediaUrl: widget._journalModel!.group!.groupImage,
                      ),
                    }),
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
                    /* backgroundImage: widget._journalModel!.anonymousJournal ==
                                null &&
                            widget._journalModel!.postedBy!.anonymous == null
                        ? widget._journalModel!.group != null
                            ? CachedNetworkImageProvider(
                                widget._journalModel!.group!.groupImage ?? '')
                            : CachedNetworkImageProvider(widget._journalModel!
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
                            : CachedNetworkImageProvider(
                                widget._journalModel!.postedBy!.profilePicture!), */
                    backgroundImage: widget._journalModel!.anonymousJournal != null &&
                            widget._journalModel!.postedBy!.anonymous != null &&
                            widget._journalModel!.anonymousJournal!
                        ? widget._journalModel!.group != null &&
                                _journalPageController.selectedGroupId.value.length ==
                                    0
                            ? CachedNetworkImageProvider(
                                widget._journalModel!.group!.groupImage!)
                            : CachedNetworkImageProvider(widget._journalModel!
                                    .postedBy!.anonymous!.profilePicture ??
                                '')
                        : widget._journalModel!.group != null &&
                                _journalPageController.selectedGroupId.value.length ==
                                    0
                            ? CachedNetworkImageProvider(
                                widget._journalModel!.group!.groupImage!)
                            : widget._journalModel!.postedBy != null
                                ? widget._journalModel!.postedBy!.anonymous !=
                                            null &&
                                        widget._journalModel!.anonymousJournal!
                                    ? CachedNetworkImageProvider(widget
                                        ._journalModel!
                                        .postedBy!
                                        .profilePicture!)
                                    : CachedNetworkImageProvider(
                                        widget._journalModel!.postedBy!.profilePicture!)
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
                                                _journalPageController
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
                                                _journalPageController
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
                                        _journalPageController
                                                .selectedGroupId.value.length ==
                                            0
                                    ? Icon(
                                        CupertinoIcons.person_3_fill,
                                        color: Color(0xFFA6A6A6),
                                      )
                                    : Container(),
                                widget._journalModel!.postedBy!.isProvider! &&
                                        widget._journalModel!
                                                .anonymousJournal ==
                                            false &&
                                        widget._journalModel!.group == null
                                    ? SolhExpertBadge(
                                        usertype: 'Volunteer',
                                      )
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
                                          imageUrl: widget
                                                  ._journalModel!
                                                  .postedBy!
                                                  .anonymous!
                                                  .profilePicture ??
                                              '',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getError(int getJournalcommentStatus) {
    switch (getJournalcommentStatus) {
      case 404:
        return NotFoundPage();
      case 400:
        return NoInternetPage(
          onRetry: () {
            getComments();
          },
        );
      default:
        return Container();
    }
  }

  Widget getAnonymousIcon() {
    return Obx(
      () => profileController.myProfileModel.value.body != null
          ? GestureDetector(
              onTap: () {
                onSwapProfile();
              },
              child: Container(
                  height: 5.h,
                  width: 12.w,
                  child: Obx(() {
                    return GetNormalStack(
                      isAnonymousSelected:
                          journalCommentController.isAnonymousSelected.value,
                      userModel:
                          profileController.myProfileModel.value.body!.user,
                      onTapped: () {
                        onSwapProfile();
                      },
                      normalRadius:
                          journalCommentController.nomalProfileRadius.value,
                      anonRadius:
                          journalCommentController.anonymousProfileRadius.value,
                      anonTop: journalCommentController
                          .anonymousProfilePositionT.value,
                      anonLeft: journalCommentController
                          .anonymousProfilePositionL.value,
                      normalTop:
                          journalCommentController.nomalProfilePositionT.value,
                      normalLeft:
                          journalCommentController.nomalProfilePositionL.value,
                    );
                  })))
          : CircleAvatar(
              radius: journalCommentController.anonymousProfileRadius.value,
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(
                "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
              )),
    );
  }

  void onSwapProfile() {
    if (profileController.myProfileModel.value.body!.user!.anonymous != null) {
      journalCommentController.isAnonymousSelected.value =
          !journalCommentController.isAnonymousSelected.value;
      if (journalCommentController.isAnonymousSelected.value) {
        // if anonymous selected then bring anonymous to front and make it bigger radius,
        // Simply swap values of position and radius
        journalCommentController.nomalProfileRadius.value = 2.0.w;
        journalCommentController.anonymousProfileRadius.value = 4.w;
        journalCommentController.anonymousProfilePositionT.value = 2.0;
        journalCommentController.nomalProfilePositionT.value = 15.0;
        journalCommentController.anonymousProfilePositionL.value = 10.0;
        journalCommentController.nomalProfilePositionL.value = 2.0;
      } else {
        journalCommentController.nomalProfileRadius.value = 4.w;
        journalCommentController.anonymousProfileRadius.value = 2.0.w;
        journalCommentController.anonymousProfilePositionT.value = 15.0;
        journalCommentController.anonymousProfilePositionL.value = 2.0;
        journalCommentController.nomalProfilePositionT.value = 2.0;
        journalCommentController.nomalProfilePositionL.value = 10.0;
      }
    } else {
      openCreateAnonymousBottomSheet();
    }
  }

  void openCreateAnonymousBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => AnonymousBottomSheet(onTap: () async {
              await _anonController.createAnonProfile();
              await Get.find<ProfileController>().getMyProfile();
              Navigator.pop(context);
            }));
  }

  /* Widget getAnonymousIcon() {
    return Container(
      height: 50,
      width: 50,
      child: Stack(
        children: [
          Positioned(
            top: 15,
            left: 0,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(profileController
                              .myProfileModel
                              .value
                              .body!
                              .user!
                              .profilePicture ??
                          ''))),
            ),
          ),
          Positioned(
            top: 10,
            left: 20,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(profileController
                              .myProfileModel
                              .value
                              .body!
                              .user!
                              .anonymous!
                              .profilePicture ??
                          ''))),
            ),
          ),
        ],
      ),
    );
  } */
}

class CommentBoxWidget extends StatelessWidget {
  CommentBoxWidget({
    Key? key,
    required Journals journalModel,
    required bool isUserPost,
    required Comments? commentModel,
    required VoidCallback? deleteComment,
    required VoidCallback makeBestComment,
    BestComment? bestComment,
    required this.onReplyTapped,
    required this.index,
    required this.onDeleteTapped,
  })  : _commentModel = commentModel,
        _isUserPost = isUserPost,
        _journalModel = journalModel,
        _deleteComment = deleteComment,
        _makeBestComment = makeBestComment,
        _bestComment = bestComment,
        super(key: key);

  final VoidCallback? _deleteComment;
  final Journals _journalModel;
  final VoidCallback _makeBestComment;
  final Comments? _commentModel;
  final bool _isUserPost;
  final BestComment? _bestComment;
  final Function(String id, String userName, String userId) onReplyTapped;
  final Function(String id, bool? isReply) onDeleteTapped;
  final int index;
  final JournalCommentController journalCommentController = Get.find();
  final ConnectionController connectionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Column(
        children: [
          getCommentBody(_commentModel!, _bestComment, context, false),
          getCommentFooter(_bestComment != null ? _bestComment : _commentModel!,
              onReplyTapped, index, context),
          _bestComment != null
              ? _bestComment!.replyNum == 0
                  ? Container()
                  : getViewReplyBtn(index, _bestComment, context)
              : _commentModel!.replyNum == 0
                  ? Container()
                  : getViewReplyBtn(index, _bestComment, context),
          _bestComment != null
              ? Obx(() {
                  return journalCommentController.bestCommentReplyList.length >
                              0 &&
                          journalCommentController.hiddenBestCommentReply.value
                      ? getReplyView(
                          journalCommentController.bestCommentReplyList.value,
                          onReplyTapped,
                          context)
                      : Container();
                })
              : Obx(() {
                  return journalCommentController
                                  .repliesList.value[index].length >
                              0 &&
                          journalCommentController.hiddenReplyList[index]
                      ? getReplyView(
                          journalCommentController.repliesList.value[index],
                          onReplyTapped,
                          context)
                      : Container();
                })
        ],
      ),
    );
  }

  Widget getCommentBody(Comments commentModel, BestComment? bestComment,
      BuildContext context, bool? isReply) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[300],
          backgroundImage: CachedNetworkImageProvider(
            commentModel.user != null
                ? commentModel.user!.profilePicture!
                : bestComment!.user!.profilePicture!,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            decoration: BoxDecoration(
              color: Color.fromRGBO(245, 245, 245, 0.75),
              borderRadius: BorderRadius.circular(10),
            ),

            // child: Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Row(
            //               children: [
            //                 CircleAvatar(
            //                   backgroundImage: CachedNetworkImageProvider(
            //                     _commentModel!.user!.profilePicture!,
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 6.h,
            //                   width: 2.w,
            //                 ),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Row(
            //                       children: [
            //                         Text(
            //                           _commentModel!.user!.name!,
            //                           style: TextStyle(color: Color(0xFF666666)),
            //                         ),
            //                         SizedBox(
            //                           width: 1.w,
            //                         ),
            //                         SolhExpertBadge()
            //                       ],
            //                     ),
            //                     Text(
            //                       timeago.format(
            //                           DateTime.parse(_commentModel!.createdAt!)),
            //                       style: TextStyle(color: Color(0xFF666666)),
            //                     )
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //         Divider(),
            //         Container(
            //           padding: EdgeInsets.all(2.w),
            //           child: Text(
            //             _commentModel!.commentBody!,
            //             style: TextStyle(height: 1.4, color: Color(0xFF222222)),
            //           ),
            //         ),
            //       ],
            //     ),
            //     if (_commentModel!.user!.uid ==
            //             FirebaseAuth.instance.currentUser!.uid ||
            //         _journalModel.postedBy!.uid ==
            //             FirebaseAuth.instance.currentUser!.uid)
            //       CommentMenuButton(
            //           makeBestComment: _makeBestComment,
            //           commentId: _commentModel!.sId!,
            //           journalModel: _journalModel,
            //           deleteJournal: _deleteComment),
            //   ],
            // ),

            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                commentModel.user != null
                                    ? commentModel.user!.name!
                                    : bestComment!.user!.name ?? '',
                                style: TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              //SolhExpertBadge(),
                            ],
                          ),
                          Text(
                            timeago.format(DateTime.parse(
                                commentModel.createdAt != null
                                    ? commentModel.createdAt!
                                    : bestComment!.createdAt ?? '')),
                            style: TextStyle(color: Color(0xFF666666)),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      bestComment != null
                          ? bestComment.sId == commentModel.sId
                              ? Chip(
                                  backgroundColor: SolhColors.primary_green,
                                  label: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: SolhColors.white,
                                      ),
                                      Text(
                                        'Best',
                                        style:
                                            TextStyle(color: SolhColors.white),
                                      ),
                                    ],
                                  ))
                              : SizedBox()
                          : SizedBox(),
                      if (commentModel.user!.uid ==
                              FirebaseAuth.instance.currentUser!.uid ||
                          _journalModel.postedBy != null &&
                              _journalModel.postedBy!.uid ==
                                  FirebaseAuth.instance.currentUser!.uid)
                        CommentMenuButton(
                          makeBestComment: _makeBestComment,
                          commentId: commentModel.sId!,
                          journalModel: _journalModel,
                          deleteJournal: onDeleteTapped,
                          isReply: isReply,
                        ),
                    ],
                  ),
                  Divider(),
                  RichText(
                    text: TextSpan(
                      children: [
                        commentModel.replyTo != null
                            ? TextSpan(
                                text: commentModel.replyTo!.name != null
                                    ? '@${commentModel.replyTo!.name}'
                                    : '',
                                style: TextStyle(
                                    height: 1.4,
                                    color: SolhColors.primary_green,
                                    fontSize: 14),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    connectionController.getUserAnalytics(
                                        commentModel.replyTo!.sId!);
                                    Navigator.pushNamed(
                                        context, AppRoutes.userProfile,
                                        arguments: {
                                          "uid":
                                              commentModel.replyTo!.uid ?? '',
                                          "sId": commentModel.replyTo!.sId!
                                        });
                                  },
                              )
                            : TextSpan(),
                        TextSpan(
                          text: ' ${commentModel.commentBody}',
                          style: TextStyle(
                              height: 1.4,
                              color: Color(0xFF222222),
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getCommentFooter(
    dynamic commentModel,
    Function(String id, String userName, String userId) onReplyTapped,
    int index,
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.find<JournalPageController>()
                  .getUsersLikedPost(commentModel.sId ?? '', 1);
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: LikesModalSheet(
                        onTap: (value) async {
                          String message =
                              await journalCommentController.likeComment(
                                  commentId: commentModel.sId ?? '',
                                  reaction: value);
                          if (message == 'Liked comment successfully') {
                            journalCommentController.commentList[index].likes =
                                journalCommentController
                                        .commentList[index].likes! +
                                    1;
                            journalCommentController
                                .commentList[index].isLiked = true;
                            journalCommentController.commentList.refresh();
                            FirebaseAnalytics.instance.logEvent(
                                name: 'LikeTapped',
                                parameters: {'Page': 'JournalTile'});
                          } else {
                            Utility.showToast(message);
                          }
                          Navigator.of(context).pop();
                          // journalCommentController.likePost(
                          //     journalId: widget._journalModel!.id ?? '',
                          //     reaction: value);
                          // journalPageController.journalsList[widget.index]
                          //     .likes = journalPageController
                          //         .journalsList[widget.index].likes! +
                          //     1;
                          // journalPageController.journalsList.refresh();
                          // Navigator.of(context).pop();
                        },
                      ),
                    );
                  });
            },
            /* onTap: () async {
              bool isTrue = await journalCommentController.likeComment(
                  commentId: commentModel.sId ?? '');
              if (isTrue) {
                journalCommentController.getJouranalsCommentModel.value
                    .body!.comments![index].likes = journalCommentController
                        .getJouranalsCommentModel
                        .value
                        .body!
                        .comments![index]
                        .likes! +
                    1;
                journalCommentController.getJouranalsCommentModel.refresh();
              }
            }, */
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (commentModel.isLiked != null)
                  SvgPicture.asset(commentModel.isLiked
                      ? 'assets/images/reactions_liked.svg'
                      : 'assets/images/reactions.svg'),
                SizedBox(
                  width: 1.w,
                ),
                Text(
                  commentModel.likes != null
                      ? commentModel.likes!.toString()
                      : '0',
                  style: TextStyle(
                    color: SolhColors.primary_green,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.reply_outlined),
                onPressed: () {
                  print(commentModel!.user!.id!);
                  onReplyTapped(commentModel!.sId!, commentModel!.user!.name!,
                      commentModel!.user!.id!);
                },
                color: SolhColors.primary_green,
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                commentModel!.replyNum != null
                    ? commentModel!.replyNum!.toString()
                    : '0',
                style: TextStyle(
                  color: SolhColors.primary_green,
                ),
              ),
            ],
          ),
          // if (_isUserPost)
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    commentModel!.user!.id != null
                        ? await connectionController.addConnection(
                            commentModel!.user!.id!,
                          )
                        : null;
                  },
                  icon: SvgPicture.asset('assets/images/connect.svg')),
            ],
          )
        ],
      ),
    );
  }

  Widget getViewReplyBtn(
      int index, BestComment? bestComment, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            if (bestComment == null) {
              journalCommentController.hiddenReplyList[index] =
                  !journalCommentController.hiddenReplyList[index];
              journalCommentController.hiddenReplyList.refresh();
            } else {
              journalCommentController.hiddenBestCommentReply.value =
                  !journalCommentController.hiddenBestCommentReply.value;
            }
            journalCommentController.getReply(
                postId: _commentModel!.sId!,
                pageNo: 1,
                index: _bestComment != null ? null : index);
          },
          child: Row(
            children: [
              Obx(() => Text(
                    bestComment != null
                        ? !journalCommentController.hiddenBestCommentReply.value
                            ? 'Replies'
                            : 'Replies'
                        : !journalCommentController.hiddenReplyList[index]
                            ? 'Replies'
                            : 'Replies',
                    style: TextStyle(
                      color: SolhColors.primary_green,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              SizedBox(
                width: 1.w,
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: SolhColors.primary_green,
                size: 17,
              ),
            ],
          ),
        ),
        // SizedBox(
        //   width: 5.w,
        // ),
        // InkWell(
        //   onTap: () {
        //     Get.find<JournalPageController>()
        //         .getUsersLikedPost(_commentModel!.sId ?? '', 1);
        //     showModalBottomSheet(
        //         context: context,
        //         builder: (context) {
        //           return Container(
        //             child: LikesModalSheet(
        //               onTap: (value) {
        //                 journalCommentController.likePost(
        //                     journalId: widget._journalModel!.id ?? '',
        //                     reaction: value);
        //                 journalPageController.journalsList[widget.index].likes =
        //                     journalPageController
        //                             .journalsList[widget.index].likes! +
        //                         1;
        //                 journalPageController.journalsList.refresh();
        //                 Navigator.of(context).pop();
        //               },
        //             ),
        //           );
        //         });
        //   },
        //   child: Row(
        //     children: [
        //       Text(
        //         'Likes',
        //         style: TextStyle(
        //           color: SolhColors.primary_green,
        //           fontSize: 12,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //       SizedBox(
        //         width: 1.w,
        //       ),
        //       Icon(
        //         Icons.keyboard_arrow_down_rounded,
        //         color: SolhColors.primary_green,
        //         size: 17,
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }

  Widget getReplyView(
      List<dynamic> list,
      Function(String id, String username, String userId) onReplyTapped,
      BuildContext context) {
    return list.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: list
                  .map((element) => Column(
                        children: [
                          getCommentBody(element, null, context, true),
                          getCommentFooter(
                              element, onReplyTapped, index, context),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ))
                  .toList(),
            ),
          )
        : SizedBox();
  }

  Widget viewLikesBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Likes'),
        SizedBox(
          width: 1.w,
        ),
        Icon(
          Icons.keyboard_arrow_down_rounded,
          color: SolhColors.primary_green,
          size: 17,
        ),
      ],
    );
  }
}

class PostForComment extends StatefulWidget {
  PostForComment({
    Key? key,
    required Journals? journalModel,
    required this.index,
  })  : _journalModel = journalModel,
        super(key: key);

  //final CommentModel? _bestComment;
  final Journals? _journalModel;
  final int index;

  @override
  State<PostForComment> createState() => _PostForCommentState();
}

class _PostForCommentState extends State<PostForComment> {
  final JournalPageController _journalPageController = Get.find();
  final ConnectionController connectionController = ConnectionController();
  JournalCommentController journalCommentController = Get.find();
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget._journalModel!.feelings != null
                      ? widget._journalModel!.feelings!.isNotEmpty
                          ? Text(
                              "Feeling " +
                                  widget
                                      ._journalModel!.feelings![0].feelingName!,
                              style: SolhTextStyles
                                  .JournalingDescriptionReadMoreText,
                            )
                          : Container()
                      : Container(),
                  ReadMoreText(
                    widget._journalModel!.description ?? '',
                    style: SolhTextStyles.JournalingDescriptionText,
                    trimCollapsedText: ' Read more'.tr,
                    trimExpandedText: ' less',
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                  ),
                  getMedia(widget._journalModel, context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getLikeBtn(),
                      getCommentsBtn(),
                      getConnectBtn(connectionController),
                      //getShareBtn(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        Divider(),
        Row(
          children: [
            Text(
              "Comments".tr,
              style: SolhTextStyles.mostUpvoted,
            ),
            // Icon(CupertinoIcons.chevron_down, size: 16, color: SolhColors.green)
          ],
        ),
        // if (_bestComment != null)
        //   BestCommentWidget(
        //     commentModel: _bestComment,
        //   )
      ],
    );
  }

  Widget getLikeBtn() {
    return InkWell(
      /* onTap: () async {
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
            }, */
      onTap: () async {
        if (_journalPageController.journalsList[widget.index].isLiked ==
            false) {
          _journalPageController.journalsList[widget.index].likes =
              _journalPageController.journalsList[widget.index].likes! + 1;
          _journalPageController.journalsList[widget.index].isLiked = true;
          _journalPageController.journalsList.refresh();
        }
        String message = await journalCommentController.likePost(
            journalId: widget._journalModel!.id ?? '',
            reaction: '63bd50068bc9de38d95671a8');
        if (message != 'journal liked successfully' &&
            message != "Already liked the journal") {
          _journalPageController.journalsList[widget.index].likes =
              _journalPageController.journalsList[widget.index].likes! - 1;
          _journalPageController.journalsList[widget.index].isLiked = false;
          _journalPageController.journalsList.refresh();
          FirebaseAnalytics.instance.logEvent(
              name: 'LikeTapped', parameters: {'Page': 'JournalTile'});
        } else {
          Utility.showToast(message);
        }
      },
      onLongPress: () {
        _journalPageController.getUsersLikedPost(
            widget._journalModel!.id ?? '', 1);
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                child: LikesModalSheet(
                  onTap: (value) async {
                    Navigator.of(context).pop();
                    String message = await journalCommentController.likePost(
                        journalId: widget._journalModel!.id ?? '',
                        reaction: value);
                    if (message == 'journal liked successfully') {
                      _journalPageController.journalsList[widget.index].likes =
                          _journalPageController
                                  .journalsList[widget.index].likes! +
                              1;
                      _journalPageController
                          .journalsList[widget.index].isLiked = true;
                      _journalPageController.journalsList.refresh();
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
                  _journalPageController.journalsList[widget.index].isLiked!
                      ? 'assets/images/reactions_liked.svg'
                      : 'assets/images/reactions.svg')),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 40,
                ),
                child: Obx(() {
                  return Text(
                    _journalPageController.journalsList[widget.index].likes
                        .toString(),
                    style: SolhTextStyles.GreenBorderButtonText,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
    /* return Row(
      children: [
        IconButton(onPressed: () {
          //// this is for doing like or unlike
          !_journalPageController.journalsList[widget.index].isLiked!
              ? _likeJournal()
              : _unlikeJournal();
          ///////////////////////////////////////////////
          /// below is for checking if liked by me or not
          _journalPageController.journalsList[widget.index].isLiked =
              !_journalPageController.journalsList[widget.index].isLiked!;

          ///////
          /// below is for updating the like number
          _journalPageController.journalsList[widget.index].isLiked!
              ? _journalPageController.journalsList[widget.index].likes =
                  _journalPageController.journalsList[widget.index].likes! + 1
              : _journalPageController.journalsList[widget.index].likes =
                  _journalPageController.journalsList[widget.index].likes! - 1;

          _journalPageController.journalsList.refresh();
        }, icon: Obx(() {
          return Icon(
            !_journalPageController.journalsList[widget.index].isLiked!
                ? Icons.favorite_border_outlined
                : Icons.favorite_rounded,
            color: SolhColors.primary_green,
            size: 16,
          );
        })),
        Obx(() {
          return Text(
            _journalPageController.journalsList.value[widget.index].likes!
                .toString(),
            style: TextStyle(color: Colors.grey),
          );
        })
      ],
    ); */
  }

  Widget getCommentsBtn() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/icons/journaling/post-comment.svg",
            width: 17,
            height: 17,
            color: SolhColors.primary_green,
          ),
        ),
        Text(
          widget._journalModel!.comments.toString(),
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget getConnectBtn(connectionController) {
    var isGroupJoined = false;
    return Row(
      children: [
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/images/connect.svg')),
        InkWell(
          onTap: () async {
            widget._journalModel!.group != null
                ? {
                    Navigator.pushNamed(context, AppRoutes.groupDetails,
                        arguments: {
                          "group": GroupList(
                            sId: widget._journalModel!.group!.sId,
                            groupName: widget._journalModel!.group!.groupName,
                            groupMediaUrl:
                                widget._journalModel!.group!.groupImage,
                          ),
                        }),
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return GroupDetailsPage(
                    //     ///// this case is for group journal
                    //     group: GroupList(
                    //       sId: widget._journalModel!.group!.sId,
                    //       groupName: widget._journalModel!.group!.groupName,
                    //       groupMediaUrl:
                    //           widget._journalModel!.group!.groupImage,
                    //     ),
                    //   );
                    // }))
                  }
                : await connectionController.addConnection(
                    widget._journalModel!.postedBy!.sId!,
                  );
          },
          child: Text(
            widget._journalModel!.group != null
                ? isGroupJoined
                    ? 'Go To Group'
                    : 'join'
                : "Connect",
            style: SolhTextStyles.GreenBorderButtonText,
          ),
        ),
      ],
    );
  }

  Widget getShareBtn() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.share,
        color: Colors.grey,
        size: 16,
      ),
    );
  }

  Future<void> _likeJournal() async {
    setState(() {
      _isLiked = true;
    });
    var response = await Network.makeHttpPostRequestWithToken(
        url: "${APIConstants.api}/api/like-journal",
        body: {"post": widget._journalModel!.id});
    if (response["status"] == false)
      setState(() {
        _isLiked = false;
      });
    //return (response["status"]);
  }

  Future<bool> _unlikeJournal() async {
    var response = await Network.makeHttpDeleteRequestWithToken(
      body: {"postId": widget._journalModel!.id},
      url: "${APIConstants.api}/api/unlike-journal",
    );
    print(response);
    return (response["status"]);
  }
}

class BestCommentWidget extends StatelessWidget {
  const BestCommentWidget({
    Key? key,
    required CommentModel? commentModel,
  })  : _commentModel = commentModel,
        super(key: key);

  final CommentModel? _commentModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.5.h),
      padding: EdgeInsets.symmetric(vertical: 0.75.h),
      color: Color.fromRGBO(245, 245, 245, 0.75),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        _commentModel!.user.profilePicture),
                  ),
                  SizedBox(
                    height: 6.h,
                    width: 2.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_commentModel!.user.name),
                      Text(timeago
                          .format(DateTime.parse(_commentModel!.createdAt)))
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                    decoration: BoxDecoration(
                        color: SolhColors.primary_green,
                        borderRadius: BorderRadius.circular(25)),
                    child: Row(
                      children: [
                        Text(
                          "Best  ",
                          style: SolhTextStyles.GreenButtonText,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 13,
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
                color: SolhColors.primary_green,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Text(
              _commentModel!.commentBody,
              style: TextStyle(height: 1.4, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

getMedia(journalModel, context) {
  return journalModel.mediaUrl != null && journalModel.mediaUrl != ''
      ?
      //// For Video player ////
      journalModel.mediaType == 'video/mp4'
          ?
          // ? InkWell(
          //     onTap: () {
          //       widget.isMyJournal
          //           ? journalPageController.playMyPostVideo(
          //               widget.index,
          //             )
          //           : journalPageController.playVideo(
          //               widget.index,
          //             );
          //       isMyJournal
          //           ? journalPageController.myVideoPlayerControllers.refresh()
          //           : journalPageController.videoPlayerController.refresh();
          //     },
          //     child: Stack(
          //       children: [
          //         Container(
          //           height: MediaQuery.of(context).size.width,
          //           child: VideoPlayer(
          //             widget.isMyJournal
          //                 ? journalPageController.myVideoPlayerControllers
          //                     .value[widget.index][widget.index]
          //                 : journalPageController.videoPlayerController
          //                     .value[widget.index][widget.index],
          //           ),
          //         ),
          //         Obx(() {
          //           return journalPageController
          //                       .videoPlayerController
          //                       .value[widget.index][widget.index]!
          //                       .value
          //                       .isPlaying ||
          //                   isMyJournal &&
          //                       !journalPageController
          //                           .myVideoPlayerControllers
          //                           .value[widget.index][widget.index]!
          //                           .value
          //                           .isPlaying
          //               ? getBlackOverlay(context)
          //               : Container();
          //         }),
          //         Obx(() {
          //           return !journalPageController
          //                       .videoPlayerController
          //                       .value[widget.index][widget.index]!
          //                       .value
          //                       .isPlaying ||

          //                       journalPageController
          //                           .myVideoPlayerControllers
          //                           .value[widget.index][widget.index]!
          //                           .value
          //                           .isPlaying
          //               ? Positioned(
          //                   bottom: MediaQuery.of(context).size.height / 5,
          //                   left: MediaQuery.of(context).size.width / 2 -
          //                       MediaQuery.of(context).size.width / 10,
          //                   child: IconButton(
          //                     onPressed: () {
          //                       widget.isMyJournal
          //                           ? journalPageController.playMyPostVideo(
          //                               widget.index,
          //                             )
          //                           : journalPageController.playVideo(
          //                               widget.index,
          //                             );
          //                       widget.isMyJournal
          //                           ? journalPageController
          //                               .myVideoPlayerControllers
          //                               .refresh()
          //                           : journalPageController
          //                               .videoPlayerController
          //                               .refresh();
          //                     },
          //                     icon: Image.asset(
          //                       'assets/images/play_icon.png',
          //                       fit: BoxFit.fill,
          //                     ),
          //                     iconSize: MediaQuery.of(context).size.width / 8,
          //                     color: SolhColors.green,
          //                   ),
          //                 )
          //               : Container();
          //         }),
          //       ],
          //     ),
          //   )
          ///// Below for image only
          Container()
          : Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey.shade300)),
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 80,
              ),
              child: CachedNetworkImage(
                imageUrl: journalModel.mediaUrl.toString(),
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => getShimmer(context),
                errorWidget: (context, url, error) => Center(
                  child: Image.asset('assets/images/no-image-available.png'),
                ),
              ),
            )
      : Container(
          height: 1.h,
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
