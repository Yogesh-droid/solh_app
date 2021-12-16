import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/comments-bloc.dart';
import 'package:solh/model/comment.dart';
import 'package:solh/model/journal.dart';
import 'package:solh/services/journal/comment.dart';
import 'package:solh/ui/screens/journaling/widgets/journal-post.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key, required JournalModel? journalModel})
      : _journalModel = journalModel,
        super(key: key);

  final JournalModel? _journalModel;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  CommentNetwork _commentNetwork = CommentNetwork();
  bool? _isLoginedUserJournal;

  final FocusNode _commentFocusnode = FocusNode();
  final TextEditingController _commentEditingController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  CommentModel? _bestComment;

  @override
  void initState() {
    super.initState();
    commentsBloc.getcommentsSnapshot(widget._journalModel!.id);
    _isLoginedUserJournal = widget._journalModel!.postedBy.uid ==
        FirebaseAuth.instance.currentUser!.uid;
    _bestComment = widget._journalModel!.bestComment;
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
                  child: StreamBuilder<List<CommentModel?>>(
                      stream: commentsBloc.commentsStateStream,
                      builder: (context, commentSnapshot) {
                        if (commentSnapshot.hasData)
                          return CustomScrollView(
                            controller: _scrollController,
                            slivers: [
                              SliverToBoxAdapter(
                                child: PostForComment(
                                  journalModel: widget._journalModel,
                                  bestComment: _bestComment,
                                ),
                              ),
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (_, index) => CommentBoxWidget(
                                            deleteComment: () async {
                                              await _commentNetwork
                                                  .deleteComment(
                                                      journalId: widget
                                                          ._journalModel!.id,
                                                      commentId: commentSnapshot
                                                          .requireData[index]!
                                                          .id);
                                              setState(() {
                                                commentSnapshot.requireData
                                                    .remove(commentSnapshot
                                                        .requireData[index]);
                                              });
                                              print("deleted");
                                            },
                                            makeBestComment: () async {
                                              await _commentNetwork
                                                  .makeBestComment(
                                                      journalId: widget
                                                          ._journalModel!.id,
                                                      commentId: commentSnapshot
                                                          .requireData[index]!
                                                          .id);
                                              setState(() {
                                                _bestComment = commentSnapshot
                                                    .requireData[index];
                                                print(
                                                    _bestComment!.commentBody);
                                              });
                                              print("deleted");
                                            },
                                            journalId: widget._journalModel!.id,
                                            commentModel: commentSnapshot
                                                .requireData[index],
                                            isUserPost:
                                                _isLoginedUserJournal ?? false,
                                          ),
                                      childCount:
                                          commentSnapshot.requireData.length)),
                            ],
                          );
                        else
                          return Center(child: CircularProgressIndicator());
                      }),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 4.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: SolhColors.green)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _commentEditingController,
                              focusNode: _commentFocusnode,
                              autofocus: true,
                              decoration: InputDecoration(
                                  hintText: "Comment",
                                  border: InputBorder.none),
                              minLines: 1,
                              maxLines: 6,
                            ),
                          ),
                          IconButton(
                              onPressed: _isLoading
                                  ? null
                                  : () async {
                                      if (_commentEditingController.text !=
                                          '') {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        print("comment");
                                        await _commentNetwork.addComment(
                                            journalId: widget._journalModel!.id,
                                            commentBody:
                                                _commentEditingController.text);
                                        _commentEditingController.clear();
                                        _scrollController.animateTo(0,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeIn);
                                        commentsBloc.getcommentsSnapshot(
                                            widget._journalModel!.id);
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    },
                              icon: _isLoading
                                  ? Container(
                                      height: 4.w,
                                      width: 4.w,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                      ))
                                  : Icon(Icons.send))
                        ],
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 6.w,
                    //   ),
                    //   alignment: Alignment.centerRight,
                    //   height: 6.h,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       SolhGreenBorderButton(
                    //         child: Text(
                    //           "Geetansh",
                    //           style: SolhTextStyles.GreenBorderButtonText,
                    //         ),
                    //         width: 25.w,
                    //         height: 3.8.h,
                    //       ),
                    //       SolhGreenBorderButton(
                    //         child: Text(
                    //           "Annonymous",
                    //           style: SolhTextStyles.GreenBorderButtonText,
                    //         ),
                    //         width: 25.w,
                    //         height: 3.8.h,
                    //       ),
                    //       Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.only(left: 10.0),
                    //             child: SvgPicture.asset(
                    //               "assets/icons/comment-screen/interchange.svg",
                    //               width: 3.w,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 0.4.h,
                    //           ),
                    //           Stack(
                    //             alignment: Alignment.center,
                    //             children: [
                    //               Padding(
                    //                 padding:
                    //                     const EdgeInsets.only(left: 20.0),
                    //                 child: CircleAvatar(
                    //                   backgroundColor: SolhColors.grey,
                    //                   radius: 10,
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding:
                    //                     const EdgeInsets.only(right: 1.0),
                    //                 child: CircleAvatar(
                    //                   radius: 12,
                    //                 ),
                    //               ),
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class CommentBoxWidget extends StatelessWidget {
  CommentBoxWidget({
    Key? key,
    required String journalId,
    required bool isUserPost,
    required CommentModel? commentModel,
    required VoidCallback? deleteComment,
    required VoidCallback makeBestComment,
  })  : _commentModel = commentModel,
        _isUserPost = isUserPost,
        _journalId = journalId,
        _deleteComment = deleteComment,
        _makeBestComment = makeBestComment,
        super(key: key);

  final VoidCallback? _deleteComment;
  final String _journalId;
  final VoidCallback _makeBestComment;
  final CommentModel? _commentModel;
  final bool _isUserPost;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.5.h),
      color: Color.fromRGBO(245, 245, 245, 0.75),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          _commentModel!.user.profilePicture,
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                        width: 2.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                _commentModel!.user.name,
                                style: TextStyle(color: Color(0xFF666666)),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              SolhExpertBadge()
                            ],
                          ),
                          Text(
                            timeago.format(
                                DateTime.parse(_commentModel!.createdAt)),
                            style: TextStyle(color: Color(0xFF666666)),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(2.w),
                child: Text(
                  _commentModel!.commentBody,
                  style: TextStyle(height: 1.4, color: Color(0xFF222222)),
                ),
              ),
            ],
          ),
          CommentMenuButton(
              makeBestComment: _makeBestComment,
              commentId: _commentModel!.id,
              journalId: _journalId,
              deleteJournal: _deleteComment),
        ],
      ),
    );
  }
}

