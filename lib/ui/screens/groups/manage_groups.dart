import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/routes/routes.dart';
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
  DiscoverGroupController _groupController = Get.find();
  late final TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this)..animateTo(2);
    _groupController.tabController = tabController;
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
              controller: _groupController.tabController,
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
            'Groups'.tr,
            style: SolhTextStyles.LandingParaText,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CreateGroup();
              }));
            },
            child: Text(
              'Create Group'.tr,
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
        _groupController.tabController?.animateTo(index);
      },
      controller: _groupController.tabController,
      labelColor: SolhColors.primary_green,
      unselectedLabelColor: SolhColors.grey,
      indicatorColor: SolhColors.primary_green,
      indicatorWeight: 3,
      tabs: [
        Tab(
          text: 'Joined'.tr,
        ),
        Tab(
          text: 'Created'.tr,
        ),
        Tab(
          text: 'Discover'.tr,
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
                          Navigator.pushNamed(context, AppRoutes.groupDetails,
                              arguments: {
                                "group": groupList[index],
                                "isJoined": true,
                              });
                          /*  Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return GroupDetailsPage(
                              group: groupList[index],
                              isJoined: true,
                            );
                          })); */
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
                          Navigator.pushNamed(context, AppRoutes.groupDetails,
                              arguments: {
                                "group": groupList[index],
                                "isJoined": true,
                              });
                          /* Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return GroupDetailsPage(
                              group: groupList[index],
                              isJoined: true,
                            );
                          })); */
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
                    child: Text('No groups created yet'.tr),
                  ))
        : Center(
            child: Text('No groups created yet'.tr),
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
                          Navigator.pushNamed(context, AppRoutes.groupDetails,
                              arguments: {
                                "group": groupList[index],
                              });
                          /* Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return GroupDetailsPage(
                              group: groupList[index],
                            );
                          })); */
                        },
                        groupMediaUrl: groupList[index].groupMediaUrl,
                        groupName: groupList[index].groupName,
                        id: groupList[index].sId,
                        journalCount: groupList[index].journalCount,
                        membersCount: groupList[index].groupMembers!.length +
                            groupList[index].anonymousMembers!.length,
                      );
                    },
                  )
                : Center(
                    child: Text('new suggestions are on the way'.tr),
                  ))
        : Center(
            child: Text('new suggestions are on the way'.tr),
          );
  }
}
