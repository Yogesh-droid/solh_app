import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/groups/create_group.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../widgets_constants/group_card.dart';

class ManageGroupPage extends StatefulWidget {
  @override
  State<ManageGroupPage> createState() => _ManageGroupPageState();
}

class _ManageGroupPageState extends State<ManageGroupPage>
    with SingleTickerProviderStateMixin {
  DiscoverGroupController _groupController = Get.find();
  late final TabController tabController;
  final ScrollController scrollController =
      ScrollController(); // for discoverGroupList
  final ScrollController createdGroupsScrollController =
      ScrollController(); // for createdFGroupsList
  final ScrollController joinedGroupsScrollController =
      ScrollController(); // for joinedGroupsLiat
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this)..animateTo(2);
    _groupController.tabController = tabController;
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          _groupController.loadingDiscoverGroups.value == false) {
        print("Getting more groups");
        Get.find<DiscoverGroupController>().getDiscoverGroups();
      }
    });
    createdGroupsScrollController.addListener(() {
      if (createdGroupsScrollController.position.pixels ==
              createdGroupsScrollController.position.maxScrollExtent &&
          _groupController.loadingCreatedGroups.value == false) {
        print("Getting more groups");
        Get.find<DiscoverGroupController>().getCreatedGroups();
      }
    });
    joinedGroupsScrollController.addListener(() {
      if (joinedGroupsScrollController.position.pixels ==
              joinedGroupsScrollController.position.maxScrollExtent &&
          _groupController.loadingJoinedGroups.value == false) {
        print("Getting more groups");
        Get.find<DiscoverGroupController>().getJoinedGroups();
      }
    });
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
            style: SolhTextStyles.QS_body_1_bold,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CreateGroup();
              }));
            },
            child: Text(
              'Create Group'.tr,
              style:
                  SolhTextStyles.CTA.copyWith(color: SolhColors.primary_green),
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
      labelStyle: SolhTextStyles.CTA,
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
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: joinedGroupsScrollController,
                          shrinkWrap: true,
                          itemCount: groupList.length,
                          itemBuilder: (context, index) {
                            // return getGroupCard(groupList[index], context,
                            //     isJoined: true);
                            return GroupCard(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.groupDetails,
                                    arguments: {
                                      "groupId": groupList[index].sId,
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
                              membersCount: groupList[index].groupMembers!,
                            );
                          },
                        ),
                      ),
                      Obx(() => Get.find<DiscoverGroupController>()
                              .loadingJoinedGroups
                              .value
                          ? SizedBox(
                              height: 100,
                              child: MyLoader(),
                            )
                          : const SizedBox())
                    ],
                  )
                : const Center(
                    child: Text('No groups joined yet'),
                  ))
        : const Center(
            child: Text('No groups joined yet'),
          );
  }

  createdGroupList(List<GroupList>? groupList) {
    return groupList != null
        ? Container(
            child: groupList.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: createdGroupsScrollController,
                          shrinkWrap: true,
                          itemCount: groupList.length,
                          itemBuilder: (context, index) {
                            // return getGroupCard(groupList[index], context,
                            //     isJoined: true);
                            return GroupCard(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.groupDetails,
                                    arguments: {
                                      "groupId": _groupController
                                          .createdGroupModel
                                          .value
                                          .groupList![index]
                                          .sId,
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
                              membersCount: groupList[index].groupMembers!,
                            );
                          },
                        ),
                      ),
                      Obx(() => Get.find<DiscoverGroupController>()
                              .loadingCreatedGroups
                              .value
                          ? SizedBox(
                              height: 100,
                              child: MyLoader(),
                            )
                          : const SizedBox())
                    ],
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
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: groupList.length,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return GroupCard(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.groupDetails,
                                      arguments: {
                                        "groupId": groupList[index].sId,
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
                                membersCount: groupList[index].groupMembers!);
                          },
                        ),
                      ),
                      Obx(() => Get.find<DiscoverGroupController>()
                              .loadingDiscoverGroups
                              .value
                          ? SizedBox(
                              height: 100,
                              child: MyLoader(),
                            )
                          : const SizedBox())
                    ],
                  )
                : Center(
                    child: Text('new suggestions are on the way'.tr),
                  ))
        : Center(
            child: Text('new suggestions are on the way'.tr),
          );
  }
}
