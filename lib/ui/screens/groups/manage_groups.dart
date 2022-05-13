import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/ui/screens/groups/create_group.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'dart:math' as math;

import 'group_detail.dart';

class ManageGroupPage extends StatelessWidget {
  DiscoverGroupController _groupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: getAppBar(context),
        body: Column(
          children: [
            getTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() {
                    return joinedGroupList(
                        _groupController.joinedGroupModel.value.groupList);
                  }),
                  Obx(() {
                    return createdGroupList(
                        _groupController.createdGroupModel.value.groupList);
                  }),
                  Obx(() {
                    return discoverGroupList(
                        _groupController.discoveredGroupModel.value.groupList);
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SolhAppBar getAppBar(BuildContext context) {
    return SolhAppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Groups',
            style: SolhTextStyles.LandingParaText,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CreateGroup();
              }));
            },
            child: Text(
              'Create Group',
              style: SolhTextStyles.GreenBorderButtonText,
            ),
          )
        ],
      ),
      isLandingScreen: false,
    );
  }

  Widget getTabBar() {
    return TabBar(
      labelColor: SolhColors.green,
      unselectedLabelColor: SolhColors.grey,
      indicatorColor: SolhColors.green,
      indicatorWeight: 3,
      tabs: [
        Tab(
          text: 'Joined',
        ),
        Tab(
          text: 'Created',
        ),
        Tab(
          text: 'Discover',
        ),
      ],
    );
  }

  Widget joinedGroupList(List<GroupList>? groupList) {
    return groupList != null
        ? Container(
            child: groupList.isNotEmpty
                ? ListView.builder(
                    itemCount: groupList.length,
                    itemBuilder: (context, index) {
                      return getGroupCard(groupList[index], context);
                    },
                  )
                : Center(
                    child: Text('No groups joined yet'),
                  ))
        : Center(
            child: Text('No groups joined yet'),
          );
  }

  createdGroupList(List<GroupList>? groupList) {
    return groupList != null
        ? Container(
            child: groupList.isNotEmpty
                ? ListView.builder(
                    itemCount: groupList.length,
                    itemBuilder: (context, index) {
                      return getGroupCard(groupList[index], context);
                    },
                  )
                : Center(
                    child: Text('No groups created yet'),
                  ))
        : Center(
            child: Text('No groups created yet'),
          );
  }

  discoverGroupList(List<GroupList>? groupList) {
    return groupList != null
        ? Container(
            child: groupList.isNotEmpty
                ? ListView.builder(
                    itemCount: groupList.length,
                    itemBuilder: (context, index) {
                      return getGroupCard(groupList[index], context);
                    },
                  )
                : Center(
                    child: Text('No groups created yet'),
                  ))
        : Center(
            child: Text('No groups created yet'),
          );
  }

  Widget getGroupCard(GroupList group, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return GroupDetailsPage(group: group);
            }));
          },
          child: Hero(
            tag: 'groups',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  width: double.infinity,
                  color: SolhColors.green,
                  child: Container(
                    height: 300,
                    child: CachedNetworkImage(
                        imageUrl: group.groupMediaUrl != null
                            ? group.groupMediaUrl ?? ''
                            : 'https://picsum.photos/200/300',
                        fit: BoxFit.fill),
                  )),
            ),
          ),
        ),
        // Positioned(
        //     top: 10,
        //     right: 10,
        //     child: Row(children: [
        //       Container(
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: SolhColors.black.withOpacity(0.2),
        //         ),
        //         child: Transform(
        //             alignment: Alignment.center,
        //             transform: Matrix4.rotationY(math.pi),
        //             child: Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child:
        //                   Icon(Icons.reply, color: SolhColors.white, size: 20),
        //             )),
        //       ),
        //       SizedBox(width: 10),
        //       Container(
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: SolhColors.black.withOpacity(0.2),
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Icon(Icons.share, color: SolhColors.white, size: 20),
        //         ),
        //       )
        //     ])),
        Positioned(
          left: 10,
          bottom: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group.groupName ?? '',
                style: TextStyle(
                  color: SolhColors.white,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icons/group/lock.png'),
                      SizedBox(width: 5),
                      Text(
                        group.groupType ?? '',
                        style: TextStyle(
                          color: SolhColors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('|', style: TextStyle(color: SolhColors.white)),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Image.asset('assets/icons/group/persons.png'),
                      SizedBox(width: 5),
                      Text(group.groupMembers!.length.toString() + ' members',
                          style: TextStyle(
                            color: SolhColors.white,
                            fontSize: 12,
                          )),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('|', style: TextStyle(color: SolhColors.white)),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/group/edit.png',
                      ),
                      SizedBox(width: 5),
                      Text(group.groupMembers!.length.toString() + ' posts',
                          style: TextStyle(
                            color: SolhColors.white,
                            fontSize: 12,
                          )),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
