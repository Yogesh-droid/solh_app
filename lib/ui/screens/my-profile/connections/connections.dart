import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/solh_search_field.dart';

class Connections extends StatelessWidget {
  Connections({Key? key}) : super(key: key);
  final ConnectionController connectionController = Get.find();
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 2,
        length: 3,
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
        'connection',
        style: TextStyle(
            color: SolhColors.black34,
            fontSize: 20,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget getSearchField(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          Expanded(
            child: SolhSearchField(
                hintText: 'Search',
                icon: 'assets/icons/app-bar/search.svg',
                onTap: () {}),
          ),
          IconButton(
            onPressed: () async {
              // await showMenu(
              //     context: context,
              //     position: RelativeRect.fromLTRB(
              //         200, size.height * 0.2, size.width * 0.1, 400),
              //     items: [
              //       PopupMenuItem(
              //         child: Text('Create Group'),
              //         value: '1',
              //       ),
              //       PopupMenuItem(
              //         child: Text('Settings'),
              //         value: '2',
              //       ),
              //     ]);
            },
            icon: Icon(Icons.more_vert),
            color: SolhColors.green,
          ),
        ],
      ),
    );
  }

  getConnectionTabs() {
    return TabBar(
      labelColor: SolhColors.green,
      unselectedLabelColor: SolhColors.grey,
      indicatorColor: SolhColors.green,
      indicatorWeight: 3,
      tabs: [
        Tab(
          child: Text(
            'Chats',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Tab(
          child: Text(
            'All',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Tab(
          child: Text(
            'Invites',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  getTabbarView(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          getChatsView(),
          getAllConnectionqView(),
          getInvitesView(context),
        ],
      ),
    );
  }

  Widget getChatsView() {
    return Obx(() => ListView.builder(
          itemCount:
              connectionController.myConnectionModel.value.myConnections != null
                  ? connectionController
                      .myConnectionModel.value.myConnections!.length
                  : 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // return ListTile(
            //   dense: true,
            //   contentPadding: EdgeInsets.all(0),
            //   leading: CircleAvatar(
            //     radius: 50,
            //     backgroundImage: CachedNetworkImageProvider(
            //         connectionController.myConnectionModel.value
            //                 .myConnections![index].profilePicture ??
            //             ''),
            //   ),
            //   title: Text(
            //     connectionController
            //             .myConnectionModel.value.myConnections![index].name ??
            //         '',
            //     style: TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w600,
            //         color: SolhColors.black34),
            //   ),
            //   subtitle: Text(
            //     connectionController
            //             .myConnectionModel.value.myConnections![index].bio ??
            //         '',
            //     style: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w600,
            //         color: SolhColors.grey196),
            //   ),
            // );

            return Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(
                        connectionController.myConnectionModel.value
                                .myConnections![index].profilePicture ??
                            ''),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        connectionController.myConnectionModel.value
                                .myConnections![index].name ??
                            '',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: SolhColors.black34),
                      ),
                      Text(
                        connectionController.myConnectionModel.value
                                .myConnections![index].bio ??
                            '',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: SolhColors.grey196),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }

  Widget getAllConnectionqView() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        //getConnectionFilterChips(),
        Expanded(
          child: Obx(() => ListView.builder(
                itemCount: connectionController
                            .myConnectionModel.value.myConnections !=
                        null
                    ? connectionController
                        .myConnectionModel.value.myConnections!.length
                    : 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // return ListTile(
                  //   dense: true,
                  //   contentPadding: EdgeInsets.all(0),
                  //   leading: CircleAvatar(
                  //     radius: 50,
                  //     backgroundImage: CachedNetworkImageProvider(
                  //         connectionController.myConnectionModel.value.myConnections![index].profilePicture ??
                  //             ''),
                  //   ),
                  //   title: Text(
                  //     connectionController.myConnectionModel.value
                  //             .myConnections![index].name ??
                  //         '',
                  //     style: TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w600,
                  //         color: SolhColors.black34),
                  //   ),
                  //   subtitle: Text(
                  //     connectionController.myConnectionModel.value
                  //             .myConnections![index].bio ??
                  //         '',
                  //     style: TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w600,
                  //         color: SolhColors.grey196),
                  //   ),
                  // );

                  return Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(
                              connectionController.myConnectionModel.value
                                      .myConnections![index].profilePicture ??
                                  ''),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              connectionController.myConnectionModel.value
                                      .myConnections![index].name ??
                                  '',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: SolhColors.black34),
                            ),
                            if (connectionController.myConnectionModel.value
                                    .myConnections![index].bio !=
                                null)
                              Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Text(
                                  connectionController.myConnectionModel.value
                                          .myConnections![index].bio ??
                                      '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: SolhColors.grey196),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
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
            /////////////////
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
            connectionController.sentConnections.isNotEmpty
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: MediaQuery.of(context).size.width * 0.06,
                              backgroundImage: CachedNetworkImageProvider(
                                  connectionController.sentConnections
                                          .value[index].profilePicture ??
                                      ''),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  connectionController
                                          .sentConnections.value[index].name ??
                                      '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: SolhColors.black34),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  child: Text(
                                    connectionController
                                            .sentConnections.value[index].bio ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: SolhColors.grey196),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            inviteButton(
                                callback: () async {
                                  connectionController
                                      .isAddingConnection.value = true;
                                  await connectionController.acceptConnection(
                                      connectionController.sentConnections
                                          .value[index].connectionId!,
                                      '1');
                                  connectionController
                                      .isAddingConnection.value = false;
                                },
                                flag: 'sent'),
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
                                  AutoRouter.of(context).push(
                                      ConnectScreenRouter(
                                          uid: connectionController
                                                  .sentConnections
                                                  .value[index]
                                                  .uId ??
                                              '',
                                          sId: connectionController
                                                  .sentConnections
                                                  .value[index]
                                                  .sId ??
                                              ''));
                                } else if (value == '2') {
                                  connectionController.deleteConnectionRequest(
                                    connectionController.sentConnections
                                        .value[index].connectionId!,
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      );
                    },
                    childCount:
                        connectionController.sentConnections.value.length,
                  ))
                : SliverToBoxAdapter(),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 36,
              ),
            ),
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
            connectionController.receivedConnections.isNotEmpty
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              backgroundImage: CachedNetworkImageProvider(
                                  connectionController.receivedConnections
                                          .value[index].profilePicture ??
                                      ''),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  connectionController.receivedConnections
                                          .value[index].name ??
                                      '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: SolhColors.black34),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  child: connectionController
                                              .receivedConnections
                                              .value[index]
                                              .bio !=
                                          null
                                      ? connectionController.receivedConnections
                                              .value[index].bio!.isNotEmpty
                                          ? Text(
                                              connectionController
                                                      .receivedConnections
                                                      .value[index]
                                                      .bio ??
                                                  '',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: SolhColors.grey196),
                                            )
                                          : Container()
                                      : Container(),
                                ),
                              ],
                            ),
                            Spacer(),
                            inviteButton(
                                callback: () async {
                                  connectionController
                                      .isAddingConnection.value = true;
                                  await connectionController.acceptConnection(
                                      connectionController.receivedConnections
                                          .value[index].connectionId!,
                                      '1');
                                  connectionController
                                      .isAddingConnection.value = false;
                                },
                                flag: 'received'),
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
                                  AutoRouter.of(context).push(
                                      ConnectScreenRouter(
                                          uid: connectionController
                                                  .receivedConnections
                                                  .value[index]
                                                  .uId ??
                                              '',
                                          sId: connectionController
                                                  .receivedConnections
                                                  .value[index]
                                                  .sId ??
                                              ''));
                                } else if (value == '2') {
                                  connectionController.acceptConnection(
                                      connectionController.receivedConnections
                                          .value[index].connectionId!,
                                      '0');
                                }
                              },
                            )
                          ],
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
                      return Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              backgroundImage: CachedNetworkImageProvider(
                                  connectionController.groupInvites.value[index]
                                          .groupMediaUrl ??
                                      ''),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      connectionController.groupInvites
                                              .value[index].groupName ??
                                          '',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: SolhColors.black34),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.people,
                                      color: SolhColors.grey196,
                                      size: 14,
                                    ),
                                  ],
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  child: connectionController.groupInvites
                                              .value[index].groupDescription !=
                                          null
                                      ? connectionController
                                              .groupInvites
                                              .value[index]
                                              .groupDescription!
                                              .isNotEmpty
                                          ? Text(
                                              connectionController
                                                      .groupInvites
                                                      .value[index]
                                                      .groupDescription ??
                                                  '',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: SolhColors.grey196),
                                            )
                                          : Container()
                                      : Container(),
                                ),
                              ],
                            ),
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
                                },
                                flag: 'received'),
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
                                  AutoRouter.of(context).push(
                                      ConnectScreenRouter(
                                          uid: connectionController.groupInvites
                                                  .value[index].groupId ??
                                              '',
                                          sId: connectionController.groupInvites
                                                  .value[index].groupId ??
                                              ''));
                                } else if (value == '2') {
                                  connectionController.acceptConnection(
                                      connectionController
                                          .groupInvites.value[index].inviteId!,
                                      '0');
                                }
                              },
                            )
                          ],
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
              backgroundColor: SolhColors.grey196,
              labelStyle: TextStyle(color: SolhColors.white),
              onSelected: (bool value) {},
            ),
            FilterChip(
              label: Text('Recent'),
              backgroundColor: SolhColors.grey196,
              labelStyle: TextStyle(color: SolhColors.white),
              onSelected: (bool value) {},
            ),
            FilterChip(
              label: Text('Invites'),
              backgroundColor: SolhColors.grey196,
              labelStyle: TextStyle(color: SolhColors.white),
              onSelected: (bool value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget inviteButton({required Callback callback, required String flag}) {
    return InkWell(
      onTap: () {
        callback();
      },
      child: Container(
        width: 80,
        height: 36,
        decoration: BoxDecoration(
          color: SolhColors.green,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Obx(() => connectionController.isAddingConnection.value
              ? Container(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(SolhColors.white),
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  flag == 'sent' ? 'Waiting' : 'Accept',
                  style: TextStyle(color: SolhColors.white),
                )),
        ),
      ),
    );
  }
}
