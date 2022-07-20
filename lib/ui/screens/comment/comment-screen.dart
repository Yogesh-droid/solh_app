import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/journals/journal_comment_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/model/comment.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/model/journals/get_jouranal_comment_model.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/groups/group_detail.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../journaling/widgets/comment_menu_btn.dart';

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
  JournalPageController _journalPageController = Get.find();
  bool? _isLoginedUserJournal;

  JournalCommentController journalCommentController = Get.find();
  final FocusNode _commentFocusnode = FocusNode();
  final TextEditingController _commentEditingController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    //commentsBloc.getcommentsSnapshot(widget._journalModel!.id ?? '');
    getComments();
    if (_isLoginedUserJournal = widget._journalModel!.postedBy != null) {
      _isLoginedUserJournal = widget._journalModel!.postedBy!.uid ==
          FirebaseAuth.instance.currentUser!.uid;
    }
    journalCommentController.repliedTo.value = '';
    journalCommentController.isReplying.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
          title: Text(
            "Comments",
            style: SolhTextStyles.AppBarText,
          ),
          isLandingScreen: false,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
            child: Column(
              children: [
                Expanded(
                    child: Obx(() => !journalCommentController.isLoading.value
                        ? CustomScrollView(
                            controller: _scrollController,
                            slivers: [
                              SliverToBoxAdapter(
                                child: PostForComment(
                                  journalModel: widget._journalModel,
                                  index: widget.index,
                                  //bestComment: commentsBloc.getBestComment,
                                ),
                              ),
                              journalCommentController.getJouranalsCommentModel
                                          .value.bestComment !=
                                      null
                                  ? SliverToBoxAdapter(
                                      child: CommentBoxWidget(
                                        journalModel: widget._journalModel!,
                                        isUserPost: _isLoginedUserJournal!,
                                        commentModel: Comments(
                                          commentBody: journalCommentController
                                              .getJouranalsCommentModel
                                              .value
                                              .bestComment!
                                              .commentBody,
                                          commentBy: journalCommentController
                                              .getJouranalsCommentModel
                                              .value
                                              .bestComment!
                                              .commentBy,
                                          commentDate: journalCommentController
                                              .getJouranalsCommentModel
                                              .value
                                              .bestComment!
                                              .commentDate,
                                          commentOn: journalCommentController
                                              .getJouranalsCommentModel
                                              .value
                                              .bestComment!
                                              .commentOn,
                                          commentTime: journalCommentController
                                              .getJouranalsCommentModel
                                              .value
                                              .bestComment!
                                              .commentTime,
                                          commentUser: journalCommentController
                                              .getJouranalsCommentModel
                                              .value
                                              .bestComment!
                                              .commentUser,
                                          createdAt: journalCommentController
                                              .getJouranalsCommentModel
                                              .value
                                              .bestComment!
                                              .createdAt,
                                          likes: journalCommentController
                                              .getJouranalsCommentModel
                                              .value
                                              .bestComment!
                                              .likes,
                                          parentId: journalCommentController
                                              .getJouranalsCommentModel
                                              .value
                                              .bestComment!
                                              .parentId,
                                          replyNum: journalCommentController
                                              .getJouranalsCommentModel
                                              .value
                                              .bestComment!
                                              .replyNum,
                                          sId: journalCommentController
                                              .getJouranalsCommentModel
                                              .value
                                              .bestComment!
                                              .sId,
                                          user: journalCommentController
                                              .getJouranalsCommentModel
                                              .value
                                              .bestComment!
                                              .user,
                                        ),
                                        deleteComment: () async {
                                          await journalCommentController
                                              .deleteComment(
                                                  journalId: widget
                                                          ._journalModel!.id ??
                                                      '',
                                                  commentId:
                                                      journalCommentController
                                                              .getJouranalsCommentModel
                                                              .value
                                                              .bestComment!
                                                              .sId ??
                                                          '',
                                                  isReply: false);
                                          getComments();
                                          _journalPageController
                                              .journalsList.value
                                              .forEach((element) {
                                            if (element.id ==
                                                widget._journalModel!.id) {
                                              element.comments =
                                                  element.comments! - 1;
                                            }
                                          });
                                          _journalPageController.journalsList
                                              .refresh();
                                          print("deleted");
                                        },
                                        makeBestComment: () {},
                                        bestComment: journalCommentController
                                            .getJouranalsCommentModel
                                            .value
                                            .bestComment,
                                        onReplyTapped: (id, name, sId) {
                                          journalCommentController
                                              .isReplying.value = true;
                                          journalCommentController.commentId =
                                              journalCommentController
                                                  .getJouranalsCommentModel
                                                  .value
                                                  .bestComment!
                                                  .sId!;
                                          journalCommentController.parentId =
                                              sId;
                                          journalCommentController
                                              .repliedTo.value = name;
                                        },
                                        index: 0,
                                        onDeleteTapped:
                                            (String id, bool? isReply) async {
                                          await journalCommentController
                                              .deleteComment(
                                                  journalId: widget
                                                          ._journalModel!.id ??
                                                      '',
                                                  commentId: id,
                                                  isReply: isReply ?? true);
                                          getComments();
                                          _journalPageController
                                              .journalsList.value
                                              .forEach((element) {
                                            if (element.id ==
                                                widget._journalModel!.id) {
                                              element.comments =
                                                  element.comments! - 1;
                                            }
                                          });
                                          _journalPageController.journalsList
                                              .refresh();
                                          print("deleted");
                                        },
                                      ),
                                    )
                                  : SliverToBoxAdapter(),
                              journalCommentController.getJouranalsCommentModel
                                      .value.comments!.isNotEmpty
                                  ? SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                          (_, index) => CommentBoxWidget(
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
                                                                      .comments![
                                                                          index]
                                                                      .sId ??
                                                                  '',
                                                          isReply: false);
                                                  getComments();
                                                  _journalPageController
                                                      .journalsList.value
                                                      .forEach((element) {
                                                    if (element.id ==
                                                        widget._journalModel!
                                                            .id) {
                                                      element.comments =
                                                          element.comments! - 1;
                                                    }
                                                  });

                                                  _journalPageController
                                                      .journalsList
                                                      .refresh();
                                                  print("deleted");
                                                },
                                                makeBestComment: () async {
                                                  await journalCommentController
                                                      .makeBestComment(
                                                          journalId: widget
                                                                  ._journalModel!
                                                                  .id ??
                                                              '',
                                                          commentId:
                                                              journalCommentController
                                                                      .getJouranalsCommentModel
                                                                      .value
                                                                      .comments![
                                                                          index]
                                                                      .sId ??
                                                                  '');
                                                },
                                                journalModel:
                                                    widget._journalModel!,
                                                onReplyTapped: (id, name, sId) {
                                                  print(id);
                                                  print(journalCommentController
                                                      .isReplying.value);
                                                  journalCommentController
                                                      .isReplying.value = true;
                                                  journalCommentController
                                                          .commentId =
                                                      journalCommentController
                                                          .getJouranalsCommentModel
                                                          .value
                                                          .comments![index]
                                                          .sId!;
                                                  journalCommentController
                                                      .repliedTo.value = name;
                                                  journalCommentController
                                                      .parentId = sId;
                                                },
                                                commentModel:
                                                    journalCommentController
                                                        .getJouranalsCommentModel
                                                        .value
                                                        .comments![index],
                                                isUserPost:
                                                    _isLoginedUserJournal ??
                                                        false,
                                                index: index,
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

                                                  if (isReply == true) {
                                                    print(
                                                        'is reply true hai ye to zkkddncdcndsncdsndkndkn');
                                                    journalCommentController.getReply(
                                                        postId: journalCommentController
                                                            .getJouranalsCommentModel
                                                            .value
                                                            .comments![index]
                                                            .sId!,
                                                        pageNo: 1,
                                                        index: index);
                                                  } else {
                                                    print(
                                                        'is reply false hai ye to zkkddncdcndsncdsndkndkn');
                                                    //getComments();
                                                    _journalPageController
                                                        .journalsList.value
                                                        .forEach((element) {
                                                      if (element.id ==
                                                          widget._journalModel!
                                                              .id) {
                                                        element.comments =
                                                            element.comments! -
                                                                1;
                                                      }
                                                    });
                                                    _journalPageController
                                                        .journalsList
                                                        .refresh();

                                                    print("deleted");
                                                  }
                                                },
                                              ),
                                          childCount: journalCommentController
                                              .getJouranalsCommentModel
                                              .value
                                              .comments!
                                              .length))
                                  : SliverToBoxAdapter(),
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
                      border: Border.all(color: SolhColors.green)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /////  this is the comment for mention user in reply //////////////
                      // Obx(() =>
                      //     journalCommentController.repliedTo.value.isNotEmpty
                      //         ? Align(
                      //             alignment: Alignment.topLeft,
                      //             // child: MaterialButton(
                      //             //   onPressed: () {},
                      //             //   child: Text(
                      //             //     journalCommentController.repliedTo.value,
                      //             //     style: TextStyle(color: Colors.blueAccent),
                      //             //   ),
                      //             // ),
                      //             child: RichText(
                      //               text: TextSpan(),
                      //             ),
                      //           )
                      //         : SizedBox()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Obx(() => TextField(
                                  controller: _commentEditingController,
                                  focusNode: _commentFocusnode,
                                  // autofocus: true,
                                  decoration: InputDecoration(
                                    hintText: journalCommentController
                                            .isReplying.value
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
                                    journalCommentController.repliedTo.value =
                                        '';
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
                                      if (_commentEditingController.text !=
                                          '') {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        journalCommentController.isReplying.value
                                            ? await journalCommentController
                                                .addReply(
                                                    parentId:
                                                        journalCommentController
                                                            .commentId,
                                                    journalId: widget
                                                        ._journalModel!.id!,
                                                    commentBody:
                                                        _commentEditingController
                                                            .text,
                                                    userId:
                                                        journalCommentController
                                                            .parentId,
                                                    index: journalCommentController
                                                        .hiddenReplyList
                                                        .indexWhere((element) =>
                                                            element == true))
                                            : await journalCommentController
                                                .addComment(
                                                    journalId: widget
                                                        ._journalModel!.id!,
                                                    commentBody:
                                                        _commentEditingController
                                                            .text);
                                        _commentEditingController.clear();
                                        _scrollController.jumpTo(
                                            _scrollController
                                                .position.maxScrollExtent);

                                        getComments();
                                        _journalPageController
                                            .journalsList.value
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
                                      color: SolhColors.green,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> getComments() async {
    await journalCommentController.getJournalComment(
        postId: widget._journalModel!.id!, pageNo: 1);
  }
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
              onReplyTapped),
          _bestComment != null
              ? _bestComment!.replyNum == 0
                  ? Container()
                  : getViewReplyBtn(index, _bestComment)
              : _commentModel!.replyNum == 0
                  ? Container()
                  : getViewReplyBtn(index, _bestComment),
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
            commentModel.user![0].profilePicture!,
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
                                commentModel.user![0].name!,
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
                            timeago.format(
                                DateTime.parse(commentModel.createdAt!)),
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
                                  backgroundColor: SolhColors.green,
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
                      if (commentModel.user![0].uid ==
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
                                    color: SolhColors.green,
                                    fontSize: 14),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    connectionController.getUserAnalytics(
                                        commentModel.replyTo!.sId!);

                                    AutoRouter.of(context).push(
                                        ConnectScreenRouter(
                                            uid:
                                                commentModel.replyTo!.uid ?? '',
                                            sId: commentModel.replyTo!.sId ??
                                                ''));
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
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.thumb_up_outlined,
                  color: SolhColors.green,
                  size: 17,
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                commentModel.likes != null
                    ? commentModel.likes!.toString()
                    : '0',
                style: TextStyle(
                  color: SolhColors.green,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.reply_outlined),
                onPressed: () {
                  onReplyTapped(
                      commentModel!.sId!,
                      commentModel!.user![0].name!,
                      commentModel!.user![0].sId!);
                },
                color: SolhColors.green,
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                commentModel!.replyNum != null
                    ? commentModel!.replyNum!.toString()
                    : '0',
                style: TextStyle(
                  color: SolhColors.green,
                ),
              ),
            ],
          ),
          // if (_isUserPost)
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/icons/journaling/post-connect.svg",
                  width: 17,
                  height: 17,
                  color: SolhColors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getViewReplyBtn(int index, BestComment? bestComment) {
    // if (_commentModel!.replies!.length == 0) {
    //   return SizedBox();
    // }

    return InkWell(
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(() => Text(
                bestComment != null
                    ? !journalCommentController.hiddenBestCommentReply.value
                        ? 'View replies'
                        : 'Hide replies'
                    : !journalCommentController.hiddenReplyList[index]
                        ? 'View replies'
                        : 'Hide replies',
                style: TextStyle(
                  color: SolhColors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              )),
          SizedBox(
            width: 1.w,
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: SolhColors.green,
            size: 17,
          ),
        ],
      ),
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
                          getCommentFooter(element, onReplyTapped),
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
                    trimCollapsedText: ' Read more',
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
              "Comments",
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
    return Row(
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
            color: SolhColors.green,
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
    );
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
            color: SolhColors.green,
          ),
        ),
        Text(
          widget._journalModel!.comments!.toString(),
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
          icon: SvgPicture.asset(
            "assets/icons/journaling/post-connect.svg",
            width: 17,
            height: 17,
            color: SolhColors.green,
          ),
        ),
        InkWell(
          onTap: () async {
            widget._journalModel!.group != null
                ? {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return GroupDetailsPage(
                        ///// this case is for group journal
                        group: GroupList(
                          sId: widget._journalModel!.group!.sId,
                          groupName: widget._journalModel!.group!.groupName,
                          groupMediaUrl:
                              widget._journalModel!.group!.groupImage,
                        ),
                      );
                    }))
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
                        color: SolhColors.green,
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
                color: SolhColors.green,
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
                  child: Lottie.asset('assets/images/not-found.json'),
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
