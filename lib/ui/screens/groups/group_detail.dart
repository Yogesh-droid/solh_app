import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:readmore/readmore.dart';
import 'package:solh/controllers/group/create_group_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/ui/screens/journaling/journaling.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class GroupDetailsPage extends StatelessWidget {
  GroupDetailsPage({Key? key, required this.group, this.isJoined})
      : super(key: key);
  final GroupList group;
  bool? isJoined;
  JournalPageController journalPageController = Get.find();
  CreateGroupController createGroupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'groups',
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    child: CachedNetworkImage(
                        imageUrl: group.groupMediaUrl != null
                            ? group.groupMediaUrl ?? ''
                            : 'https://picsum.photos/200/300',
                        fit: BoxFit.fill),
                  ),
                ),
                getGroupInfo(context),
              ],
            ),
            getGroupDesc(),
            getPostButton(context),
            getMembersList()
          ],
        ),
      ),
    );
  }

  SolhAppBar getAppBar(BuildContext context) {
    return SolhAppBar(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          group.groupName ?? '' + '(${group.groupType})',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        PopupMenuButton(
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
            }),
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
                group.groupName ?? '',
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
        ),
      ),
    );
  }

  Widget getGroupDesc() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ReadMoreText(
        group.groupDescription ?? '',
        style: TextStyle(
          color: SolhColors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
        trimLines: 4,
        trimMode: TrimMode.Line,
      ),
    );
  }

  getPostButton(BuildContext context) {
    return isJoined != null
        ? Container(
            height: 50,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: SolhGreenBorderButton(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        'See Post',
                        style: SolhTextStyles.GreenBorderButtonText,
                      ),
                      onPressed: () {
                        journalPageController.selectedGroupId.value =
                            group.sId ?? '';
                        journalPageController.journalsList.clear();
                        journalPageController.pageNo = 1;
                        journalPageController.endPageLimit = 1;
                        journalPageController.getAllJournals(1,
                            groupId: group.sId ?? '');
                        journalPageController.journalsList.refresh();

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return JournalingScreen();
                        }));
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: SolhGreenBorderButton(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        'Join',
                        style: SolhTextStyles.GreenBorderButtonText,
                      ),
                      onPressed: () {
                        createGroupController.joinGroup(
                            groupId: group.sId ?? '');
                      }),
                ),
              ),
            ]),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SolhGreenBorderButton(
                child: Text(
                  'See Post',
                  style: SolhTextStyles.GreenBorderButtonText,
                ),
                onPressed: () {
                  journalPageController.selectedGroupId.value = group.sId ?? '';
                  journalPageController.journalsList.clear();
                  journalPageController.pageNo = 1;
                  journalPageController.endPageLimit = 1;
                  journalPageController.getAllJournals(1,
                      groupId: group.sId ?? '');
                  journalPageController.journalsList.refresh();

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return JournalingScreen();
                  }));
                }),
          );
  }

  getMembersList() {
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
          ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: group.groupMembers!.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/group_placeholder.png',
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(group.groupMembers![index].name ?? '',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      Text(group.groupMembers![index].bio ?? '',
                          style:
                              TextStyle(fontSize: 14, color: SolhColors.grey)),
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
}
