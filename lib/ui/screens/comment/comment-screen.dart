import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/journals/journal_comment_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/model/comment.dart';
import 'package:solh/model/journals/get_jouranal_comment_model.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../journaling/widgets/comment_menu_btn.dart';
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
    _isLoginedUserJournal = widget._journalModel!.postedBy!.uid ==
        FirebaseAuth.instance.currentUser!.uid;
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
                // Expanded(
                //   child: StreamBuilder<List<CommentModel?>>(
                //       stream: commentsBloc.commentsStateStream,
                //       builder: (context, commentSnapshot) {
                //         if (commentSnapshot.hasData)
                //           return CustomScrollView(
                //             controller: _scrollController,
                //             slivers: [
                //               SliverToBoxAdapter(
                //                 child: PostForComment(
                //                   journalModel: widget._journalModel,
                //                   bestComment: commentsBloc.getBestComment,
                //                 ),
                //               ),
                //               SliverList(
                //                   delegate: SliverChildBuilderDelegate(
                //                       (_, index) => CommentBoxWidget(
                //                             deleteComment: () async {
                //                               await _commentNetwork
                //                                   .deleteComment(
                //                                       journalId: widget
                //                                           ._journalModel!.id,
                //                                       commentId: commentSnapshot
                //                                           .requireData[index]!
                //                                           .id);
                //                               setState(() {
                //                                 commentSnapshot.requireData
                //                                     .remove(commentSnapshot
                //                                         .requireData[index]);
                //                               });
                //                               print("deleted");
                //                             },
                //                             makeBestComment: () async {
                //                               await _commentNetwork
                //                                   .makeBestComment(
                //                                       journalId: widget
                //                                           ._journalModel!.id,
                //                                       commentId: commentSnapshot
                //                                           .requireData[index]!
                //                                           .id);
                //                               setState(() {
                //                                 commentsBloc.setBestComment =
                //                                     commentSnapshot
                //                                         .requireData[index];
                //                                 print(commentsBloc
                //                                     .getBestComment);
                //                               });
                //                             },
                //                             journalModel: widget._journalModel!,
                //                             commentModel: commentSnapshot
                //                                 .requireData[index],
                //                             isUserPost:
                //                                 _isLoginedUserJournal ?? false,
                //                           ),
                //                       childCount:
                //                           commentSnapshot.requireData.length)),
                //             ],
                //           );
                //         else
                //           return Center(
                //             child: MyLoader(),
                //           );
                //       }),
                // ),
                Expanded(
                    child: Obx(() => !journalCommentController.isLoading.value
                        ? CustomScrollView(
                            controller: _scrollController,
                            slivers: [
                              SliverToBoxAdapter(
                                child: PostForComment(
                                  journalModel: widget._journalModel,
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
                                            commentBody:
                                                journalCommentController
                                                    .getJouranalsCommentModel
                                                    .value
                                                    .bestComment!
                                                    .commentBody,
                                            commentBy: journalCommentController
                                                .getJouranalsCommentModel
                                                .value
                                                .bestComment!
                                                .commentBy,
                                            commentDate:
                                                journalCommentController
                                                    .getJouranalsCommentModel
                                                    .value
                                                    .bestComment!
                                                    .commentDate,
                                            commentOn: journalCommentController
                                                .getJouranalsCommentModel
                                                .value
                                                .bestComment!
                                                .commentOn,
                                            commentTime:
                                                journalCommentController
                                                    .getJouranalsCommentModel
                                                    .value
                                                    .bestComment!
                                                    .commentTime,
                                            commentUser:
                                                journalCommentController
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
                                                            ._journalModel!
                                                            .id ??
                                                        '',
                                                    commentId:
                                                        journalCommentController
                                                                .getJouranalsCommentModel
                                                                .value
                                                                .bestComment!
                                                                .sId ??
                                                            '');
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
                                          onReplyTapped: (id, name) {
                                            journalCommentController
                                                .isReplying.value = true;
                                            journalCommentController.commentId =
                                                id;
                                            journalCommentController
                                                .repliedTo.value = name;
                                          },
                                          index: 0),
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
                                                                '');
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
                                              onReplyTapped: (id, name) {
                                                print(id);
                                                print(journalCommentController
                                                    .isReplying.value);
                                                journalCommentController
                                                    .isReplying.value = true;
                                                journalCommentController
                                                    .commentId = id;
                                                journalCommentController
                                                    .repliedTo.value = name;
                                              },
                                              commentModel:
                                                  journalCommentController
                                                      .getJouranalsCommentModel
                                                      .value
                                                      .comments![index],
                                              isUserPost:
                                                  _isLoginedUserJournal ??
                                                      false,
                                              index: index),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: SolhColors.green)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() =>
                          journalCommentController.repliedTo.value.isNotEmpty
                              ? Align(
                                  alignment: Alignment.topLeft,
                                  // child: MaterialButton(
                                  //   onPressed: () {},
                                  //   child: Text(
                                  //     journalCommentController.repliedTo.value,
                                  //     style: TextStyle(color: Colors.blueAccent),
                                  //   ),
                                  // ),
                                  child: RichText(
                                    text: TextSpan(),
                                  ),
                                )
                              : SizedBox()),
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
                                        ? 'Replying ...'
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
                          IconButton(
                              onPressed: () async {
                                print(
                                    'journalCommentController.isReplying.value');
                                if (_commentEditingController.text != '') {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  journalCommentController.isReplying.value
                                      ? await journalCommentController.addReply(
                                          parentId: journalCommentController
                                              .commentId,
                                          journalId: widget._journalModel!.id!,
                                          commentBody:
                                              _commentEditingController.text)
                                      : await journalCommentController
                                          .addComment(
                                              journalId:
                                                  widget._journalModel!.id!,
                                              commentBody:
                                                  _commentEditingController
                                                      .text);
                                  _commentEditingController.clear();
                                  _scrollController.jumpTo(_scrollController
                                      .position.minScrollExtent);
                                  // _scrollController.animateTo(1,
                                  //     duration:
                                  //         Duration(milliseconds: 500),
                                  //     curve: Curves.easeIn);
                                  // commentsBloc.getcommentsSnapshot(
                                  //     widget._journalModel!.id!);
                                  /////////////////
                                  getComments();
                                  _journalPageController.journalsList.value
                                      .forEach((element) {
                                    if (element.id ==
                                        widget._journalModel!.id) {
                                      element.comments = element.comments! + 1;
                                    }
                                  });
                                  _journalPageController.journalsList.refresh();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },

                              /* _isLoading
                                  ? null
                                  : journalCommentController.isReplying.value
                                      ? () {
                                          print('replying..............');
                                          print(journalCommentController
                                              .commentId);
                                          Future.delayed(
                                              Duration(milliseconds: 500), () {
                                            journalCommentController
                                                .isReplying.value = false;
                                            print('replyied..............');
                                          });
                                        }
                                      : () async {
                                          print('commenting..............');
                                          // if (_commentEditingController.text !=
                                          //     '') {
                                          //   setState(() {
                                          //     _isLoading = true;
                                          //   });
                                          //   print("comment");
                                          //   await journalCommentController
                                          //       .addComment(
                                          //           journalId: widget
                                          //               ._journalModel!.id!,
                                          //           commentBody:
                                          //               _commentEditingController
                                          //                   .text);
                                          //   _commentEditingController.clear();
                                          //   _scrollController.jumpTo(
                                          //       _scrollController
                                          //           .position.minScrollExtent);
                                          //   // _scrollController.animateTo(1,
                                          //   //     duration:
                                          //   //         Duration(milliseconds: 500),
                                          //   //     curve: Curves.easeIn);
                                          //   // commentsBloc.getcommentsSnapshot(
                                          //   //     widget._journalModel!.id!);
                                          //   getComments();
                                          //   _journalPageController
                                          //       .journalsList.value
                                          //       .forEach((element) {
                                          //     if (element.id ==
                                          //         widget._journalModel!.id) {
                                          //       element.comments =
                                          //           element.comments! + 1;
                                          //     }
                                          //   });
                                          //   _journalPageController.journalsList
                                          //       .refresh();
                                          //   setState(() {
                                          //     _isLoading = false;
                                          //   });
                                          // }
                                        }, */
                              icon: _isLoading
                                  ? Container(
                                      height: 4.w,
                                      width: 4.w,
                                      child: MyLoader(
                                        strokeWidth: 2.5,
                                      ))
                                  : Icon(
                                      Icons.send,
                                      color: SolhColors.green,
                                    ))
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
  final Function(String id, String userName) onReplyTapped;
  final int index;
  final JournalCommentController journalCommentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Column(
        children: [
          getCommentBody(_commentModel!, _bestComment),
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
                          onReplyTapped)
                      : Container();
                })
              : Obx(() {
                  return journalCommentController
                                  .repliesList.value[index].length >
                              0 &&
                          journalCommentController.hiddenReplyList[index]
                      ? getReplyView(
                          journalCommentController.repliesList.value[index],
                          onReplyTapped)
                      : Container();
                })
        ],
      ),
    );
  }

  Widget getCommentBody(Comments commentModel, BestComment? bestComment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
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
                              SolhExpertBadge(),
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
                          _journalModel.postedBy!.uid ==
                              FirebaseAuth.instance.currentUser!.uid)
                        CommentMenuButton(
                            makeBestComment: _makeBestComment,
                            commentId: commentModel.sId!,
                            journalModel: _journalModel,
                            deleteJournal: _deleteComment),
                    ],
                  ),
                  Divider(),
                  Text(
                    commentModel.commentBody!,
                    style: TextStyle(height: 1.4, color: Color(0xFF222222)),
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
    Function(String id, String userName) onReplyTapped,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.thumb_up_outlined,
                color: SolhColors.green,
                size: 17,
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                '(0)',
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
                      commentModel!.sId!, commentModel!.user![0].name!);
                },
                color: SolhColors.green,
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                '(0)',
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
      List<dynamic> list, Function(String id, String username) onReplyTapped) {
    return list.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: list
                  .map((element) => Column(
                        children: [
                          getCommentBody(element, null),
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

  Widget getReplyCard(element, int index) {
    return Container();
  }
}

class PostForComment extends StatelessWidget {
  const PostForComment({
    Key? key,
    required Journals? journalModel,
  })  : _journalModel = journalModel,
        super(key: key);

  //final CommentModel? _bestComment;
  final Journals? _journalModel;
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
                  _journalModel!.feelings != null
                      ? Text(
                          "Feeling " + _journalModel!.feelings!.feelingName!,
                          style:
                              SolhTextStyles.JournalingDescriptionReadMoreText,
                        )
                      : Container(),
                  ReadMoreText(
                    _journalModel!.description ?? '',
                    style: SolhTextStyles.JournalingDescriptionText,
                    trimCollapsedText: ' Read more',
                    trimExpandedText: ' less',
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getLikeBtn(),
                      getCommentsBtn(),
                      getConnectBtn(),
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
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border_outlined,
              color: SolhColors.green,
              size: 16,
            )),
        Text(
          _journalModel!.likes!.toString(),
          style: TextStyle(color: Colors.grey),
        ),
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
          _journalModel!.comments!.toString(),
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget getConnectBtn() {
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
        Text(
          'connect',
          style: TextStyle(color: Colors.grey),
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
                          size: 16,
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
