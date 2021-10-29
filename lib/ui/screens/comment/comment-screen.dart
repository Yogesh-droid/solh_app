import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/screens/welcome/landing-after-carousel.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key}) : super(key: key);

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
          // height: 400,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                child: PostForComment(),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.only(left: 4.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: SolhColors.green)),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Comment",
                                  border: InputBorder.none),
                              minLines: 1,
                              maxLines: 6,
                            )),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.send))
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
