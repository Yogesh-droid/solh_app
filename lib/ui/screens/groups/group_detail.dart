import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/group/create_group_controller.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/dynamic_link_sevice/dynamic_link_provider.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/journaling/side_drawer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../bottom-navigation/bottom_navigator_controller.dart';
import '../journaling/create-journal.dart';
import '../my-goals/my-goals-screen.dart';

class GroupDetailsPage extends StatefulWidget {
  GroupDetailsPage({Key? key, Map<dynamic, dynamic>? args})
      : groupId = args!['groupId'],
        isJoined = args['isJoined'];

  final String groupId;
  bool? isJoined;
  @override
  State<GroupDetailsPage> createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  // late GroupList groupList;
  late bool? isJoined;
  late bool isDefaultAdmin = false;
  JournalPageController journalPageController = Get.find();
  ConnectionController connectionController = Get.find();
  CreateGroupController createGroupController = Get.find();
  DiscoverGroupController discoverGroupController = Get.find();
  BottomNavigatorController _bottomNavigatorController = Get.find();
  ProfileController profileController = Get.find();
  ScrollController groupDetailScrollController = ScrollController();
  int pageNo = 1;

  @override
  void initState() {
    // groupList = widget.group;
    isJoined = widget.isJoined;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        log("${widget.isJoined}");

        getGroupDetails(1);

        if (widget.isJoined == null) {
          discoverGroupController.joinedGroupModel.value.groupList != null
              ? discoverGroupController.joinedGroupModel.value.groupList!
                  .forEach((element) {
                  if (element.sId == widget.groupId) {
                    isJoined = true;
                  }
                })
              : null;
        }
        getMoreGroupMembers();
      },
    );

    super.initState();
  }

  getMoreGroupMembers() {
    groupDetailScrollController.addListener(() {
      if (groupDetailScrollController.position.pixels ==
              groupDetailScrollController.position.maxScrollExtent &&
          discoverGroupController.groupDetailModel.value.pagesForMember!.next !=
              null) {
        print('fetching');
        discoverGroupController.isLoadingMoreGroupMembers(true);
        pageNo++;
        discoverGroupController.getGroupDetail(widget.groupId, pageNo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: SingleChildScrollView(
          controller: groupDetailScrollController,
          child: Obx(() {
            return discoverGroupController.isDeletingGroup.value ||
                    discoverGroupController.isLoading.value
                ? Center(child: MyLoader())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          getGroupImg(),
                          Obx(() {
                            return discoverGroupController.isLoading.value
                                ? Container()
                                : getGroupInfo(context);
                          }),
                          Positioned(
                              right: 10,
                              bottom: 10,
                              child: GetShareButton(
                                  groupId: widget.groupId,
                                  groupName: discoverGroupController
                                          .groupDetailModel
                                          .value
                                          .groupList!
                                          .groupName ??
                                      '')),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        return discoverGroupController.isLoading.value
                            ? Container()
                            : getPostButton(context);
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return discoverGroupController.isLoading.value
                            ? Container()
                            : getGroupDesc();
                      }),
                      Divider(),
                      Obx(() {
                        return discoverGroupController.isLoading.value
                            ? Container()
                            : getMembersList(context);
                      }),
                      discoverGroupController.isLoadingMoreGroupMembers.value
                          ? MyLoader()
                          : Container(),
                    ],
                  );
          })),
    );
  }

  Widget getShimmer() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SolhAppBar getAppBar(BuildContext context) {
    return SolhAppBar(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.55,
          child: Text(
            'Group Detail'
            // + '(${groupList.groupType})',
            ,
            style: SolhTextStyles.QS_body_1_bold,
          ),
        ),
        // groupList.groupMembers != null
        //     ?
        isDefaultAdmin || isJoined != null && isJoined!
            ? getPopUpMenuBtn(context)
            : Container()
        // : Container()
        // : Obx(() {
        //     return discoverGroupController.isLoading.value
        //         ? Container()
        //         // : getPopUpMenuBtn(context);
        //         : Container();
        //   })
      ]),
      isLandingScreen: false,
    );
  }

  Widget getGroupInfo(BuildContext context) {
    return Obx(() {
      return discoverGroupController.isLoading.value
          ? MyLoader()
          : Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.4),
                      Colors.transparent
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        discoverGroupController
                                .groupDetailModel.value.groupList!.groupName ??
                            '',
                        style: SolhTextStyles.QS_big_body.copyWith(
                            color: SolhColors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.public,
                                color: SolhColors.white,
                                size: 10,
                              ),
                              SizedBox(width: 5),
                              Text(
                                discoverGroupController.groupDetailModel.value
                                        .groupList!.groupType ??
                                    '',
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
                              Icon(
                                CupertinoIcons.person_3_fill,
                                color: SolhColors.white,
                                size: 15,
                              ),
                              SizedBox(width: 5),
                              Text(
                                  discoverGroupController.groupDetailModel.value
                                          .totalGroupMembers
                                          .toString() +
                                      " members",
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
                              SvgPicture.asset(
                                'assets/images/get_help/post.svg',
                                height: 10,
                              ),
                              SizedBox(width: 5),
                              Text(
                                  discoverGroupController.groupDetailModel.value
                                          .groupList!.journalCount!
                                          .toString() +
                                      ' posts',
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
                ),
              ),
            );
    });
  }

  Widget getGroupDesc() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Group Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: SolhColors.primary_green,
              )),
          SizedBox(
            height: 10,
          ),
          ReadMoreText(
            discoverGroupController
                    .groupDetailModel.value.groupList!.groupDescription ??
                '',
            style: SolhTextStyles.QS_caption.copyWith(
                fontSize: 14, fontWeight: FontWeight.w600),
            textAlign: TextAlign.start,
            trimLines: 4,
            delimiter: '....',
            trimMode: TrimMode.Line,
            lessStyle: SolhTextStyles.QS_caption.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: SolhColors.primary_green),
            moreStyle: SolhTextStyles.QS_caption.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: SolhColors.primary_green),
          ),
        ],
      ),
    );
  }

  // Padding(
  getPostButton(BuildContext context1) {
    return discoverGroupController.groupDetailModel.value.isUserPresent ==
                null ||
            discoverGroupController.groupDetailModel.value.isUserPresent ==
                false
        ? Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SolhGreenButton(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  backgroundColor: SolhColors.primary_green,
                  child: Obx(() {
                    return discoverGroupController.isLoading.value
                        ? MyLoader()
                        : Text(
                            'Join Group',
                            style: SolhTextStyles.CTA
                                .copyWith(color: SolhColors.white),
                          );
                  }),
                  onPressed: () async {
                    showModalBottomSheet(
                        enableDrag: true,
                        context: context,
                        builder: (context) {
                          profileController.myProfileModel.value.body!.user!
                                      .anonymous ==
                                  null
                              ? Utility.showToast(
                                  'Your anonymous profile dosen\'t exist')
                              : null;
                          return getGroupJoinOption(
                            context: context,
                            createGroupController: createGroupController,
                            profileController: profileController,
                            discoverGroupController: discoverGroupController,
                          );
                        });
                    // Utility.showLoader(context1);
                    // String success = await createGroupController.joinGroup(
                    //     groupId: groupList.sId ?? '');
                    // discoverGroupController.joinedGroupModel.value.groupList!
                    //     .add(groupList);
                    // discoverGroupController
                    //     .discoveredGroupModel.value.groupList!
                    //     .remove(groupList);
                    // discoverGroupController.discoveredGroupModel.refresh();
                    // discoverGroupController.joinedGroupModel.refresh();
                    // discoverGroupController.groupsShownOnHome
                    //     .add(groupList.sId!);
                    // Navigator.of(context).pop();
                    // Navigator.of(context, rootNavigator: true).pop();
                    // Utility.showToast(success);

                    // Navigator.of(context).pop();
                  }),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SolhGreenButton(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    'Post in group',
                    style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
                  ),
                  onPressed: () {
                    journalPageController.selectedGroupId.value =
                        discoverGroupController
                                .groupDetailModel.value.groupList!.sId ??
                            '';
                    //AutoRouter.of(context).push(CreatePostScreenRouter());
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return CreatePostScreen();
                    }));
                  },
                ),
                SolhGreenBorderButton(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      'See Post',
                      style: SolhTextStyles.CTA
                          .copyWith(color: SolhColors.primary_green),
                    ),
                    onPressed: () {
                      journalPageController.selectedGroupId.value =
                          discoverGroupController
                                  .groupDetailModel.value.groupList!.sId ??
                              '';
                      journalPageController.journalsList.clear();
                      journalPageController.pageNo = 1;
                      journalPageController.nextPage = 2;
                      journalPageController.getAllJournals(1,
                          groupId: discoverGroupController
                                  .groupDetailModel.value.groupList!.sId ??
                              '',
                          orgOnly: false);
                      journalPageController.journalsList.refresh();
                      journalPageController.selectedGroupIndex =
                          discoverGroupController.groupsShownOnHome.indexOf(
                              discoverGroupController
                                  .groupDetailModel.value.groupList!.sId!);
                      Future.delayed(Duration(milliseconds: 500), () async {
                        journalPageController.customeScrollController.jumpTo(
                            80 *
                                discoverGroupController.groupsShownOnHome
                                    .indexOf(discoverGroupController
                                        .groupDetailModel.value.groupList!.sId!)
                                    .toDouble());
                      });
                      _bottomNavigatorController.activeIndex.value = 1;

                      // Navigator.popUntil(
                      //     context,
                      //     (route) =>
                      //         route.settings.name == AppRoutes.groupDetails);
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.master, (route) => false);
                    }),
              ],
            ),
          );
  }

  getMembersList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Members', style: SolhTextStyles.QS_body_1_bold),
          SizedBox(
            height: 10,
          ),
          //getDefaultAdmin(context),
          SizedBox(
            height: 10,
          ),
          getDefaultAdmin(context),
          SizedBox(
            height: 10,
          ),
          ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: discoverGroupController
                .groupDetailModel.value.groupList!.groupMembers!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.connectScreen,
                      arguments: {
                        "sId": discoverGroupController.groupDetailModel.value
                            .groupList!.groupMembers![index].sId!
                      });
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ConnectProfileScreen(
                  //             uid: groupList.groupMembers![index].uid!,
                  //             sId: groupList.groupMembers![index].sId!)));
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      // backgroundImage: AssetImage(
                      //   'assets/images/group_placeholder.png',
                      // ),
                      backgroundImage: CachedNetworkImageProvider(
                          discoverGroupController.groupDetailModel.value
                              .groupList!.groupMembers![index].profilePicture!),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                              discoverGroupController.groupDetailModel.value
                                      .groupList!.groupMembers![index].name ??
                                  '',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            discoverGroupController.groupDetailModel.value
                                    .groupList!.groupMembers![index].bio ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 14, color: SolhColors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          getAnonymousUserList(context)
        ],
      ),
    );
  }

  getAnonymousUserList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: discoverGroupController.groupDetailModel.value.groupList!
                    .anonymousMembers!.length ??
                0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ConnectProfileScreen(
                  //             uid: groupList.groupMembers![index].uid!,
                  //             sId: groupList.groupMembers![index].sId!)));
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      // backgroundImage: AssetImage(
                      //   'assets/images/group_placeholder.png',
                      // ),
                      backgroundImage: CachedNetworkImageProvider(
                          discoverGroupController
                                  .groupDetailModel
                                  .value
                                  .groupList!
                                  .anonymousMembers![index]
                                  .profilePicture ??
                              ''),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                              discoverGroupController
                                      .groupDetailModel
                                      .value
                                      .groupList!
                                      .anonymousMembers![index]
                                      .userName ??
                                  '',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text('',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14, color: SolhColors.grey)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget getDefaultAdmin(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: discoverGroupController
          .groupDetailModel.value.groupList!.defaultAdmin!
          .map((defaultAdmin) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ConnectProfileScreen(
              //             uid: defaultAdmin.uid!, sId: defaultAdmin.sId!)));
              Navigator.pushNamed(context, AppRoutes.connectScreen,
                  arguments: {"sId": defaultAdmin.sId!});
            },
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      // backgroundImage: AssetImage(
                      //   'assets/images/group_placeholder.png',
                      // ),
                      backgroundImage: CachedNetworkImageProvider(
                        defaultAdmin.profilePicture ?? '',
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text(defaultAdmin.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 2,
                              height: 14,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Admin',
                              style: GoogleFonts.signika(
                                  color: SolhColors.primary_green),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                              'assets/images/admin.svg',
                            )
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(defaultAdmin.bio ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14, color: SolhColors.grey)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget getGroupImg() {
    return Hero(
      tag: widget.groupId,
      child: Container(
        width: double.infinity,
        height: 300,
        child: discoverGroupController
                    .groupDetailModel.value.groupList!.groupMediaUrl !=
                null
            ? CachedNetworkImage(
                imageUrl: discoverGroupController
                    .groupDetailModel.value.groupList!.groupMediaUrl!,
                fit: BoxFit.cover)
            : Image.asset('assets/images/group_placeholder.png',
                fit: BoxFit.cover),
      ),
    );
  }

  Future<void> getGroupDetails(int pageNo) async {
    await discoverGroupController.getGroupDetail(widget.groupId, pageNo);

    discoverGroupController.groupDetailModel.value.groupList!.defaultAdmin!
        .forEach((element) {
      if (element.sId ==
          profileController.myProfileModel.value.body!.user!.sId!) {
        isDefaultAdmin = true;
      }
    });
    setState(() {});
  }

  Widget getPopUpMenuBtn(BuildContext context) {
    return discoverGroupController.groupDetailModel.value.isUserPresent ==
                null ||
            discoverGroupController.groupDetailModel.value.isUserPresent ==
                false
        ? Container()
        : SizedBox(
            width: 20,
            child: PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: SolhColors.primary_green,
              ),
              itemBuilder: (context) {
                return isDefaultAdmin
                    ? [
                        PopupMenuItem(
                          child: Text('Edit', style: SolhTextStyles.CTA),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text('Delete', style: SolhTextStyles.CTA),
                          value: 2,
                        )
                      ]
                    : [
                        PopupMenuItem(
                          child: Text('Exit group', style: SolhTextStyles.CTA),
                          value: 3,
                        )
                      ];
              },
              onSelected: (value) async {
                if (value == 1) {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return CreateGroup(
                  //     group: widget.group,
                  //   );
                  // }));
                } else if (value == 2) {
                  // await discoverGroupController.deleteGroups(groupList.id ?? '');
                  Navigator.pop(context);
                } else if (value == 3) {
                  getExitButtonPopUp(context);
                }
              },
            ),
          );
  }

  getExitButtonPopUp(BuildContext context1) {
    /* showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Do you want to exit group ?'),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      SolhColors.green,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                    Colors.redAccent.withGreen(50),
                  )),
                  onPressed: () async {
                    // Navigator.pop(context);
                    // Utility.showLoader(context);
                    // await createGroupController.exitGroup(
                    //     groupId: groupList.sId!);
                    // await discoverGroupController
                    //     .getDiscoverGroups();
                    // await discoverGroupController
                    //     .getJoinedGroups();
                    // Navigator.of(context).pop();
                    // Navigator.of(context).pop();
                    Utility.showLoader(context);
                    String success = await createGroupController.exitGroup(
                        groupId: groupList.sId ?? '');
                    discoverGroupController.joinedGroupModel.value.groupList!
                        .remove(groupList);
                    discoverGroupController
                        .discoveredGroupModel.value.groupList!
                        .add(groupList);
                    discoverGroupController.discoveredGroupModel.refresh();
                    discoverGroupController.joinedGroupModel.refresh();
                    // await discoverGroupController.getJoinedGroups();
                    // await discoverGroupController.getDiscoverGroups();
                    Navigator.of(context).pop();
                    Utility.showToast(success);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          );
        }); */
    showDialog(
      context: context1,
      builder: (BuildContext context2) {
        return AlertDialog(
          title: Text(
            'Do You want to Exit group ?',
            style: SolhTextStyles.QS_body_2_semi,
          ),
          actions: <Widget>[
            MaterialButton(
              color: SolhColors.white,
              child: Text(
                'No',
                style: SolhTextStyles.CTA
                    .copyWith(color: SolhColors.primary_green),
              ),
              onPressed: () {
                Navigator.of(context2).pop();
              },
            ),
            MaterialButton(
              color: SolhColors.primary_green,
              child: Text(
                'Yes',
                style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
              ),
              onPressed: () async {
                Utility.showLoader(context);
                String success = await createGroupController.exitGroup(
                    groupId: discoverGroupController
                            .groupDetailModel.value.groupList!.sId ??
                        '');
                discoverGroupController.getHomePageGroup();
                discoverGroupController.joinedGroupModel.value.groupList!
                    .remove(discoverGroupController
                        .groupDetailModel.value.groupList!);
                // discoverGroupController.discoveredGroupModel.value.groupList!
                //     .add(discoverGroupController
                //         .groupDetailModel.value.groupList!);
                discoverGroupController.discoveredGroupModel.refresh();
                discoverGroupController.joinedGroupModel.refresh();
                discoverGroupController.getJoinedGroups();
                discoverGroupController.getDiscoverGroups();
                discoverGroupController.groupsShownOnHome.remove(
                    discoverGroupController
                        .groupDetailModel.value.groupList!.sId);
                Navigator.of(context, rootNavigator: true).pop();
                Utility.showToast(success);
                Navigator.of(context2).pop();
                Navigator.of(context1).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class GetShareButton extends StatelessWidget {
  GetShareButton({super.key, required this.groupId, required this.groupName});
  final String groupId;
  final String groupName;
  final DiscoverGroupController discoverGroupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        discoverGroupController.isSharingLink(true);
        String link = await DynamicLinkProvider.instance
            .createLink(createFor: 'Group', data: {
          'groupId': groupId,
          'creatorUserId': Get.find<ProfileController>()
                  .myProfileModel
                  .value
                  .body!
                  .user!
                  .sId ??
              ''
        });
        print(link);
        await Share.share(
            "Hey! Check out the $groupName support group on the Solh App $link");

        discoverGroupController.isSharingLink(false);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: SolhColors.primary_green.withOpacity(0.5)),
        child: Builder(builder: (context) {
          return Obx(() {
            return discoverGroupController.isSharingLink.value
                ? MyLoader(
                    strokeWidth: 2,
                    radius: 12,
                  )
                : Icon(
                    Icons.share,
                    color: SolhColors.white,
                  );
          });
        }),
      ),
    );
  }
}

getGroupJoinOption({
  context,
  required CreateGroupController createGroupController,
  required ProfileController profileController,
  required DiscoverGroupController discoverGroupController,
  // groupList,
}) {
  return ListView(
    shrinkWrap: true,
    children: [
      SizedBox(
        height: 1.h,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Join As',
              style: SolhTextStyles.QS_body_1_bold,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: SolhColors.grey_3,
              ),
              height: 2.w,
              width: 12.w,
            ),
            InkWell(
                onTap: () => Navigator.of(context).pop(),
                child:
                    SvgPicture.asset('assets/images/canclewithbackgroung.svg'))
          ],
        ),
      ),
      Divider(),
      Obx(() {
        print(createGroupController.joinAsAnon.value);

        return InkWell(
          onTap: () => createGroupController.joinAsAnon.value = false,
          child: getUsersTile(
            name: profileController.myProfileModel.value.body!.user!.name!,
            badge: profileController.myProfileModel.value.body!.user!.userType!,
            image: profileController
                .myProfileModel.value.body!.user!.profilePicture,
            selected: createGroupController.joinAsAnon.value ? false : true,
          ),
        );
      }),
      profileController.myProfileModel.value.body!.user!.anonymous != null
          ? Obx(() {
              return InkWell(
                onTap: () => createGroupController.joinAsAnon.value = true,
                child: getUsersTile(
                  name: profileController
                      .myProfileModel.value.body!.user!.anonymous!.userName!,
                  badge: "",
                  image: profileController.myProfileModel.value.body!.user!
                      .anonymous!.profilePicture!,
                  selected:
                      createGroupController.joinAsAnon.value ? true : false,
                ),
              );
            })
          : Container(),
      Column(
        children: [
          SolhGreenButton(
              onPressed: () async {
                Utility.showLoader(context);
                String success = await createGroupController.joinGroup(
                    groupId: discoverGroupController
                            .groupDetailModel.value.groupList!.sId ??
                        '',
                    isAnon: createGroupController.joinAsAnon.value);
                discoverGroupController.getHomePageGroup();
                // discoverGroupController.joinedGroupModel.value.groupList!.add(
                //     discoverGroupController.groupDetailModel.value.groupList!);
                discoverGroupController.discoveredGroupModel.value.groupList!
                    .remove(discoverGroupController
                        .groupDetailModel.value.groupList!);
                discoverGroupController.discoveredGroupModel.refresh();
                discoverGroupController.joinedGroupModel.refresh();
                discoverGroupController.groupsShownOnHome.add(
                    discoverGroupController
                        .groupDetailModel.value.groupList!.sId!);
                discoverGroupController.getJoinedGroups();
                discoverGroupController.joinedGroupModel.value.groupList!.add(GroupList(
                    sId: discoverGroupController
                        .groupDetailModel.value.groupList!.sId,
                    groupName: discoverGroupController
                        .groupDetailModel.value.groupList!.groupName,
                    groupDescription: discoverGroupController
                        .groupDetailModel.value.groupList!.groupDescription,
                    groupMediaUrl: discoverGroupController
                        .groupDetailModel.value.groupList!.groupMediaUrl,
                    journalCount: discoverGroupController
                        .groupDetailModel.value.groupList!.journalCount,
                    groupMembers: discoverGroupController.groupDetailModel.value
                        .groupList!.groupMembers!.length));
                Navigator.of(context).pop();
                discoverGroupController.tabController?.animateTo(0);
                Navigator.of(context, rootNavigator: true).pop();
                Utility.showToast(success);

                Navigator.of(context).pop();
              },
              width: 90.w,
              child: Text(
                'Join',
                style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
              )),
        ],
      ),
      SizedBox(
        height: 2.h,
      ),
    ],
  );
}

Widget getUsersTile({name, image, badge, selected}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: selected
              ? Border.all(width: 1, color: SolhColors.primary_green)
              : null),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            SimpleImageContainer(
              imageUrl: image,
              radius: 50,
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: SolhTextStyles.QS_body_2_semi,
                ),
                GetBadge(userType: badge),
              ],
            ),
          ],
        ),
        selected ? Image.asset('assets/images/circularCheck.png') : Container()
      ]),
    ),
  );
}
