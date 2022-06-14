import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/model/user/user.dart';
import 'package:solh/services/user/user-profile.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';

class ConnectProfileScreen extends StatefulWidget {
  ConnectProfileScreen({
    Key? key,
    required String username,
  })  : _username = username,
        super(key: key);

  final String _username;

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
    await connectionController.getUserprofileData(widget._username);
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
        body: GetBuilder<ConnectionController>(
            init: connectionController,
            builder: (connectionController) {
              return connectionController.userModel.value.likes == null
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
                                      MediaQuery.of(context).size.height * 0.2,
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
                          headerSliverBuilder: (context, innerBoxIsScrolled) =>
                              [
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
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                connectionController.userModel
                                                        .value.profilePicture ??
                                                    ""),
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            connectionController.userModel.value
                                                    .firstName ??
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
                                                      connectionController
                                                          .userModel.value.likes
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
                                                  connectionController.userModel
                                                      .value.connections
                                                      .toString(),
                                                  style: SolhTextStyles
                                                          .GreenBorderButtonText
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
                                              .addConnection(
                                                  connectionController
                                                      .userModel.value.sId!);
                                        },
                                        width: 90.w,
                                        height: 6.3.h,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
            }));
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
