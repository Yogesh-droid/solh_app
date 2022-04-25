import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/solh_search_field.dart';

class Connections extends StatelessWidget {
  Connections({Key? key}) : super(key: key);
  final ConnectionController connectionController = Get.find();

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
              await showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                      200, size.height * 0.2, size.width * 0.1, 400),
                  items: [
                    PopupMenuItem(
                      child: Text('Create Group'),
                      value: '1',
                    ),
                    PopupMenuItem(
                      child: Text('Settings'),
                      value: '2',
                    ),
                  ]);
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
                      children: [
                        CircleAvatar(
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
              )),
        ),
      ],
    );
  }

  Widget getInvitesView(BuildContext context) {
    return Obx(() => ListView.builder(
          itemCount:
              connectionController.allConnectionModel.value.connections != null
                  ? connectionController
                      .allConnectionModel.value.connections!.length
                  : 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(
                        connectionController.allConnectionModel.value
                                .connections![index].profilePicture ??
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
                        connectionController.allConnectionModel.value
                                .connections![index].name ??
                            '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: SolhColors.black34),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: Text(
                          connectionController.allConnectionModel.value
                                  .connections![index].bio ??
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
                        connectionController.isAddingConnection.value = true;
                        await connectionController.acceptConnection(
                            connectionController.allConnectionModel.value
                                .connections![index].connectionId!);
                        connectionController.isAddingConnection.value = false;
                      },
                      flag: connectionController.allConnectionModel.value
                              .connections![index].flag ??
                          ''),
                  PopupMenuButton(itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text('Create Group'),
                        value: '1',
                      ),
                      PopupMenuItem(
                        child: Text('Settings'),
                        value: '2',
                      ),
                    ];
                  })
                  // IconButton(
                  //     onPressed: () async {
                  //       await showMenu(
                  //           context: context,
                  //           position: RelativeRect.fromLTRB(
                  //               200,
                  //               MediaQuery.of(context).size.height * 0.2,
                  //               MediaQuery.of(context).size.width * 0.1,
                  //               400),
                  //           items: [
                  //             PopupMenuItem(
                  //               child: Text('Create Group'),
                  //               value: '1',
                  //             ),
                  //             PopupMenuItem(
                  //               child: Text('Settings'),
                  //               value: '2',
                  //             ),
                  //           ]);
                  //     },
                  //     icon: Icon(Icons.more_vert, color: SolhColors.grey196)),
                ],
              ),
            );
          },
        ));
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
        width: 100,
        height: 45,
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
