import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/profile/my_profile_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/organization/controller/org_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class OrgSetting extends StatelessWidget {
  OrgSetting({super.key});
  final ProfileController profileController = Get.find();
  final _controller = Get.put(OrgController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text(
          'Organization',
          style: SolhTextStyles.QS_body_1_bold,
        ),
      ),
      body: Obx(() {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (_controller.showBottomSheet.value) {
            showModalBottomSheet(
              constraints: BoxConstraints(maxHeight: 80.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              context: context,
              builder: (context) {
                return TeamsModelSheetContent(
                    userOrganisations: profileController
                        .myProfileModel.value.body!.userOrganisations!
                        .where((element) =>
                            element.organisation!.sId ==
                            _controller.lastAddedOrg.value)
                        .first);
              },
            );
            _controller.showBottomSheet.value = false;
          }
        });

        return _controller.isDeletingOrg.value ||
                profileController.isProfileLoading.value
            ? Center(
                child: MyLoader(),
              )
            : ListView(
                padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
                children: [
                  InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.addOrg),
                      child: getAddOrgButton()),
                  Obx(() {
                    return profileController.myProfileModel.value.body!
                                .userOrganisations!.isEmpty ||
                            profileController.myProfileModel.value.body!
                                    .userOrganisations ==
                                null
                        ? Container()
                        : getDefaultOrg(profileController.myProfileModel.value,
                            _controller, context);
                  }),
                  Obx(() {
                    return profileController.myProfileModel.value.body!
                                .userOrganisations!.isNotEmpty &&
                            profileController.myProfileModel.value.body!
                                    .userOrganisations!.length >
                                1
                        ? getOtherOrgs(
                            profileController.myProfileModel.value, _controller)
                        : Container();
                  }),
                ],
              );
      }),
    );
  }
}

Widget getAddOrgButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: SolhColors.primary_green,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.add,
              color: SolhColors.white,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Add'.tr,
              style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
            ),
          ],
        ),
      )
    ],
  );
}

Widget getDefaultOrg(MyProfileModel myProfileModel, OrgController orgController,
    BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 220,
        height: 265,
        decoration: BoxDecoration(
          color: SolhColors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 2,
              color: Colors.black12,
            ),
          ],
          border: Border.all(color: SolhColors.primary_green, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Icon(
                    Icons.check_circle_outline,
                    size: 25,
                    color: SolhColors.primary_green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, top: 8),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return removeOrgAlertDialog(
                              myProfileModel.body!.userOrganisations!.first
                                  .organisation!.name!,
                              orgController,
                              myProfileModel.body!.userOrganisations!.first
                                  .organisation!.sId!,
                              context);
                        },
                      );
                      //  orgController.removeAndUpdateOrg(myProfileModel
                      //   .body!.userOrganisations!.first.organisation!.sId!);
                    },
                    child: Icon(
                      Icons.remove_circle_outline,
                      size: 25,
                      color: SolhColors.primaryRed,
                    ),
                  ),
                ),
              ],
            ),
            CircleAvatar(
              radius: 15.w,
              backgroundImage: NetworkImage(myProfileModel
                  .body!.userOrganisations!.first.organisation!.logo!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getOrgStatus(
                    myProfileModel.body!.userOrganisations!.first.status!),
              ],
            ),
            Text(
              myProfileModel.body!.userOrganisations!.first.organisation!.name!,
              textAlign: TextAlign.center,
              style: SolhTextStyles.QS_caption,
            ),
            Expanded(child: SizedBox()),
            myProfileModel.body!.userOrganisations!.first.orgusercategories !=
                    null
                ? Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                          color: SolhColors.primary_green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6)),
                      child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              constraints: BoxConstraints(maxHeight: 80.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              context: context,
                              builder: (context) {
                                return TeamsModelSheetContent(
                                  userOrganisations: myProfileModel
                                      .body!.userOrganisations!.first,
                                );
                              },
                            );
                          },
                          child: getTeamLocationText(
                            myProfileModel.body!.userOrganisations!.first,
                          )),
                    ))
                : Container(),
          ],
        ),
      ),
    ],
  );
}

