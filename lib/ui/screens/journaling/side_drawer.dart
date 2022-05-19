import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/my_diary/my_diary_list_page.dart';
import 'package:solh/ui/screens/groups/create_group.dart';
import 'package:solh/ui/screens/groups/manage_groups.dart';
import 'package:solh/ui/screens/journaling/widgets/side_drawer_menu_tile.dart';
import '../../../bloc/user-bloc.dart';
import '../../../model/user/user.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../../../widgets_constants/loader/my-loader.dart';
import '../my-profile/my-profile-screen.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 78.w,
        child: Column(
          children: [
            StreamBuilder<UserModel?>(
                stream: userBlocNetwork.userStateStream,
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData)
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 2.5.h, horizontal: 3.8.w),
                      child: InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MyProfileScreen();
                        })),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 7.w,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 6.8.w,
                                backgroundImage: CachedNetworkImageProvider(
                                  userSnapshot.data!.profilePicture ??
                                      "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      userSnapshot.requireData!.name ?? "",
                                      style:
                                          TextStyle(color: Color(0xFF666666)),
                                    ),
                                    SizedBox(width: 1.5.w),
                                    // Text(
                                    //   userSnapshot.requireData!.userType ==
                                    //           'Normal'
                                    //       ? ''
                                    //       : userSnapshot.requireData!.userType ??
                                    //           "",
                                    //   style: TextStyle(
                                    //       height: 0.18.h,
                                    //       color: SolhColors.green,
                                    //       fontSize: 10),
                                    // ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  return Container(
                    child: MyLoader(),
                  );
                }),
            Container(
              height: 0.25.h,
              width: double.infinity,
              color: SolhColors.green,
            ),
            Column(children: [
              SideDrawerMenuTile(
                title: "My Diary",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyDiaryListPage()));
                },
              ),
              SideDrawerMenuTile(
                title: "Groups",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ManageGroupPage()));
                },
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
