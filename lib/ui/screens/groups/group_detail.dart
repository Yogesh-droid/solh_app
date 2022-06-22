import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/controllers/group/create_group_controller.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../../routes/routes.gr.dart';

class GroupDetailsPage extends StatefulWidget {
  GroupDetailsPage({Key? key, required this.group, this.isJoined})
      : super(key: key);
  final GroupList group;
  bool? isJoined;

  @override
  State<GroupDetailsPage> createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  late GroupList groupList;
  late bool? isJoined;
  JournalPageController journalPageController = Get.find();

  CreateGroupController createGroupController = Get.find();

  DiscoverGroupController discoverGroupController = Get.find();

  @override
  void initState() {
    groupList = widget.group;
    isJoined = widget.isJoined;
    if (groupList.groupMembers == null) {
      getGroupDetails();
    }
    discoverGroupController.joinedGroupModel.value.groupList!
        .forEach((element) {
      if (element.sId == groupList.sId) {
        isJoined = true;
      }
    });
    discoverGroupController.createdGroupModel.value.groupList!
        .forEach((element) {
      if (element.sId == groupList.sId) {
        isJoined = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: SingleChildScrollView(child: Obx(() {
        return discoverGroupController.isDeletingGroup.value
            ? Center(child: MyLoader())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      getGroupImg(),
                      Obx(() {
                        return discoverGroupController.isLoading.value
                            ? Container()
                            : getGroupInfo(context);
                      })
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
                        ? getShimmer()
                        : getMembersList(context);
                  })
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
            groupList.groupName ?? '' + '(${groupList.groupType})',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        groupList.groupMembers != null
            ? groupList.defaultAdmin!.id == userBlocNetwork.id
                ? getPopUpMenuBtn(context)
                : Container()
            : Obx(() {
                return discoverGroupController.isLoading.value
                    ? Container()
                    : getPopUpMenuBtn(context);
              })
      ]),
      isLandingScreen: false,
    );
  }

  Widget getGroupInfo(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.black.withOpacity(0.0),
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
                groupList.groupName ?? '',
                style: TextStyle(
                  color: SolhColors.white,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icons/group/lock.png'),
                      SizedBox(width: 5),
                      Text(
                        groupList.groupType ?? '',
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
                      Text(
                          groupList.groupMembers!.length.toString() +
                              ' members',
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
                      Text(groupList.journalCount!.toString() + ' posts',
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
                color: SolhColors.green,
              )),
          ReadMoreText(
            groupList.groupDescription ?? '',
            style: TextStyle(
              color: SolhColors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.start,
            trimLines: 4,
            trimMode: TrimMode.Line,
          ),
        ],
      ),
    );
  }

  // Padding(
  getPostButton(BuildContext context) {
    return isJoined == null
        ? Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SolhGreenButton(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  backgroundColor: SolhColors.green,
                  child: Obx(() {
                    return discoverGroupController.isLoading.value
                        ? MyLoader()
                        : Text(
                            'Join Group',
                            style: TextStyle(
                              color: SolhColors.white,
                              fontSize: 16,
                            ),
                          );
                  }),
                  onPressed: () async {
                    await createGroupController.joinGroup(
                        groupId: groupList.sId ?? '');
                    await discoverGroupController.getJoinedGroups();
                    await discoverGroupController.getDiscoverGroups();

                    Navigator.pop(context);
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
                    style: SolhTextStyles.GreenButtonText,
                  ),
                  onPressed: () {
                    journalPageController.selectedGroupId.value =
                        groupList.sId ?? '';
                    AutoRouter.of(context).push(CreatePostScreenRouter());
                  },
                ),
                SolhGreenBorderButton(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      'See Post',
                      style: SolhTextStyles.GreenBorderButtonText,
                    ),
                    onPressed: () {
                      journalPageController.selectedGroupId.value =
                          groupList.sId ?? '';
                      journalPageController.journalsList.clear();
                      journalPageController.pageNo = 1;
                      journalPageController.endPageLimit = 1;
                      journalPageController.getAllJournals(1,
                          groupId: groupList.sId ?? '');
                      journalPageController.journalsList.refresh();

                      AutoRouter.of(context).push(JournalingScreen());
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
          Text('Members',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          SizedBox(
            height: 10,
          ),
          //getDefaultAdmin(context),
          SizedBox(
            height: 10,
          ),

          Row(
            children: [
              CircleAvatar(
                // backgroundImage: AssetImage(
                //   'assets/images/group_placeholder.png',
                // ),
                backgroundImage: CachedNetworkImageProvider(
                    groupList.defaultAdmin!.profilePicture ?? ''),
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
                        child: Text(groupList.defaultAdmin!.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
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
                        style: GoogleFonts.signika(color: SolhColors.green),
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
                    child: Text(groupList.defaultAdmin!.bio ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: SolhColors.grey)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: groupList.groupMembers!.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  CircleAvatar(
                    // backgroundImage: AssetImage(
                    //   'assets/images/group_placeholder.png',
                    // ),
                    backgroundImage: CachedNetworkImageProvider(
                        groupList.groupMembers![index].profilePicture ?? ''),
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
                        child: Text(groupList.groupMembers![index].name ?? '',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(groupList.groupMembers![index].bio ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, color: SolhColors.grey)),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget getDefaultAdmin(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(
              groupList.defaultAdmin!.profilePicture ?? ''),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(groupList.defaultAdmin!.name ?? '',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Text(groupList.defaultAdmin!.bio ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: SolhColors.grey)),
            ),
          ],
        ),
      ],
    );
  }

  Widget getGroupImg() {
    return Hero(
      tag: 'groups',
      child: Container(
        width: double.infinity,
        height: 300,
        child: groupList.groupMediaUrl != null
            ? CachedNetworkImage(
                imageUrl: groupList.groupMediaUrl != null
                    ? groupList.groupMediaUrl ?? ''
                    : 'https://picsum.photos/200/300',
                fit: BoxFit.cover)
            : Image.asset('assets/images/group_placeholder.png',
                fit: BoxFit.cover),
      ),
    );
  }

  Future<void> getGroupDetails() async {
    await discoverGroupController.getGroupDetail(groupList.sId!);
    groupList = discoverGroupController.groupDetail.value;
  }

  getPopUpMenuBtn(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: SolhColors.green,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Text('Edit'),
            value: 1,
          ),
          PopupMenuItem(
            child: Text('Delete'),
            value: 2,
          ),
        ];
      },
      onSelected: (value) async {
        if (value == 1) {
        } else {
          await discoverGroupController.deleteGroups(groupList.id ?? '');
          Navigator.pop(context);
        }
      },
    );
  }
}