Widget getOtherOrgs(
    MyProfileModel myProfileModel, OrgController orgController) {
  List<UserOrganisations> subList =
      myProfileModel.body!.userOrganisations!.sublist(1);
  return GridView.builder(
    padding: EdgeInsets.only(
      top: 15,
    ),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      childAspectRatio: 2 / 2.6,
      crossAxisSpacing: 15,
    ),
    itemCount: subList.length,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Container(
        decoration: BoxDecoration(
          color: SolhColors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 2,
              color: Colors.black12,
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: InkWell(
                      onTap: () {
                        if (subList[index].status == 'Approved') {
                          orgController.changeDefault(index);
                        } else {
                          Utility.showToast(
                              'Only approved organizations can be made default');
                        }
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: SolhColors.Grey_1, width: 1.5),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 8, top: 8),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return removeOrgAlertDialog(
                              subList[index].organisation!.name ?? '',
                              orgController,
                              subList[index].organisation!.sId ?? '',
                              context);
                        },
                      );
                      // orgController.removeAndUpdateOrg(
                      //     subList[index].organisation!.sId ?? '');
                    },
                    child: Icon(
                      Icons.remove_circle_outline,
                      size: 25,
                      color: SolhColors.primaryRed,
                    ),
                  ),
                ),
              ],
            ),
            CircleAvatar(
              radius: 15.w,
              backgroundImage: NetworkImage(subList[index].organisation!.logo!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getOrgStatus(subList[index].status ?? ''),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                subList[index].organisation!.name!,
                textAlign: TextAlign.center,
                style: SolhTextStyles.QS_caption,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(child: SizedBox()),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  constraints: BoxConstraints(maxHeight: 80.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  context: context,
                  builder: (context) {
                    return TeamsModelSheetContent(
                      userOrganisations: subList[index],
                    );
                  },
                );
              },
              child: subList[index].orgusercategories != null
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                          color: SolhColors.primary_green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6)),
                      child: getTeamLocationText(subList[index]))
                  : Container(),
            ),
          ],
        ),
      );
    },
  );
}

Widget getTeamLocationText(UserOrganisations userOrganisations) {
  if (userOrganisations.selectedLocOption != null &&
      userOrganisations.orgusercategories!.selectedOption == null) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_outlined,
            color: SolhColors.primary_green,
            size: 15,
          ),
          Text(
            getLocationText(userOrganisations),
            style: SolhTextStyles.QS_caption.copyWith(
                color: SolhColors.primary_green),
          )
        ],
      ),
    );
  } else if (userOrganisations.selectedLocOption == null &&
      userOrganisations.orgusercategories!.selectedOption != null) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.card_travel,
            color: SolhColors.primary_green,
            size: 15,
          ),
          Text(
            getTeamText(userOrganisations),
            style: SolhTextStyles.QS_caption.copyWith(
                color: SolhColors.primary_green),
          ),
        ],
      ),
    );
  } else if (userOrganisations.selectedLocOption != null &&
      userOrganisations.orgusercategories!.selectedOption != null) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.card_travel,
                color: SolhColors.primary_green,
                size: 15,
              ),
              Text(
                getTeamText(userOrganisations),
                style: SolhTextStyles.QS_caption.copyWith(
                  color: SolhColors.primary_green,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: SolhColors.primary_green,
                size: 15,
              ),
              Text(
                getLocationText(userOrganisations),
                style: SolhTextStyles.QS_caption.copyWith(
                    color: SolhColors.primary_green),
              )
            ],
          )
        ],
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            'Select Team and Location',
            style: SolhTextStyles.QS_caption.copyWith(
                color: SolhColors.primary_green),
          ),
        ],
      ),
    );
  }
}

