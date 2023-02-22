import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/chat-list/chat_list_controller.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/ui/screens/my-profile/connections/blocked_users.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../../model/group/get_group_response_model.dart';
import '../../../../routes/routes.dart';

class Connections extends StatefulWidget {
  Connections({
    Key? key,
  }) : super(key: key);

  @override
  State<Connections> createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections> {
  final ConnectionController connectionController = Get.find();

  final RefreshController _refreshController = RefreshController();

  final RefreshController _allConnectionRefreshcontroller = RefreshController();

  final DiscoverGroupController groupController = Get.find();

  final ChatListController chatListController = Get.find();

  final ProfileController profileController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      chatListController.chatListController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length:
            profileController.myProfileModel.value.body!.user!.sosChatSupport ==
                    true
                ? 4
                : 3,
        child: Scaffold(
          appBar: getAppBar(),
          body: Column(children: [
            getSearchField(context),
            getConnectionTabs(),
            getTabbarView(context)
          ]),
        ));
  }

  getAppBar() {
    return SolhAppBar(
        isLandingScreen: false,
        title: Text(
          'Connection',
          style: SolhTextStyles.QS_body_1_bold,
        ),
        menuButton: getMenuBtn());
  }

  PopupMenuButton getMenuBtn() {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: SolhColors.primary_green,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text(
              'Blocked Users',
              style: SolhTextStyles.QS_body_2_semi,
            ),
            value: 1,
          )
        ];
      },
      onSelected: (value) async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BlockedUsers()));
      },
    );
  }

  Widget getSearchField(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          // Expanded(
          //   child: SolhSearchField(
          //       hintText: 'Search',
          //       icon: 'assets/icons/app-bar/search.svg',
          //       onTap: () {}),
          // ),
          // IconButton(
          //   onPressed: () async {
          //     // await showMenu(
          //     //     context: context,
          //     //     position: RelativeRect.fromLTRB(
          //     //         200, size.height * 0.2, size.width * 0.1, 400),
          //     //     items: [
          //     //       PopupMenuItem(
          //     //         child: Text('Create Group'),
          //     //         value: '1',
          //     //       ),
          //     //       PopupMenuItem(
          //     //         child: Text('Settings'),
          //     //         value: '2',
          //     //       ),
          //     //     ]);
          //   },
          //   icon: Icon(Icons.more_vert),
          //   color: SolhColors.green,
          // ),
        ],
      ),
    );
  }

  getConnectionTabs() {
    return TabBar(
        labelColor: SolhColors.primary_green,
        unselectedLabelColor: SolhColors.grey,
        indicatorColor: SolhColors.primary_green,
        indicatorWeight: 3,
        tabs: gettabs(profileController)
        // [
        //   Tab(
        //     child: Text(
        //       'Chats',
        //       style: TextStyle(fontSize: 16),
        //     ),
        //   ),
        //   profileController.myProfileModel.value.body!.user!.sosChatSupport!
        //       ? Tab(
        //           child: Text(
        //           'Sos',
        //           style: TextStyle(fontSize: 16),
        //         ))
        //       : Container(),
        //   Tab(
        //     child: Text(
        //       'All',
        //       style: TextStyle(fontSize: 16),
        //     ),
        //   ),
        //   Tab(
        //     child: Text(
        //       'Invites',
        //       style: TextStyle(fontSize: 16),
        //     ),
        //   ),
        // ],
        );
  }

  getTabbarView(BuildContext context) {
    return Expanded(
      child: TabBarView(
          children: gettabBarViews(
        profileController: profileController,
        getChatsView: getChatsView(),
        getAllConnectionqView: getAllConnectionqView(),
        getInvitesView: getInvitesView(context),
        getSosSupportView:
            profileController.myProfileModel.value.body!.user!.sosChatSupport!
                ? getSosSupportView(chatListController, profileController)
                : Container(),
      )

          // [
          //   getChatsView(),
          //   getAllConnectionqView(),
          //   getInvitesView(context),
          //   profileController.myProfileModel.value.body!.user!.sosChatSupportc
          //       ? getSosSupportView(chatListController, profileController)
          //       : Container(),
          // ],
          ),
    );
  }

  Widget getChatsView() {
    return Container(
      child: Column(children: [
        Expanded(
          child: Obx(() => chatListController.isLoading.value
              ? Column(
                  children: [
                    CircularProgressIndicator(),
                  ],
                )
              : ListView.builder(
                  itemCount: chatListController.chatList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ChatScreen(
                        //               name: chatListController.chatList
                        //                       .value[index].user!.name ??
                        //                   '',
                        //               imageUrl: chatListController
                        //                       .chatList
                        //                       .value[index]
                        //                       .user!
                        //                       .profilePicture ??
                        //                   '',
                        //               sId: chatListController.chatList
                        //                       .value[index].user!.sId ??
                        //                   '',
                        //             )));
                        Navigator.pushNamed(context, AppRoutes.chatUser,
                            arguments: {
                              "name": profileController.myProfileModel.value
                                              .body!.user!.sosChatSupport ==
                                          true &&
                                      chatListController.chatList.value[index]
                                              .user!.nameAnonymous !=
                                          ""
                                  ? chatListController
                                      .chatList.value[index].user!.nameAnonymous
                                  : chatListController
                                          .chatList.value[index].user!.name ??
                                      '',
                              "imageUrl": profileController.myProfileModel.value
                                              .body!.user!.sosChatSupport ==
                                          true &&
                                      chatListController.chatList.value[index]
                                              .user!.profilePictureAnonymous !=
                                          ""
                                  ? chatListController.chatList.value[index]
                                      .user!.profilePictureAnonymous
                                  : chatListController.chatList.value[index]
                                          .user!.profilePicture ??
                                      '',
                              "sId": chatListController
                                      .chatList.value[index].user!.sId ??
                                  '',
                              "isAnonChat": chatListController.chatList
                                      .value[index].user!.sosChatSupportGroup!
                                  ? true
                                  : false
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius:
                                      MediaQuery.of(context).size.width * 0.06,
                                  backgroundImage: CachedNetworkImageProvider(
                                    profileController.myProfileModel.value.body!
                                                    .user!.sosChatSupport ==
                                                true &&
                                            chatListController
                                                    .chatList
                                                    .value[index]
                                                    .user!
                                                    .profilePictureAnonymous !=
                                                ""
                                        ? chatListController
                                            .chatList
                                            .value[index]
                                            .user!
                                            .profilePictureAnonymous!
                                        : chatListController
                                                .chatList
                                                .value[index]
                                                .user!
                                                .profilePicture ??
                                            '',
                                  ),
                                ),
                                // getUserImg(
                                //     img: chatListController
                                //             .chatList
                                //             .value[index]
                                //             .user!
                                //             .profilePicture ??
                                //         '',
                                //     context: context,
                                //     sId: chatListController
                                //             .chatList.value[index].user!.sId ??
                                //         '',
                                //     uid: chatListController
                                //         .chatList.value[index].user!.uid),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 60.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          profileController
                                                          .myProfileModel
                                                          .value
                                                          .body!
                                                          .user!
                                                          .sosChatSupport ==
                                                      true &&
                                                  chatListController
                                                          .chatList
                                                          .value[index]
                                                          .user!
                                                          .nameAnonymous !=
                                                      ""
                                              ? chatListController
                                                  .chatList
                                                  .value[index]
                                                  .user!
                                                  .nameAnonymous!
                                              : chatListController
                                                      .chatList
                                                      .value[index]
                                                      .user!
                                                      .name ??
                                                  '',
                                          style: GoogleFonts.signika(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        chatListController.chatList.value[index]
                                            .conversation!.body!,
                                        style: GoogleFonts.signika(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                                // chatListController.chatList.value[index]
                                //     .conversation!.dateTime!
                                //     .toString(),
                                DateTime.tryParse(chatListController
                                            .chatList
                                            .value[index]
                                            .conversation!
                                            .dateTime!
                                            .toString()) !=
                                        null
                                    ? DateFormat('hh:mm a').format(
                                        DateTime.parse(chatListController
                                            .chatList
                                            .value[index]
                                            .conversation!
                                            .dateTime!
                                            .toString()))
                                    : '',
                                style: GoogleFonts.signika(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14))
                          ],
                        ),
                      ),
                    );
                  },
                )),
        )
      ]),
    );

    // return Obx(() => ListView.builder(
    //       itemCount:
    //           connectionController.myConnectionModel.value.myConnections != null
    //               ? connectionController
    //                   .myConnectionModel.value.myConnections!.length
    //               : 0,
    //       shrinkWrap: true,
    //       itemBuilder: (context, index) {
    //         // return ListTile(
    //         //   dense: true,
    //         //   contentPadding: EdgeInsets.all(0),
    //         //   leading: CircleAvatar(
    //         //     radius: 50,
    //         //     backgroundImage: CachedNetworkImageProvider(
    //         //         connectionController.myConnectionModel.value
    //         //                 .myConnections![index].profilePicture ??
    //         //             ''),
    //         //   ),
    //         //   title: Text(
    //         //     connectionController
    //         //             .myConnectionModel.value.myConnections![index].name ??
    //         //         '',
    //         //     style: TextStyle(
    //         //         fontSize: 18,
    //         //         fontWeight: FontWeight.w600,
    //         //         color: SolhColors.black34),
    //         //   ),
    //         //   subtitle: Text(
    //         //     connectionController
    //         //             .myConnectionModel.value.myConnections![index].bio ??
    //         //         '',
    //         //     style: TextStyle(
    //         //         fontSize: 14,
    //         //         fontWeight: FontWeight.w600,
    //         //         color: SolhColors.grey196),
    //         //   ),
    //         // );

    //         return Container(
    //           padding: EdgeInsets.all(10),
    //           width: MediaQuery.of(context).size.width,
    //           child: Row(
    //             children: [
    //               CircleAvatar(
    //                 backgroundColor: Colors.white,
    //                 radius: 30,
    //                 backgroundImage: CachedNetworkImageProvider(
    //                     connectionController.myConnectionModel.value
    //                             .myConnections![index].profilePicture ??
    //                         ''),
    //               ),
    //               SizedBox(
    //                 width: 10,
    //               ),
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Container(
    //                     width: MediaQuery.of(context).size.width * 0.6,
    //                     child: Text(
    //                       connectionController.myConnectionModel.value
    //                               .myConnections![index].name ??
    //                           '',
    //                       style: TextStyle(
    //                           fontSize: 18,
    //                           fontWeight: FontWeight.w600,
    //                           color: SolhColors.black34),
    //                     ),
    //                   ),
    //                   Container(
    //                     width: MediaQuery.of(context).size.width * 0.6,
    //                     child: Text(
    //                       connectionController.myConnectionModel.value
    //                               .myConnections![index].bio ??
    //                           '',
    //                       overflow: TextOverflow.ellipsis,
    //                       style: TextStyle(
    //                           fontSize: 14,
    //                           fontWeight: FontWeight.w600,
    //                           color: SolhColors.grey196),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         );
    //       },
    //     ));
  }

  Widget getAllConnectionqView() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        //getConnectionFilterChips(),
        Expanded(
          child: Obx(() => SmartRefresher(
                controller: _allConnectionRefreshcontroller,
                onRefresh: () async {
                  await connectionController.getMyConnection();

                  _allConnectionRefreshcontroller.refreshCompleted();
                },
                child: ListView.builder(
                  itemCount: connectionController
                              .myConnectionModel.value.myConnections !=
                          null
                      ? connectionController
                          .myConnectionModel.value.myConnections!.length
                      : 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.chatUser,
                            arguments: {
                              "name": connectionController.myConnectionModel
                                      .value.myConnections![index].name ??
                                  '',
                              "imageUrl": connectionController
                                      .myConnectionModel
                                      .value
                                      .myConnections![index]
                                      .profilePicture ??
                                  '',
                              "sId": connectionController.myConnectionModel
                                      .value.myConnections![index].sId ??
                                  '',
                            });
                        ;
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            getUserImg(
                                img: connectionController
                                        .myConnectionModel
                                        .value
                                        .myConnections![index]
                                        .profilePicture ??
                                    '',
                                context: context,
                                sId: connectionController.myConnectionModel
                                        .value.myConnections![index].sId ??
                                    '',
                                uid: connectionController.myConnectionModel
                                        .value.myConnections![index].uId ??
                                    ''),
                            SizedBox(
                              width: 10,
                            ),
                            getUserTitle(
                                context: context,
                                name: connectionController.myConnectionModel
                                        .value.myConnections![index].name ??
                                    '',
                                bio: connectionController.myConnectionModel
                                    .value.myConnections![index].bio),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )),
        ),
      ],
    );
  }

  Widget getInvitesView(BuildContext context) {
    return Obx(() {
      return SmartRefresher(
        controller: _refreshController,
        onRefresh: () async {
          await connectionController.getAllConnection();
          connectionController.receivedConnections.refresh();
          connectionController.sentConnections.refresh();
          _refreshController.refreshCompleted();
        },
        child: CustomScrollView(
          slivers: [
            /// this is just space ///
            SliverToBoxAdapter(
              child: SizedBox(
                height:
                    connectionController.sentConnections.isNotEmpty ? 20 : 0,
              ),
            ),
            /////////////////  ------ sent connections title  ------ /////////////////
            connectionController.sentConnections.isNotEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 8),
                      child: Text(
                        'sent',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: SolhColors.black34),
                      ),
                    ),
                  )
                : SliverToBoxAdapter(),
            SliverToBoxAdapter(
              child: SizedBox(
                height:
                    connectionController.sentConnections.isNotEmpty ? 16 : 0,
              ),
            ),

            ////////////    sent connections List   //////////////
            ///
            connectionController.sentConnections.isNotEmpty
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ConnectProfileScreen(
                          //             uid: connectionController.sentConnections
                          //                     .value[index].uId ??
                          //                 '',
                          //             sId: connectionController.sentConnections
                          //                     .value[index].sId ??
                          //                 '')));
                          Navigator.pushNamed(context, AppRoutes.connectScreen,
                              arguments: {
                                "uid": connectionController
                                        .sentConnections.value[index].uId ??
                                    '',
                                "sId": connectionController
                                        .sentConnections.value[index].sId ??
                                    ''
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              // CircleAvatar(
                              //   backgroundColor: Colors.white,
                              //   radius: MediaQuery.of(context).size.width * 0.06,
                              //   backgroundImage: CachedNetworkImageProvider(
                              //       connectionController.sentConnections
                              //               .value[index].profilePicture ??
                              //           ''),
                              // ),
                              getUserImg(
                                  img: connectionController.sentConnections
                                          .value[index].profilePicture ??
                                      '',
                                  uid: connectionController
                                          .sentConnections.value[index].uId ??
                                      '',
                                  sId: connectionController
                                          .sentConnections.value[index].sId ??
                                      '',
                                  context: context),
                              SizedBox(
                                width: 10,
                              ),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       connectionController
                              //               .sentConnections.value[index].name ??
                              //           '',
                              //       overflow: TextOverflow.ellipsis,
                              //       style: TextStyle(
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.w600,
                              //           color: SolhColors.black34),
                              //     ),
                              //     Container(
                              //       width:
                              //           MediaQuery.of(context).size.width * 0.30,
                              //       child: Text(
                              //         connectionController
                              //                 .sentConnections.value[index].bio ??
                              //             '',
                              //         overflow: TextOverflow.ellipsis,
                              //         style: TextStyle(
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.w600,
                              //             color: SolhColors.grey196),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              Expanded(
                                child: getUserTitle(
                                    context: context,
                                    name: connectionController.sentConnections
                                            .value[index].name ??
                                        '',
                                    bio: connectionController
                                        .sentConnections.value[index].bio),
                              ),

                              inviteButton(
                                callback: () async {
                                  connectionController
                                      .isAddingConnection.value = true;
                                  () {};
                                  connectionController
                                      .isAddingConnection.value = false;
                                },
                                flag: 'sent',
                                id: connectionController
                                    .sentConnections.value[index].connectionId!,
                              ),

                              PopupMenuButton(
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      child: Text('See Profile'),
                                      value: '1',
                                    ),
                                    PopupMenuItem(
                                      child: Text('Cancel'),
                                      value: '2',
                                    ),
                                  ];
                                },
                                onSelected: (value) async {
                                  if (value == '1') {
                                    connectionController.getUserAnalytics(
                                        connectionController.sentConnections
                                                .value[index].sId ??
                                            '');
                                    Navigator.pushNamed(
                                        context, AppRoutes.connectScreen,
                                        arguments: {
                                          "uid": connectionController
                                                  .sentConnections
                                                  .value[index]
                                                  .uId ??
                                              '',
                                          "sId": connectionController
                                                  .sentConnections
                                                  .value[index]
                                                  .sId ??
                                              ''
                                        });
                                  } else if (value == '2') {
                                    connectionController
                                        .isCancelingConnection.value = true;
                                    connectionController.canceledConnectionId
                                        .value = connectionController
                                            .sentConnections
                                            .value[index]
                                            .connectionId ??
                                        '';
                                    await connectionController
                                        .deleteConnectionRequest(
                                      connectionController.sentConnections
                                          .value[index].connectionId!,
                                    );
                                    connectionController
                                        .isCancelingConnection.value = false;
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    childCount:
                        connectionController.sentConnections.value.length,
                  ))
                : SliverToBoxAdapter(),
            ///////////////////////////////////////////
            ///
            SliverToBoxAdapter(
              child: SizedBox(
                height: 36,
              ),
            ),

            ////////  received connections  Title  //////////////
            ///

            connectionController.receivedConnections.isNotEmpty ||
                    connectionController.groupInvites.isNotEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 8),
                      child: Text(
                        'received',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: SolhColors.black34),
                      ),
                    ),
                  )
                : SliverToBoxAdapter(),

            /////////////  received connections list  //////////////
            ///
            connectionController.receivedConnections.isNotEmpty
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ConnectProfileScreen(
                          //             uid: connectionController
                          //                     .receivedConnections
                          //                     .value[index]
                          //                     .uId ??
                          //                 '',
                          //             sId: connectionController
                          //                     .receivedConnections
                          //                     .value[index]
                          //                     .sId ??
                          //                 '')));
                          Navigator.pushNamed(context, AppRoutes.connectScreen,
                              arguments: {
                                "uid": connectionController
                                        .sentConnections.value[index].uId ??
                                    '',
                                "sId": connectionController
                                        .sentConnections.value[index].sId ??
                                    ''
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              // CircleAvatar(
                              //   backgroundColor: Colors.white,
                              //   radius: 30,
                              //   backgroundImage: CachedNetworkImageProvider(
                              //       connectionController.receivedConnections
                              //               .value[index].profilePicture ??
                              //           ''),
                              // ),
                              getUserImg(
                                  img: connectionController.receivedConnections
                                          .value[index].profilePicture ??
                                      '',
                                  uid: connectionController.receivedConnections
                                          .value[index].uId ??
                                      '',
                                  sId: connectionController.receivedConnections
                                          .value[index].sId ??
                                      '',
                                  context: context),
                              SizedBox(
                                width: 10,
                              ),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       connectionController.receivedConnections
                              //               .value[index].name ??
                              //           '',
                              //       overflow: TextOverflow.ellipsis,
                              //       style: TextStyle(
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.w600,
                              //           color: SolhColors.black34),
                              //     ),
                              //     Container(
                              //       width:
                              //           MediaQuery.of(context).size.width * 0.30,
                              //       child: connectionController
                              //                   .receivedConnections
                              //                   .value[index]
                              //                   .bio !=
                              //               null
                              //           ? connectionController.receivedConnections
                              //                   .value[index].bio!.isNotEmpty
                              //               ? Text(
                              //                   connectionController
                              //                           .receivedConnections
                              //                           .value[index]
                              //                           .bio ??
                              //                       '',
                              //                   overflow: TextOverflow.ellipsis,
                              //                   style: TextStyle(
                              //                       fontSize: 14,
                              //                       fontWeight: FontWeight.w500,
                              //                       color: SolhColors.grey196),
                              //                 )
                              //               : Container()
                              //           : Container(),
                              //     ),
                              //   ],
                              // ),
                              getUserTitle(
                                  context: context,
                                  name: connectionController.receivedConnections
                                          .value[index].name ??
                                      '',
                                  bio: connectionController
                                      .receivedConnections.value[index].bio),
                              Spacer(),
                              inviteButton(
                                  callback: () async {
                                    if (ifMinor(profileController.myProfileModel
                                            .value.body!.user!.dob ??
                                        '')) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return cancelAcceptAlertDialog(
                                                connectionController:
                                                    connectionController,
                                                index: index,
                                                context: context);
                                          });
                                    } else {
                                      connectionController
                                          .isAddingConnection.value = true;
                                      connectionController.addingConnectionId
                                          .value = connectionController
                                              .receivedConnections
                                              .value[index]
                                              .connectionId ??
                                          '';
                                      await connectionController
                                          .acceptConnection(
                                              connectionController
                                                  .receivedConnections
                                                  .value[index]
                                                  .connectionId!,
                                              '1');
                                      connectionController
                                          .isAddingConnection.value = false;
                                    }
                                  },
                                  flag: 'received',
                                  id: connectionController.receivedConnections
                                      .value[index].connectionId),
                              PopupMenuButton(
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      child: Text('See Profile'),
                                      value: '1',
                                    ),
                                    PopupMenuItem(
                                      child: Text('Decline'),
                                      value: '2',
                                    ),
                                  ];
                                },
                                onSelected: (value) async {
                                  if (value == '1') {
                                    Navigator.pushNamed(
                                        context, AppRoutes.connectScreen,
                                        arguments: {
                                          "uid": connectionController
                                                  .receivedConnections
                                                  .value[index]
                                                  .uId ??
                                              '',
                                          "sId": connectionController
                                                  .receivedConnections
                                                  .value[index]
                                                  .sId ??
                                              ''
                                        });
                                  } else if (value == '2') {
                                    connectionController
                                        .isDecliningConnection.value = true;
                                    connectionController.declinedConnectionId
                                        .value = connectionController
                                            .receivedConnections
                                            .value[index]
                                            .connectionId ??
                                        '';
                                    await connectionController.acceptConnection(
                                        connectionController.receivedConnections
                                            .value[index].connectionId!,
                                        '0');
                                    connectionController
                                        .isDecliningConnection.value = false;
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    childCount:
                        connectionController.receivedConnections.value.length,
                  ))
                : SliverToBoxAdapter(),

            /////////////   --------  this is for groups --------  //////////////

            connectionController.groupInvites.isNotEmpty
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              // CircleAvatar(
                              //   backgroundColor: Colors.white,
                              //   radius: 30,
                              //   backgroundImage: connectionController.groupInvites
                              //               .value[index].groupMediaUrl !=
                              //           null
                              //       ? CachedNetworkImageProvider(
                              //           connectionController.groupInvites
                              //                   .value[index].groupMediaUrl ??
                              //               '')
                              //       : AssetImage(
                              //               'assets/images/group_placeholder.png')
                              //           as ImageProvider,
                              // ),
                              getUserImg(
                                  img: connectionController.groupInvites
                                          .value[index].groupMediaUrl ??
                                      '',
                                  context: context,
                                  sId: connectionController
                                          .groupInvites.value[index].groupId ??
                                      '',
                                  isGroup: true,
                                  groupMediaUrl: connectionController
                                      .groupInvites.value[index].groupMediaUrl,
                                  groupName: connectionController.groupInvites
                                          .value[index].groupName ??
                                      ''),
                              SizedBox(
                                width: 10,
                              ),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Text(
                              //           connectionController.groupInvites
                              //                   .value[index].groupName ??
                              //               '',
                              //           overflow: TextOverflow.ellipsis,
                              //           style: TextStyle(
                              //               fontSize: 15,
                              //               fontWeight: FontWeight.w600,
                              //               color: SolhColors.black34),
                              //         ),
                              //         SizedBox(
                              //           width: 10,
                              //         ),
                              //         Icon(
                              //           Icons.people,
                              //           color: SolhColors.grey196,
                              //           size: 14,
                              //         ),
                              //       ],
                              //     ),
                              //     Container(
                              //       width:
                              //           MediaQuery.of(context).size.width * 0.30,
                              //       child: connectionController.groupInvites
                              //                   .value[index].groupDescription !=
                              //               null
                              //           ? connectionController
                              //                   .groupInvites
                              //                   .value[index]
                              //                   .groupDescription!
                              //                   .isNotEmpty
                              //               ? Text(
                              //                   connectionController
                              //                           .groupInvites
                              //                           .value[index]
                              //                           .groupDescription ??
                              //                       '',
                              //                   overflow: TextOverflow.ellipsis,
                              //                   style: TextStyle(
                              //                       fontSize: 14,
                              //                       fontWeight: FontWeight.w500,
                              //                       color: SolhColors.grey196),
                              //                 )
                              //               : Container()
                              //           : Container(),
                              //     ),
                              //   ],
                              // ),
                              getUserTitle(
                                  context: context,
                                  name: connectionController.groupInvites
                                          .value[index].groupName ??
                                      '',
                                  bio: connectionController.groupInvites
                                      .value[index].groupDescription),
                              Spacer(),
                              inviteButton(
                                  callback: () async {
                                    connectionController
                                        .isAddingConnection.value = true;
                                    await connectionController
                                        .acceptConnectionFromGroup(
                                      connectionController
                                          .groupInvites.value[index].inviteId!,
                                    );
                                    connectionController
                                        .isAddingConnection.value = false;
                                    groupController.getJoinedGroups();
                                    groupController.getDiscoverGroups();
                                  },
                                  flag: 'received',
                                  id: connectionController
                                      .groupInvites.value[index].inviteId),
                              PopupMenuButton(
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      child: Text('See Profile'),
                                      value: '1',
                                    ),
                                    PopupMenuItem(
                                      child: Text('Decline'),
                                      value: '2',
                                    ),
                                  ];
                                },
                                onSelected: (value) {
                                  if (value == '1') {
                                    Navigator.pushNamed(
                                        context, AppRoutes.connectScreen,
                                        arguments: {
                                          "uid": connectionController
                                                  .receivedConnections
                                                  .value[index]
                                                  .uId ??
                                              '',
                                          "sId": connectionController
                                                  .receivedConnections
                                                  .value[index]
                                                  .sId ??
                                              ''
                                        });
                                  } else if (value == '2') {
                                    connectionController.acceptConnection(
                                        connectionController.groupInvites
                                            .value[index].inviteId!,
                                        '0');
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: connectionController.groupInvites.value.length,
                  ))
                : SliverToBoxAdapter(),
          ],
        ),
      );
    });
  }

  Widget getConnectionFilterChips() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilterChip(
              label: Text('All'),
              backgroundColor: SolhColors.grey_2,
              labelStyle: TextStyle(color: SolhColors.white),
              onSelected: (bool value) {},
            ),
            FilterChip(
              label: Text('Recent'),
              backgroundColor: SolhColors.grey_2,
              labelStyle: TextStyle(color: SolhColors.white),
              onSelected: (bool value) {},
            ),
            FilterChip(
              label: Text('Invites'),
              backgroundColor: SolhColors.grey_2,
              labelStyle: TextStyle(color: SolhColors.white),
              onSelected: (bool value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget inviteButton(
      {required Callback callback, required String flag, String? id}) {
    return InkWell(
      onTap: () {
        callback();
      },
      child: Container(
        width: 80,
        height: 36,
        decoration: BoxDecoration(
          color: SolhColors.primary_green,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Obx(() {
            return (connectionController.isAddingConnection.value &&
                        flag == 'received' &&
                        id == connectionController.addingConnectionId.value) ||

                    /// this is case when acccept connections
                    (connectionController.isDecliningConnection.value &&
                        flag == 'received' &&
                        id ==
                            connectionController.declinedConnectionId.value) ||

                    /// this is case when decline connections
                    (connectionController.isCancelingConnection.value &&
                        flag == 'sent' &&
                        id == connectionController.canceledConnectionId.value)
                ? Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      ///  this is for the progress indicator when adding connection
                      valueColor:
                          AlwaysStoppedAnimation<Color>(SolhColors.white),
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    flag == 'sent' ? 'Waiting' : 'Accept',
                    style: TextStyle(color: SolhColors.white),
                  );
          }),
        ),
      ),
    );
  }

  Widget getUserImg({
    String? img,
    String? uid,
    String? sId,
    required BuildContext context,
    bool? isGroup,
    String? groupName,
    String? groupMediaUrl,
  }) {
    print(sId);
    return InkWell(
      onTap: isGroup == null
          ? () {
              connectionController.getUserAnalytics(sId!);
              print(sId);
              print(uid);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             ConnectProfileScreen(uid: uid!, sId: sId)));
              Navigator.pushNamed(context, AppRoutes.connectScreen,
                  arguments: {"sId": sId, "uid": uid});
            }
          : () {
              Navigator.pushNamed(context, AppRoutes.groupDetails, arguments: {
                "group": GroupList(
                  sId: sId,
                  groupName: groupName,
                  groupMediaUrl: groupMediaUrl,
                ),
              });
              /* Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GroupDetailsPage(
                  ///// this case is for group journal
                  group: GroupList(
                    sId: sId,
                    groupName: groupName,
                    groupMediaUrl: groupMediaUrl,
                  ),
                );
              })); */
            },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 30,
        backgroundImage: isGroup != null
            ? groupMediaUrl != null
                ? CachedNetworkImageProvider(groupMediaUrl)
                : AssetImage('assets/images/group_placeholder.png')
                    as ImageProvider
            : CachedNetworkImageProvider(img ?? ''),
      ),
    );
  }

  Widget getUserTitle(
      {required BuildContext context, required String name, String? bio}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: SolhColors.black34),
          ),
        ),
        if (bio != null)
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              bio,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: SolhColors.grey_2),
            ),
          ),
      ],
    );
  }
}

