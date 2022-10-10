import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/ui/screens/groups/create_group.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../widgets_constants/group_card.dart';
import 'group_detail.dart';

class ManageGroupPage extends StatefulWidget {
  @override
  State<ManageGroupPage> createState() => _ManageGroupPageState();
}

class _ManageGroupPageState extends State<ManageGroupPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  DiscoverGroupController _groupController = Get.find();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this)..animateTo(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Column(
        children: [
          getTabBar(),
          Expanded(
            child: TabBarView(
              controller: tabController,
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
      onTap: (index) {
        tabController.animateTo(index);
      },
      controller: tabController,
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
                      // return getGroupCard(groupList[index], context,
                      //     isJoined: true);
                      return GroupCard(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return GroupDetailsPage(
                              group: groupList[index],
                              isJoined: true,
                            );
                          }));
                        },
                        groupMediaUrl: groupList[index].groupMediaUrl,
                        groupName: groupList[index].groupName,
                        id: groupList[index].sId,
                        journalCount: groupList[index].journalCount,
                        membersCount: groupList[index].groupMembers!.length,
                      );
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
                      // return getGroupCard(groupList[index], context,
                      //     isJoined: true);
                      return GroupCard(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return GroupDetailsPage(
                              group: groupList[index],
                              isJoined: true,
                            );
                          }));
                        },
                        groupMediaUrl: groupList[index].groupMediaUrl,
                        groupName: groupList[index].groupName,
                        id: groupList[index].sId,
                        journalCount: groupList[index].journalCount,
                        membersCount: groupList[index].groupMembers!.length,
                      );
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
                      return GroupCard(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return GroupDetailsPage(
                              group: groupList[index],
                            );
                          }));
                        },
                        groupMediaUrl: groupList[index].groupMediaUrl,
                        groupName: groupList[index].groupName,
                        id: groupList[index].sId,
                        journalCount: groupList[index].journalCount,
                        membersCount: groupList[index].groupMembers!.length,
                      );
                    },
                  )
                : Center(
                    child: Text('No groups created yet'),
                  ))
        : Center(
            child: Text('No groups created yet'),
          );
  }
}
