import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class Post extends StatefulWidget {
  const Post({Key? key, String? imgUrl})
      : _imgUrl = imgUrl,
        super(key: key);

  final String? _imgUrl;

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        // height: MediaQuery.of(context).size.height / 1.6,
        color: Color(0xFFFFF),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // Divider(),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 20,
                //vertical: MediaQuery.of(context).size.height/80,
              ),
              child: GestureDetector(
                onTap: () => AutoRouter.of(context).push(ConnectScreenRouter()),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(
                        child: Image.asset(
                            "assets/images/journal-demo/post-user-profile-picture.png"),
                        backgroundColor: SolhColors.pink224,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width /
                                              40,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "John Cornor",
                                          style: SolhTextStyles
                                              .JournalingUsernameText,
                                        ),
                                        Text(
                                          "2H ago",
                                          style: SolhTextStyles
                                              .JournalingTimeStampText,
                                        )
                                      ],
                                    ),
                                  ),
                                  SolhExpertBadge(),
                                ],
                              ),
                            ),
                            PostMenuButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 20,
              ),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#Feeling lazy",
                    style: SolhTextStyles.JournalingHashtagText,
                  ),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    text: TextSpan(
                      text:
                          "Amet, consectetur adipiscing elit. Elit odio sollicitudin accumsan gravida. Vitae lacus at facilisis",
                      style: SolhTextStyles.JournalingDescriptionText,
                      children: [
                        TextSpan(
                          text: " see more.",
                          style:
                              SolhTextStyles.JournalingDescriptionReadMoreText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 80,
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(widget._imgUrl!),
                fit: BoxFit.cover,
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/journaling/post-like.svg",
                          width: 17,
                          height: 17,
                          color: SolhColors.green,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 40,
                          ),
                          child: Text(
                            "45",
                            style: SolhTextStyles.GreenBorderButtonText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        AutoRouter.of(context).push(CommentScreenRouter()),
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
                              "27",
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
    );
  }
}

class SolhExpertBadge extends StatelessWidget {
  const SolhExpertBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 40,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 40,
      ),
      decoration: BoxDecoration(
          color: SolhColors.grey239,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Solh Expert",
            style: SolhTextStyles.JournalingBadgeText,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 80,
            ),
            child: Icon(
              Icons.verified,
              color: SolhColors.green,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class PostMenuButton extends StatelessWidget {
  const PostMenuButton({
    Key? key,
  }) : super(key: key);

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
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: SolhColors.grey239),
                  )),
                  child: Text(
                    "Save this post",
                  ),
                ),
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
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: SolhColors.grey239),
                  )),
                  child: Text(
                    "Don't see this post again",
                  ),
                ),
                value: 2,
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
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: SolhColors.grey239),
                  )),
                  child: Text(
                    "Block this person",
                  ),
                ),
                value: 3,
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
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: SolhColors.grey239),
                  )),
                  child: Text(
                    "Report this post",
                  ),
                ),
                value: 4,
                textStyle: SolhTextStyles.JournalingPostMenuText,
                padding: EdgeInsets.zero,
              ),
            ]);
  }
}