bool ifMinor(String dob) {
  DateTime birthDate = DateTime.parse(dob);

  if (DateTime.now().year - birthDate.year < 18) {
    return true;
  } else if (DateTime.now().year - birthDate.year == 18) {
    if (DateTime.now().month < birthDate.month) {
      return DateTime.now().month < birthDate.month;
    } else if (DateTime.now().month == birthDate.month) {
      return DateTime.now().day <= birthDate.day;
    }
  }
  return false;
}

AlertDialog cancelAcceptAlertDialog(
    {context, required ConnectionController connectionController, index}) {
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 2.h,
        ),
        Icon(
          CupertinoIcons.exclamationmark_triangle_fill,
          color: Color(0xffFFA0A4),
          size: 41,
        ),
        SizedBox(
          height: 2.h,
        ),
        RichText(
            text: TextSpan(
                text: 'Disclaimer : ',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                children: <TextSpan>[
              TextSpan(
                text: 'Please accept connection requests of known persons only',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: SolhColors.grey),
              )
            ])),
        SizedBox(
          height: 4.h,
        ),
        Row(
          children: [
            SolhGreenBorderMiniButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: SolhTextStyles.CTA.copyWith(color: SolhColors.black),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            SolhGreenMiniButton(
              onPressed: () async {
                connectionController.isAddingConnection.value = true;
                connectionController.addingConnectionId.value =
                    connectionController
                            .receivedConnections.value[index].connectionId ??
                        '';
                await connectionController.acceptConnection(
                    connectionController
                        .receivedConnections.value[index].connectionId!,
                    '1');
                connectionController.isAddingConnection.value = false;
                Navigator.of(context).pop();
              },
              child: Obx(() {
                return connectionController.isAddingConnection.value
                    ? Padding(
                        padding: EdgeInsets.all(1.w),
                        child: MyLoader(),
                      )
                    : Text(
                        'Accept',
                        style: SolhTextStyles.CTA
                            .copyWith(color: SolhColors.white),
                      );
              }),
            )
          ],
        )
      ],
    ),
  );
}

