import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/goal-setting/goal_setting_controller.dart';
import 'package:solh/controllers/group/create_group_controller.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/controllers/journals/feelings_controller.dart';
import 'package:solh/model/user/user.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/ui/screens/my-profile/profile/edit-profile.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../../controllers/chat-list/chat_controller.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  ConnectionController connectionController = Get.find();

  @override
  void initState() {
    getMyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userBlocNetwork.getMyProfileSnapshot();

    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      appBar: SolhAppBar(
        title: Text(
          "Profile",
          style: SolhTextStyles.AppBarText,
        ),
        isLandingScreen: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<UserModel?>(
            stream: userBlocNetwork.userStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(
                    'snapshot.data.profilePictureUrl: ${snapshot.data!.firstName}');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (FirebaseAuth.instance.currentUser == null)
                      Center(
                        child: SignInButton(),
                      )
                    else
                      ProfileContainer(userModel: snapshot.requireData),
                    ProfileMenu(),
                    SizedBox(height: 5.h),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SolhGreenBorderButton(
                          height: 50,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: Text(
                            "Logout",
                            style: TextStyle(
                                fontSize: 18, color: SolhColors.black166),
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut().then((value) {
                              userBlocNetwork.updateSessionCookie = "";
                              Get.delete<ChatListController>();
                              Get.delete<GoalSettingController>();
                              Get.delete<ConnectionController>();
                              Get.delete<DiscoverGroupController>();
                              Get.delete<CreateGroupController>();
                              Get.delete<FeelingsController>();
                              AutoRouter.of(context).pushAndPopUntil(
                                  IntroCarouselScreenRouter(),
                                  predicate: (route) => false);
                            });
                          }),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SolhGreenButton(
                          height: 50,
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: Text(
                            "Delete Account",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut().then((value) async {
                              Get.delete<GoalSettingController>();
                              Get.delete<ConnectionController>();
                              Utility.showLoader(context);
                              await userBlocNetwork.deleteAccount();
                              Utility.hideLoader(context);
                              AutoRouter.of(context).pushAndPopUntil(
                                  IntroCarouselScreenRouter(),
                                  predicate: (route) => false);
                            });
                          }),
                    ) */
                  ],
                );
              }
              if (snapshot.hasError)
                Container(child: Text(snapshot.error.toString()));
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 3),
                  Center(child: MyLoader()),
                ],
              );
            }),
      ),
    );
  }

  getMyProfile() async {
    connectionController.getUserAnalytics(userBlocNetwork.id);
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.5.h),
      color: Colors.white,
      child: Column(
        children: [
          ProfileMenuTile(
            title: "Edit Profile",
            onPressed: () {
              //AutoRouter.of(context).push(EditMyProfileScreenRouter());
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditMyProfileScreen();
              }));
            },
            svgIconPath: "assets/icons/profile/edit.svg",
          ),
          ProfileMenuTile(
            title: "Posts",
            onPressed: () {
              AutoRouter.of(context)
                  .push(PostScreenRouter(sId: userBlocNetwork.id));
            },
            svgIconPath: "assets/icons/profile/posts.svg",
          ),
          ProfileMenuTile(
              title: "Account Privacy",
              svgIconPath: "assets/icons/profile/privacy.svg",
              onPressed: () {
                AutoRouter.of(context).push(AccountPrivacyScreenRouter());
              }),
          // ProfileMenuTile(
          //   title: "Settings",
          //   onPressed: () {
          //     AutoRouter.of(context).push(SettingsScreenRouter());
          //   },
          //   svgIconPath: "assets/icons/profile/settings.svg",
          // ),
          // ProfileMenuTile(
          //   title: "Medical Reports",
          //   onPressed: () {
          //     AutoRouter.of(context).push(CreateProfileScreenRouter());
          //   },
          //   svgIconPath: "assets/icons/profile/medical-reports.svg",
          // ),
          // ProfileMenuTile(
          //   title: "Personal Issues & Medical Backgrounds",
          //   onPressed: () {},
          //   svgIconPath: "assets/icons/profile/info.svg",
          // ),
          // ProfileMenuTile(
          //   title: "Badges & Rewards",
          //   onPressed: () {},
          //   svgIconPath: "assets/icons/profile/badges-reward.svg",
          // )
        ],
      ),
    );
  }
}

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile(
      {Key? key,
      required String title,
      required String svgIconPath,
      required VoidCallback onPressed})
      : _title = title,
        _svgIconPath = svgIconPath,
        _onPressed = onPressed,
        super(key: key);

  final String _title;
  final String _svgIconPath;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(_svgIconPath),
                SizedBox(
                  width: 2.w,
                ),
                Container(
                  width: 75.w,
                  child: Text(
                    _title,
                    style: SolhTextStyles.ProfileMenuGreyText,
                  ),
                ),
              ],
            ),
            Icon(
              CupertinoIcons.right_chevron,
              size: 16,
              color: SolhColors.green,
            )
          ],
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color.fromRGBO(217, 217, 217, 1)))),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      color: Colors.white,
      child: SolhGreenButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/profile/person_outlined.svg"),
            SizedBox(
              width: 3.w,
            ),
            Text(
              "LOG IN / SIGN UP",
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
        borderRadius: BorderRadius.circular(8.0),
        height: 7.h,
        width: MediaQuery.of(context).size.width / 1.1,
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  ProfileContainer({Key? key, required UserModel? userModel})
      : _userModel = userModel,
        super(key: key);

  final UserModel? _userModel;
  final ConnectionController _connectionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 3.h),
        color: Colors.white,
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 49,
                backgroundImage: CachedNetworkImageProvider(
                    _userModel!.profilePicture ?? ''),
              ),
            ),
            SizedBox(height: 1.5.h),
            Text(
              _userModel!.name ?? "",
              style:
                  SolhTextStyles.SOSGreenHeading.copyWith(color: Colors.black),
            ),
            // Text(
            //   _userModel!.userType == 'Normal'
            //       ? ''
            //       : _userModel!.userType ?? "",
            //   style: SolhTextStyles.JournalingBadgeText,
            // ),
            //SizedBox(height: 0.8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Text(
                _userModel!.bio ?? "",
                textAlign: TextAlign.center,
              ),
            ),
            // ProfileDetailsButtonRow(
            //   connections: _userModel!.connections,
            //   // likes: _userModel!.likes,
            //   likes: 0,
            //   // posts: _userModel!.posts,
            //   posts: 0,
            //   reviews: _userModel!.reviews,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: 6.w, right: 6.w, top: 1.8.h, bottom: 0.7.h),
            //   child: Row(
            //     children: [
            //       Expanded(
            //           child: SolhGreenBorderButton(
            //               child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Icon(
            //             CupertinoIcons.pencil,
            //             color: SolhColors.green,
            //             size: 16,
            //           ),
            //           SizedBox(
            //             width: 1.w,
            //           ),
            //           Text(
            //             "Edit",
            //             style: SolhTextStyles.GreenBorderButtonText,
            //           ),
            //         ],
            //       ))),
            //       SizedBox(
            //         width: 4.w,
            //       ),
            //       Expanded(
            //           child: SolhGreenBorderButton(
            //               child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             "Anonymous",
            //             style: SolhTextStyles.GreenBorderButtonText,
            //           ),
            //           SizedBox(width: 1.w),
            //           Icon(
            //             CupertinoIcons.arrow_right,
            //             color: SolhColors.green,
            //             size: 16,
            //           )
            //         ],
            //       )))
            //     ],
            //   ),
            // ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          size: 18,
                          color: SolhColors.green,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Obx(() {
                          return Text(
                            //_userModel!.likes.toString(),
                            _connectionController
                                .userAnalyticsModel.value.journalLikeCount
                                .toString(),
                            style:
                                SolhTextStyles.GreenBorderButtonText.copyWith(
                                    fontSize: 18),
                          );
                        })
                      ],
                    ),
                    Text("Likes"),
                  ],
                ),
                // Divider(),
                Column(
                  children: [
                    Obx(() {
                      return Text(
                        _connectionController
                            .userAnalyticsModel.value.connectionCount
                            .toString(),
                        style: SolhTextStyles.GreenBorderButtonText.copyWith(
                            fontSize: 18),
                      );
                    }),
                    Text("Connections"),
                  ],
                ),
                // Divider(),
                // Column(
                //   children: [
                //     Text(
                //       '17',
                //       style: SolhTextStyles.GreenBorderButtonText.copyWith(
                //           fontSize: 18),
                //     ),
                //     Text("Reviews"),
                //   ],
                // )
              ],
            ),
          ],
        ));
  }
}