String getLocationText(UserOrganisations userOrganisations) {
  List<OptionsLoc> optionList = userOrganisations.orgusercategories!.optionsLoc!
      .where((element) => element.sId == userOrganisations.selectedLocOption)
      .toList();

  if (optionList.isNotEmpty) {
    return optionList.first.name!;
  }
  return '';
}

String getTeamText(UserOrganisations userOrganisations) {
  List<Options> optionList = userOrganisations.orgusercategories!.options!
      .where((element) =>
          element.sId == userOrganisations.orgusercategories!.selectedOption)
      .toList();
  if (optionList.isNotEmpty) {
    return optionList.first.name!;
  }
  return '';
}

class TeamsModelSheetContent extends StatefulWidget {
  TeamsModelSheetContent({super.key, required this.userOrganisations});

  final UserOrganisations userOrganisations;

  @override
  State<TeamsModelSheetContent> createState() => _TeamsModelSheetContentState();
}

class _TeamsModelSheetContentState extends State<TeamsModelSheetContent> {
  final OrgController orgController = Get.find();
  String groupValue = '';

  @override
  void initState() {
    // TODO: implement initState
    groupValue =
        widget.userOrganisations.orgusercategories!.selectedOption != null
            ? widget.userOrganisations.orgusercategories!.selectedOption!
            : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 100.w,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: TabBar(indicatorColor: SolhColors.primary_green, tabs: [
                Text(
                  'Select Team',
                  style: SolhTextStyles.CTA,
                ),
                Text(
                  'Select Location',
                  style: SolhTextStyles.CTA,
                ),
              ]),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  SelectTeamTabContent(
                    userOrganisations: widget.userOrganisations,
                  ),
                  SelectLocationTabContent(
                    userOrganisations: widget.userOrganisations,
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectTeamTabContent extends StatefulWidget {
  SelectTeamTabContent({super.key, required this.userOrganisations});

  final UserOrganisations userOrganisations;

  @override
  State<SelectTeamTabContent> createState() => _SelectTeamTabContentState();
}

class _SelectTeamTabContentState extends State<SelectTeamTabContent> {
  final OrgController orgController = Get.find();
  String groupValue = '';

  @override
  void initState() {
    // TODO: implement initState
    groupValue =
        widget.userOrganisations.orgusercategories!.selectedOption != null
            ? widget.userOrganisations.orgusercategories!.selectedOption!
            : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.userOrganisations.orgusercategories == null ||
                  widget.userOrganisations.orgusercategories!.options!.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'No Category to select',
                    style: SolhTextStyles.QS_body_2_bold,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                        child: Row(
                      children: [
                        Radio(
                          activeColor: SolhColors.primary_green,
                          groupValue: groupValue,
                          value: widget.userOrganisations.orgusercategories!
                              .options![index].sId!,
                          onChanged: (value) async {
                            groupValue = widget.userOrganisations
                                .orgusercategories!.options![index].sId!;
                            setState(() {});
                          },
                        ),
                        Text(
                          widget.userOrganisations.orgusercategories!
                              .options![index].name!,
                          style: SolhTextStyles.QS_caption,
                        ),
                      ],
                    ));
                  },
                  itemCount: widget
                      .userOrganisations.orgusercategories!.options!.length,
                ),
          SizedBox(
            height: 15,
          ),
          Obx(() {
            return orgController.isUpdatingOrgTeam.value
                ? SolhGreenButton(
                    child: ButtonLoadingAnimation(
                      ballColor: SolhColors.white,
                    ),
                  )
                : (widget.userOrganisations.orgusercategories!.options!.isEmpty
                    ? SolhGreenButton(
                        backgroundColor: SolhColors.Grey_1,
                        child: Text(
                          'Save',
                          style: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.white),
                        ))
                    : SolhGreenButton(
                        onPressed: () async {
                          await orgController.updateOrgTeamController(
                              userOrgId:
                                  widget.userOrganisations.organisation!.sId!,
                              type: "team",
                              selectedOptionId: groupValue);

                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Save',
                          style: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.white),
                        )));
          }),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}

