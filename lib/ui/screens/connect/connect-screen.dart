import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../model/user/user.dart';
import '../../../services/user/user-profile.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';

class ConnectProfileScreen extends StatefulWidget {
  ConnectProfileScreen(
      {Key? key, String? username, required String uid, required String sId})
      : _username = username,
        _uid = uid,
        _sId = sId,
        super(key: key);

  final String? _username;
  final String _uid;
  final String _sId;

  @override
  State<ConnectProfileScreen> createState() => _ConnectProfileScreenState();
}

class _ConnectProfileScreenState extends State<ConnectProfileScreen> {
  final ConnectionController connectionController = Get.find();

  @override
  void initState() {
    print('it ran');
    getUser();

    // TODO: implement initState

    super.initState();
  }

  getUser() async {
    print('Likes    ' + connectionController.userModel.value.likes.toString());
    if (widget._username != null) {
      print('adhbfjkjknasklmdkamdsmdads,f,d');
      await connectionController.getUserprofileData(widget._username ?? '');
    } else {
      print('username is null and anlytics is not');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
          isLandingScreen: false,
          title: Text(
            "Connect",
            style: SolhTextStyles.AppBarText,
          ),
        ),
        body: widget._username != null
            ? GetBuilder<ConnectionController>(
                init: connectionController,
                builder: (connectionController) {
                  return connectionController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : connectionController.userModel.value.lastName == null
                          ? Center(
                              child: Container(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                    ),
                                    Icon(
                                      Icons.error,
                                      color: Colors.grey,
                                      size: 100,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "User not found",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : NestedScrollView(
                              headerSliverBuilder:
                                  (context, innerBoxIsScrolled) => [
                                SliverList(
                                  delegate: SliverChildListDelegate([
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 2.5.h),
                                        CircleAvatar(
                                          radius: 6.5.h,
                                          backgroundColor: Color(0xFFD9D9D9),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 6.h,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    connectionController
                                                            .userModel
                                                            .value
                                                            .profilePicture ??
                                                        ""),
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                connectionController.userModel
                                                        .value.firstName ??
                                                    "",
                                                style: TextStyle(fontSize: 21)),
                                            //Icon(Icons.people, color: SolhColors.grey)
                                          ],
                                        ),
                                        // Text(
                                        //   userProfileSnapshot.requireData.userType ?? "",
                                        //   style: SolhTextStyles.GreenBorderButtonText,
                                        // ),
                                        SizedBox(height: 1.5.h),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18),
                                          child: Text(
                                              connectionController
                                                      .userModel.value.bio ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16)),
                                        ),
                                        SizedBox(height: 3.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
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
                                                    Obx(() => Text(
                                                          (connectionController
                                                                      .userModel
                                                                      .value
                                                                      .journalLikeCount ??
                                                                  0)
                                                              .toString(),
                                                          style: SolhTextStyles
                                                                  .GreenBorderButtonText
                                                              .copyWith(
                                                                  fontSize: 18),
                                                        )),
                                                  ],
                                                ),
                                                Text("Likes"),
                                              ],
                                            ),
                                            // Divider(),
                                            Column(
                                              children: [
                                                Obx(() => Text(
                                                      (connectionController
                                                                  .userModel
                                                                  .value
                                                                  .connectionCount ??
                                                              0)
                                                          .toString(),
                                                      style: SolhTextStyles
                                                              .GreenBorderButtonText
                                                          .copyWith(
                                                              fontSize: 18),
                                                    )),
                                                Text("Connections"),
                                              ],
                                            ),
                                            // Divider(),
                                            // Column(
                                            //   children: [
                                            //     Text(
                                            //       '17',
                                            //       style:
                                            //           SolhTextStyles.GreenBorderButtonText
                                            //               .copyWith(fontSize: 18),
                                            //     ),
                                            //     Text("Reviews"),
                                            //   ],
                                            // )
                                          ],
                                        ),
                                        SizedBox(height: 3.h),
                                        SolhGreenButton(
                                            onPressed: () async {
                                              await connectionController
                                                  .addConnection(
                                                      connectionController
                                                          .userModel
                                                          .value
                                                          .sId!);
                                            },
                                            width: 90.w,
                                            height: 6.3.h,
                                            child: Text("Connect/Join")),
                                        SizedBox(height: 3.h),
                                      ],
                                    ),
                                  ]),
                                )
                              ],
                              body: TabView(),
                            );
                })
            : getUserAnalytics());
  }

  Widget getUserAnalytics() {
    return FutureBuilder<UserModel>(
        future: UserProfile.fetchUserProfile(widget._uid),
        builder: (context, userProfileSnapshot) {
          print('the data is ' + userProfileSnapshot.data.toString());
          if (userProfileSnapshot.hasData) {
            print("getUserAnalytics dfijvomdcl;;sdcp[dkasaskapskalsmclm] ");
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 2.5.h),
                        CircleAvatar(
                          radius: 6.5.h,
                          backgroundColor: Color(0xFFD9D9D9),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 6.h,
                            backgroundImage: CachedNetworkImageProvider(
                                userProfileSnapshot
                                        .requireData.profilePicture ??
                                    ""),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                userProfileSnapshot.requireData.firstName ?? "",
                                style: TextStyle(fontSize: 21)),
                            //Icon(Icons.people, color: SolhColors.grey)
                          ],
                        ),
                        // Text(
                        //   userProfileSnapshot.requireData.userType ?? "",
                        //   style: SolhTextStyles.GreenBorderButtonText,
                        // ),
                        SizedBox(height: 1.5.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Text(userProfileSnapshot.requireData.bio ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16)),
                        ),
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
                                    Obx(() => Text(
                                          connectionController
                                              .userAnalyticsModel
                                              .value
                                              .journalLikeCount
                                              .toString(),
                                          style: SolhTextStyles
                                                  .GreenBorderButtonText
                                              .copyWith(fontSize: 18),
                                        )),
                                  ],
                                ),
                                Text("Likes"),
                              ],
                            ),
                            // Divider(),
                            Column(
                              children: [
                                Obx(() => Text(
                                      connectionController.userAnalyticsModel
                                          .value.connectionCount
                                          .toString(),
                                      style:
                                          SolhTextStyles.GreenBorderButtonText
                                              .copyWith(fontSize: 18),
                                    )),
                                Text("Connections"),
                              ],
                            ),
                            // Divider(),
                            // Column(
                            //   children: [
                            //     Text(
                            //       '17',
                            //       style:
                            //           SolhTextStyles.GreenBorderButtonText
                            //               .copyWith(fontSize: 18),
                            //     ),
                            //     Text("Reviews"),
                            //   ],
                            // )
                          ],
                        ),
                        SizedBox(height: 3.h),
                        SolhGreenButton(
                            onPressed: () async {
                              await connectionController
                                  .addConnection(widget._sId);
                            },
                            width: 90.w,
                            height: 6.3.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Connect/Join")],
                            )),
                        SizedBox(height: 3.h),
                      ],
                    ),
                  ]),
                )
              ],
              body: TabView(),
            );
          } else {
            print(' No data is available');
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class TabView extends StatefulWidget {
  const TabView({
    Key? key,
  }) : super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 6.h,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            GestureDetector(
              onTap: () {
                _pageController.jumpToPage(0);
              },
              child: Text(
                "Posts",
                style: TextStyle(
                    color:
                        _currentPage == 0 ? SolhColors.green : SolhColors.grey,
                    fontSize: 20),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     _pageController.jumpToPage(1);
            //   },
            //   child: Text(
            //     "Reviews",
            //     style: TextStyle(
            //         color:
            //             _currentPage == 1 ? SolhColors.green : SolhColors.grey,
            //         fontSize: 20),
            //   ),
            // ),
          ]),
        ),
        Expanded(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              // StreamBuilder<Object>(
              //   stream: null,
              //   builder: (context, snapshot) {
              //     return ListView.builder(
              //         itemCount: 8,
              //         itemBuilder: (_, index) => Column(
              //               children: [
              //                 JournalTile(journalModel: , deletePost: () {  },),
              //                 Container(
              //                   margin: EdgeInsets.symmetric(vertical: 1.h),
              //                   height: 0.8.h,
              //                   color: Colors.green.shade400
              //                       .withOpacity(0.25)
              //                       .withAlpha(80)
              //                       .withGreen(160),
              //                 ),
              //               ],
              //             ));
              //   }
              // ),
              Container()
            ],
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