class ProfileDetailsButtonRow extends StatelessWidget {
  const ProfileDetailsButtonRow(
      {Key? key,
      required int likes,
      required int connections,
      required int posts,
      required int reviews})
      : _likes = likes,
        _connections = connections,
        _posts = posts,
        _reviews = reviews,
        super(key: key);

  final int _likes;
  final int _connections;
  final int _posts;
  final int _reviews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfileDetailsButton(
            count: _likes,
            title: "Likes",
            svgIconPath: "assets/icons/profile/connections.svg",
          ),
          Container(
            color: Colors.black,
            height: 4.h,
            width: 0.3,
          ),
          ProfileDetailsButton(
            count: _connections,
            title: "Connections",
            svgIconPath: "assets/icons/profile/connections.svg",
          ),
          Container(
            color: Colors.black,
            height: 4.h,
            width: 0.3,
          ),
          ProfileDetailsButton(
            count: _posts,
            title: "Posts",
            svgIconPath: "assets/icons/profile/connections.svg",
          ),
          Container(
            color: Colors.black,
            height: 4.h,
            width: 0.3,
          ),
          ProfileDetailsButton(
            count: _reviews,
            title: "Reviews",
            svgIconPath: "assets/icons/profile/connections.svg",
          ),
        ],
      ),
    );
  }
}

class ProfileDetailsButton extends StatelessWidget {
  const ProfileDetailsButton(
      {Key? key,
      required String svgIconPath,
      int? count,
      required String title,
      VoidCallback? onPressed})
      : _count = count,
        _title = title,
        _svgIconPath = svgIconPath,
        _onPressed = onPressed,
        super(key: key);

  final String _svgIconPath;
  final String _title;
  final int? _count;
  final VoidCallback? _onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(_svgIconPath),
              SizedBox(width: 1.6.w),
              Text(
                _count.toString(),
                style:
                    SolhTextStyles.GreenBorderButtonText.copyWith(fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: 0.4.h,
          ),
          Text(
            _title,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
