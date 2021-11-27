import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SideDrawer(),
            Journaling(),
          ],
        ),
      ),
    );
  }
}

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 78.w,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 2.5.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 7.w,
                    child: CircleAvatar(
                      radius: 6.8.w,
                      backgroundImage: CachedNetworkImageProvider(
                        "https://pics.filmaffinity.com/After_We_Collided-824346009-large.jpg",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, there",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Text(
                            "John Conor ",
                            style: TextStyle(color: Color(0xFF666666)),
                          ),
                          Text(
                            " Solh Expert",
                            style: TextStyle(
                                color: SolhColors.green, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 0.25.h,
              width: double.infinity,
              color: SolhColors.green,
            ),
            Column(children: [
              SideDrawerMenuTile(
                title: "Journal",
              ),
              SideDrawerMenuTile(
                title: "Groups",
                comingSoon: true,
              ),
              SideDrawerMenuTile(
                title: "Mood Tracker",
                comingSoon: true,
              ),
            ]),
            Expanded(
              child: Container(),
            ),
            Column(children: [
              SideDrawerMenuTile(
                title: "FAQ",
                isBottomMenu: true,
              ),
              SideDrawerMenuTile(
                title: "Privacy Policy",
                isBottomMenu: true,
              ),
              SideDrawerMenuTile(
                title: "Terms of Use",
                isBottomMenu: true,
              ),
              SideDrawerMenuTile(
                title: "Give Feedback",
                isBottomMenu: true,
              ),
            ])
          ],
        ),
      ),
    );
  }
}

class SideDrawerMenuTile extends StatelessWidget {
  const SideDrawerMenuTile({
    Key? key,
    required String title,
    bool isBottomMenu = false,
    VoidCallback? onPressed,
    bool comingSoon = false,
  })  : _title = title,
        _isBottomMenu = isBottomMenu,
        _onPressed = onPressed,
        _comingSoon = comingSoon,
        super(key: key);

  final String _title;
  final bool _comingSoon;
  final bool _isBottomMenu;
  final VoidCallback? _onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4.w, right: 2.3.w),
      height: 6.5.h,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 0.25, color: Color(0xFFD9D9D9)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                _title,
                style: TextStyle(
                    fontSize: 16,
                    color:
                        _isBottomMenu ? Color(0xFFA6A6A6) : Color(0xFF222222)),
              ),
              if (_comingSoon)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                  child: ComingSoonBadge(),
                )
            ],
          ),
          Icon(
            Icons.chevron_right,
            color: Color(0xFFA6A6A6),
          )
        ],
      ),
    );
  }
}

class Journaling extends StatefulWidget {
  const Journaling({Key? key}) : super(key: key);

  @override
  _JournalingState createState() => _JournalingState();
}

class _JournalingState extends State<Journaling> {
  @override
  final List<String> _images = [
    "https://mir-s3-cdn-cf.behance.net/project_modules/disp/11462520706403.562efc838c1db.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDKwiSfAles5soFVbStddLdTd2VGg0hV8fGQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHJmKT56IxtNPFdhgZIuA5I7brj5c9ch96Rg&usqp=CAU",
    "https://mir-s3-cdn-cf.behance.net/project_modules/disp/11462520706403.562efc838c1db.jpg",
    "https://mir-s3-cdn-cf.behance.net/project_modules/disp/11462520706403.562efc838c1db.jpg",
  ];

  bool _isDrawerOpen = false;
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      left: _isDrawerOpen ? 78.w : 0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                offset: const Offset(
                  14.0,
                  14.0,
                ),
                blurRadius: 20.0,
                spreadRadius: 4.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ],
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
                      child: SvgPicture.asset(
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
                                    horizontal:
                                        MediaQuery.of(context).size.width / 20,
                                    vertical:
                                        MediaQuery.of(context).size.height / 80,
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
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4.w,
                                          ),
                                          onPressed: () =>
                                              AutoRouter.of(context).push(
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
                                margin: EdgeInsets.symmetric(vertical: 1.h),
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
              GestureDetector(
                onTap: () => setState(() => _isDrawerOpen = false),
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ComingSoonBadge extends StatelessWidget {
  const ComingSoonBadge({
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
            "Coming Soon",
            style: SolhTextStyles.JournalingBadgeText,
          ),
        ],
      ),
    );
  }
}
