import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/ui/screens/journaling/widgets/journal-post.dart';
import 'package:solh/ui/screens/journaling/widgets/stories.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class JournalingScreen extends StatefulWidget {
  const JournalingScreen({Key? key}) : super(key: key);

  @override
  _JournalingScreenState createState() => _JournalingScreenState();
}

class _JournalingScreenState extends State<JournalingScreen> {
  // final _newPostKey = GlobalKey<FormState>();

  final List<String> _images = [
    "https://mir-s3-cdn-cf.behance.net/project_modules/disp/11462520706403.562efc838c1db.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDKwiSfAles5soFVbStddLdTd2VGg0hV8fGQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHJmKT56IxtNPFdhgZIuA5I7brj5c9ch96Rg&usqp=CAU",
    "https://mir-s3-cdn-cf.behance.net/project_modules/disp/11462520706403.562efc838c1db.jpg",
    "https://mir-s3-cdn-cf.behance.net/project_modules/disp/11462520706403.562efc838c1db.jpg",
  ];

  bool _isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: 60.w,
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hi, there"),
                            Row(
                              children: [
                                Text("John Conor"),
                                Text("Solh Expert"),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: 0.25.h,
                      width: double.infinity,
                      color: SolhColors.green,
                    ),
                    Column(
                        children: List.generate(
                      4,
                      (index) => Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 0.25, color: Color(0xFFD9D9D9)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(),
                              child: Text("Journal"),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Color(0xFFA6A6A6),
                            )
                          ],
                        ),
                      ),
                    )),
                    Expanded(child: Container()),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: List.generate(
                          4,
                          (index) => Container(
                            height: 5.h,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.25,
                                        color: Color(0xFFD9D9D9)))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "FAQ",
                                  style: TextStyle(),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: Color(0xFFA6A6A6),
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: _isDrawerOpen ? 60.w : 0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Scaffold(
                      appBar: SolhAppBar(
                        title: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("side bar tapped");
                                setState(() {
                                  _isDrawerOpen = !_isDrawerOpen;
                                });
                                print("opened");
                              },
                              child: _isDrawerOpen
                                  ? Container(width: 2.w)
                                  : SvgPicture.asset(
                                      "assets/icons/app-bar/app-bar-menu.svg",
                                      width: 26,
                                      height: 24,
                                      color: SolhColors.green,
                                    ),
                            ),
                            SizedBox(
                              width: 2.h,
                            ),
                            Text(
                              "Journaling",
                              style: SolhTextStyles.AppBarText,
                            ),
                          ],
                        ),
                        isLandingScreen: true,
                      ),
                      body: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0)
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                80,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SolhGreenBorderMiniButton(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      18,
                                                  width: 64.w,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 4.w,
                                                  ),
                                                  onPressed: () => AutoRouter
                                                          .of(context)
                                                      .push(
                                                          CreatePostScreenRouter()),
                                                  child: Text(
                                                    "What's on your mind?",
                                                    style: SolhTextStyles
                                                        .JournalingHintText,
                                                  )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    iconSize: 24,
                                                    splashRadius: 20,
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () => {},
                                                    icon: SvgPicture.asset(
                                                        "assets/icons/journaling/post-photo.svg"),
                                                    color: SolhColors.green,
                                                  ),
                                                  Container(
                                                    height: 3.h,
                                                    width: 0.2,
                                                    color: SolhColors.blackop05,
                                                  ),
                                                  IconButton(
                                                    iconSize: 24,
                                                    splashRadius: 20,
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () => {},
                                                    icon: SvgPicture.asset(
                                                        "assets/icons/journaling/switch-profile.svg"),
                                                    color: SolhColors.green,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Stories(),
                                      ],
                                    );
                                  return Column(
                                    children: [
                                      Container(
                                        child: Post(
                                          imgUrl: _images[index],
                                        ),
                                        decoration: BoxDecoration(),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 1.h),
                                        height: 0.8.h,
                                        color: Colors.green.shade400
                                            .withOpacity(0.25)
                                            .withAlpha(80)
                                            .withGreen(160),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    if (_isDrawerOpen)
                      Container(
                        color: Colors.black.withOpacity(0.25),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                    if (_isDrawerOpen)
                      Positioned(
                        top: 6.3.h,
                        left: 1.8.w,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isDrawerOpen = false;
                            });
                          },
                          child: Icon(
                            Icons.chevron_left,
                            size: 35,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