class SelectLocationTabContent extends StatefulWidget {
  SelectLocationTabContent({super.key, required this.userOrganisations});

  final UserOrganisations userOrganisations;

  @override
  State<SelectLocationTabContent> createState() =>
      _SelectLocationTabContentState();
}

class _SelectLocationTabContentState extends State<SelectLocationTabContent> {
  @override
  final OrgController orgController = Get.find();
  String groupValue = '';

  @override
  void initState() {
    // TODO: implement initState
    groupValue = widget.userOrganisations.selectedLocOption != null
        ? widget.userOrganisations.selectedLocOption!
        : '';
    super.initState();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.userOrganisations.orgusercategories == null ||
                  widget
                      .userOrganisations.orgusercategories!.optionsLoc!.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'No Category to select',
                    style: SolhTextStyles.QS_body_2_bold,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                        child: Row(
                      children: [
                        Radio(
                          activeColor: SolhColors.primary_green,
                          groupValue: groupValue,
                          value: widget.userOrganisations.orgusercategories!
                              .optionsLoc![index].sId!,
                          onChanged: (value) async {
                            groupValue = widget.userOrganisations
                                .orgusercategories!.optionsLoc![index].sId!;
                            setState(() {});
                          },
                        ),
                        Text(
                          widget.userOrganisations.orgusercategories!
                              .optionsLoc![index].name!,
                          style: SolhTextStyles.QS_caption,
                        ),
                      ],
                    ));
                  },
                  itemCount: widget
                      .userOrganisations.orgusercategories!.optionsLoc!.length,
                ),
          SizedBox(
            height: 15,
          ),
          Obx(() {
            return orgController.isUpdatingOrgTeam.value
                ? SolhGreenButton(
                    child: ButtonLoadingAnimation(
                      ballColor: SolhColors.white,
                    ),
                  )
                : (widget.userOrganisations.orgusercategories!.optionsLoc!
                        .isEmpty
                    ? SolhGreenButton(
                        backgroundColor: SolhColors.Grey_1,
                        child: Text(
                          'Save',
                          style: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.white),
                        ))
                    : SolhGreenButton(
                        onPressed: () async {
                          await orgController.updateOrgTeamController(
                              userOrgId:
                                  widget.userOrganisations.organisation!.sId!,
                              type: "location",
                              selectedOptionId: groupValue);

                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Save',
                          style: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.white),
                        ),
                      ));
          }),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}

Widget getOrgStatus(String status) {
  return Row(
    children: [
      Container(
        height: 5,
        width: 5,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: getStatusColor(status)),
      ),
      SizedBox(
        width: 5,
      ),
      Text(
        status,
        style: SolhTextStyles.QS_cap_2_semi,
      ),
    ],
  );
}

Color getStatusColor(String label) {
  switch (label) {
    case 'Approved':
      return Color(0xff0C812C);
    case 'Invited':
      return Color(0xffEAA900);
    case 'Rejected':
      return Color(0xffE11616);
    default:
      return Colors.white;
  }
}

Widget removeOrgAlertDialog(String orgName, OrgController controller,
    String orgId, BuildContext context) {
  return AlertDialog(
    content: Text(
      '$orgName Consulting will be permanently removed from your list of organizations. Do you wish to proceed?',
      style: SolhTextStyles.QS_caption.copyWith(
        fontSize: 16,
      ),
    ),
    actions: [
      InkWell(
        onTap: () {
          controller.removeAndUpdateOrg(orgId
              // myProfileModel.body!.userOrganisations!.first.organisation!.sId!
              );
          Navigator.of(context).pop();
        },
        child: Text("Ok",
            style: SolhTextStyles.QS_cap_2_semi.copyWith(
                fontSize: 14, color: SolhColors.primary_green)),
      ),
      SizedBox(
        width: 15,
      ),
      InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Text(
          "Cancel",
          style: SolhTextStyles.QS_cap_2_semi.copyWith(
              fontSize: 14, color: SolhColors.primaryRed),
        ),
      )
    ],
  );
}
