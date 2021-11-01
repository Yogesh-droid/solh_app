import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/screens/welcome/landing-after-carousel.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusNode _commentFocusnode = FocusNode();

    return Scaffold(
        appBar: SolhAppBar(
          title: Text(
            "Comments",
            style: SolhTextStyles.AppBarText,
          ),
          isLandingScreen: false,
        ),
        body: Container(
          // height: 400,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                child: PostForComment(),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
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
                                focusNode: _commentFocusnode,
                                autofocus: true,
                                decoration: InputDecoration(
                                    hintText: "Comment",
                                    border: InputBorder.none),
                                minLines: 1,
                                maxLines: 6,
                              ),
                            ),
                            IconButton(onPressed: () {}, icon: Icon(Icons.send))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                        ),
                        alignment: Alignment.centerRight,
                        height: 6.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // SolhGreenBorderButton(
                            //   child: Text(
                            //     "Geetansh",
                            //     style: SolhTextStyles.GreenBorderButtonText,
                            //   ),
                            //   width: 25.w,
                            //   height: 3.8.h,
                            // ),
                            // SolhGreenBorderButton(
                            //   child: Text(
                            //     "Annonymous",
                            //     style: SolhTextStyles.GreenBorderButtonText,
                            //   ),
                            //   width: 25.w,
                            //   height: 3.8.h,
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/comment-screen/interchange.svg",
                                    width: 3.w,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.4.h,
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: CircleAvatar(
                                        backgroundColor: SolhColors.grey,
                                        radius: 10,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 1.0),
                                      child: CircleAvatar(
                                        radius: 12,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}

class PostForComment extends StatelessWidget {
  const PostForComment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
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
                          "hey, Welcome to solh app. we are here to provide help for the mental health.",
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
            )
          ],
        ),
        Divider(),
        Row(
          children: [
            Text(
              "Most Upvoted ",
              style: SolhTextStyles.mostUpvoted,
            ),
            Icon(CupertinoIcons.chevron_down, size: 16, color: SolhColors.green)
          ],
        ),
        Container(
          color: Color(0xF5F5F5F5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(),
                      SizedBox(
                        height: 6.h,
                        width: 2.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text("John Conor"), Text("2D ago")],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 4.w),
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
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                    color: SolhColors.green,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Text(
                  '''❝Accept yourself, love yourself, and keep moving forward. If you want to fly, you have to give up what weighs you down.❞''',
                  style: TextStyle(height: 1.4, color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