Widget getSosSupportView(
    ChatListController chatListController, profileController) {
  return Container(
    child: Column(children: [
      Expanded(
        child: Obx(() => chatListController.isLoading.value
            ? Column(
                children: [
                  CircularProgressIndicator(),
                ],
              )
            : ListView.builder(
                itemCount: chatListController.sosChatList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ChatScreen(
                      //               name: chatListController.chatList
                      //                       .value[index].user!.name ??
                      //                   '',
                      //               imageUrl: chatListController
                      //                       .chatList
                      //                       .value[index]
                      //                       .user!
                      //                       .profilePicture ??
                      //                   '',
                      //               sId: chatListController.chatList
                      //                       .value[index].user!.sId ??
                      //                   '',
                      //             )));
                      Navigator.pushNamed(context, AppRoutes.chatUser,
                          arguments: {
                            "name": profileController.myProfileModel.value.body!
                                            .user!.sosChatSupport ==
                                        true &&
                                    chatListController.sosChatList.value[index]
                                            .user!.nameAnonymous! !=
                                        ""
                                ? '${chatListController.sosChatList.value[index].user!.nameAnonymous} (${chatListController.sosChatList.value[index].user!.name!})'
                                : chatListController
                                        .sosChatList.value[index].user!.name ??
                                    '',
                            "imageUrl": profileController.myProfileModel.value
                                            .body!.user!.sosChatSupport ==
                                        true &&
                                    chatListController.sosChatList.value[index]
                                            .user!.profilePictureAnonymous !=
                                        ""
                                ? chatListController.sosChatList.value[index]
                                    .user!.profilePictureAnonymous
                                : chatListController.sosChatList.value[index]
                                        .user!.profilePicture ??
                                    '',
                            "sId": chatListController
                                    .sosChatList.value[index].user!.sId ??
                                '',
                            "isAnonChat": true,
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius:
                                    MediaQuery.of(context).size.width * 0.06,
                                backgroundImage: CachedNetworkImageProvider(
                                  profileController.myProfileModel.value.body!
                                                  .user!.sosChatSupport ==
                                              true &&
                                          chatListController
                                                  .sosChatList
                                                  .value[index]
                                                  .user!
                                                  .profilePictureAnonymous !=
                                              ""
                                      ? chatListController
                                          .sosChatList
                                          .value[index]
                                          .user!
                                          .profilePictureAnonymous!
                                      : chatListController
                                              .sosChatList
                                              .value[index]
                                              .user!
                                              .profilePicture ??
                                          '',
                                ),
                              ),
                              // getUserImg(
                              //     img: chatListController
                              //             .chatList
                              //             .value[index]
                              //             .user!
                              //             .profilePicture ??
                              //         '',
                              //     context: context,
                              //     sId: chatListController
                              //             .chatList.value[index].user!.sId ??
                              //         '',
                              //     uid: chatListController
                              //         .chatList.value[index].user!.uid),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 60.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        profileController
                                                        .myProfileModel
                                                        .value
                                                        .body!
                                                        .user!
                                                        .sosChatSupport ==
                                                    true &&
                                                chatListController
                                                        .sosChatList
                                                        .value[index]
                                                        .user!
                                                        .nameAnonymous !=
                                                    ""
                                            ? chatListController
                                                    .sosChatList
                                                    .value[index]
                                                    .user!
                                                    .nameAnonymous! +
                                                " (${chatListController.sosChatList.value[index].user!.name!})"
                                            : chatListController.sosChatList
                                                    .value[index].user!.name ??
                                                '',
                                        style: GoogleFonts.signika(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      chatListController.sosChatList
                                          .value[index].conversation!.body!,
                                      style: GoogleFonts.signika(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                              // chatListController.chatList.value[index]
                              //     .conversation!.dateTime!
                              //     .toString(),
                              DateTime.tryParse(chatListController.sosChatList
                                          .value[index].conversation!.dateTime!
                                          .toString()) !=
                                      null
                                  ? DateFormat('hh:mm a').format(DateTime.parse(
                                      chatListController.sosChatList
                                          .value[index].conversation!.dateTime!
                                          .toString()))
                                  : '',
                              style: GoogleFonts.signika(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14))
                        ],
                      ),
                    ),
                  );
                },
              )),
      )
    ]),
  );
}

List<Tab> gettabs(ProfileController profileController) {
  List tabsString = ['Chats', 'All', 'Invites', 'Now'];
  List<Tab> tabs = <Tab>[];
  int getTabNumber() {
    return profileController.myProfileModel.value.body!.user!.sosChatSupport!
        ? 3
        : 2;
  }

  for (int i = 0; i <= getTabNumber(); i++) {
    tabs.add(Tab(
        child: Text(
      tabsString[i],
      style: TextStyle(fontSize: 16),
    )));
  }

  return tabs;
}

List<Widget> gettabBarViews(
    {required ProfileController profileController,
    required Widget getChatsView,
    required Widget getAllConnectionqView,
    required Widget getInvitesView,
    required Widget getSosSupportView}) {
  List<Widget> tabsViews = [
    getChatsView,
    getAllConnectionqView,
    getInvitesView,
    getSosSupportView
  ];

  List<Widget> tabWidget = <Widget>[];
  int getTabNumber() {
    return profileController.myProfileModel.value.body!.user!.sosChatSupport!
        ? 3
        : 2;
  }

  for (int i = 0; i <= getTabNumber(); i++) {
    tabWidget.add(tabsViews[i]);
  }

  return tabWidget;
}