class CommentMenuButton extends StatelessWidget {
  CommentMenuButton({
    Key? key,
    required String commentId,
    required String journalId,
    required VoidCallback? deleteJournal,
    required VoidCallback? makeBestComment,
  })  : _deleteJournal = deleteJournal,
        _commentId = commentId,
        _journalId = journalId,
        _makeBestComment = makeBestComment,
        super(key: key);

  final VoidCallback? _deleteJournal;
  final String _commentId;
  final String _journalId;
  final VoidCallback? _makeBestComment;

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
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: SolhColors.grey239),
                  )),
                  child: Text(
                    "Delete this comment",
                  ),
                ),
                onTap: _deleteJournal,
                value: 1,
                textStyle: SolhTextStyles.JournalingPostMenuText,
                padding: EdgeInsets.zero,
              ),
              PopupMenuItem(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20,
                    vertical: MediaQuery.of(context).size.height / 80,
                  ),
                  child: Text(
                    "Select for best comment",
                  ),
                ),
                onTap: _makeBestComment,
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

class PostForComment extends StatelessWidget {
  const PostForComment(
      {Key? key,
      required JournalModel? journalModel,
      required CommentModel? bestComment})
      : _journalModel = journalModel,
        _bestComment = bestComment,
        super(key: key);

  final CommentModel? _bestComment;
  final JournalModel? _journalModel;
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
                  Text(
                    "Feeling " + _journalModel!.feelings,
                    style: SolhTextStyles.JournalingDescriptionReadMoreText,
                  ),
                  Text(
                    _journalModel!.description,
                    style: SolhTextStyles.JournalingDescriptionText,
                  ),
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
        if (_bestComment != null)
          BestCommentWidget(
            commentModel: _bestComment,
          )
      ],
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
