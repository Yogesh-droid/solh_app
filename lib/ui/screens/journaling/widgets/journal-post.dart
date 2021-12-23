import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/journal.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:solh/widgets_constants/constants/textstyles.dart';

class JournalTile extends StatefulWidget {
  const JournalTile(
      {Key? key,
      required JournalModel? journalModel,
      required VoidCallback deletePost})
      : _journalModel = journalModel,
        _deletePost = deletePost,
        super(key: key);

  final JournalModel? _journalModel;
  final VoidCallback _deletePost;

  @override
  _JournalTileState createState() => _JournalTileState();
}

class _JournalTileState extends State<JournalTile> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget._journalModel!.isLiked;
  }

  Future<bool> _likeJournal() async {
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
    return (response["status"]);
  }

  Future<bool> _unlikeJournal() async {
    var response = await Network.makeHttpGetRequestWithToken(
      "${APIConstants.api}/api/unlike-journal/${widget._journalModel!.id}",
    );
    print(response);
    return (response["status"]);
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
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 35,
                ),
                child: GestureDetector(
                  onTap: () => AutoRouter.of(context).push(ConnectScreenRouter(
                      uid: widget._journalModel!.postedBy.uid)),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            widget._journalModel!.postedBy.profilePictureUrl,
                          ),
                          backgroundColor: SolhColors.pink224,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            widget._journalModel!.postedBy.name,
                                            style: SolhTextStyles
                                                .JournalingUsernameText,
                                          ),
                                          SizedBox(width: 1.5.w),
                                          if (widget._journalModel!.postedBy
                                                  .userType ==
                                              "Expert")
                                            SolhExpertBadge(),
                                        ],
                                      ),
                                      Text(
                                        timeago.format(DateTime.parse(
                                            widget._journalModel!.createdAt)),
                                        style: SolhTextStyles
                                            .JournalingTimeStampText,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (widget._journalModel!.postedBy.uid ==
                                  FirebaseAuth.instance.currentUser!.uid)
                                PostMenuButton(
                                  journalId: widget._journalModel!.id,
                                  deletePost: widget._deletePost,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 35,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Feeling " + widget._journalModel!.feelings,
                      style: SolhTextStyles.JournalingDescriptionReadMoreText,
                    ),
                    Text(
                      widget._journalModel!.description,
                      style: SolhTextStyles.JournalingDescriptionText,
                    ),
                  ],
                ),
              ),
              if (widget._journalModel!.mediaUrl != null)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 80,
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image:
                        NetworkImage(widget._journalModel!.mediaUrl.toString()),
                    fit: BoxFit.cover,
                  )),
                )
              else
                Container(
                  height: 1.h,
                ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 35,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (_isLiked) {
                          // await _unlikeJournal();
                          setState(() {
                            _isLiked = false;
                          });
                        } else {
                          await _likeJournal();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _isLiked ? Icons.favorite : Icons.favorite_border,
                              color: SolhColors.green,
                              size: 20,
                            ),
                            // SvgPicture.asset(
                            //   "assets/icons/journaling/post-like.svg",
                            //   width: 17,
                            //   height: 17,
                            //   color: SolhColors.green,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 40,
                              ),
                              child: Text(
                                _isLiked ? '1' : '0',
                                style: SolhTextStyles.GreenBorderButtonText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => AutoRouter.of(context).push(
                          CommentScreenRouter(
                              journalModel: widget._journalModel)),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.5,
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
                    Container(
                      width: MediaQuery.of(context).size.width / 3.5,
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
                              "Connect",
                              style: SolhTextStyles.GreenBorderButtonText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: MediaQuery.of(context).size.width / 20,
              //     //vertical: MediaQuery.of(context).size.height/140,
              //   ),
              //   child: Divider(),
              // ),
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
}

class SolhExpertBadge extends StatelessWidget {
  const SolhExpertBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.verified,
          color: SolhColors.green,
          size: 14,
        ),
      ],
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
