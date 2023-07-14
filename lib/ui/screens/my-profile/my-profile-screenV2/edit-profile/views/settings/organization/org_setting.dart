import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/profile/my_profile_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/organization/controller/org_controller.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/emergency_contacts.dart';
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
              'Add',
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
        height: 220,
        width: 220,
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
                    onTap: () => orgController.removeAndUpdateOrg(myProfileModel
                        .body!.userOrganisations!.first.organisation!.sId!),
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
            myProfileModel.body!.userOrganisations!.first.orgusercategories !=
                    null
                ? Container(
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
                              userOrganisations:
                                  myProfileModel.body!.userOrganisations!.first,
                              label: myProfileModel.body!.userOrganisations!
                                  .first.orgusercategories!.label!,
                            );
                          },
                        );
                      },
                      child: Text(
                        myProfileModel.body!.userOrganisations!.first
                            .orgusercategories!.label!,
                        style: SolhTextStyles.QS_cap_2_semi.copyWith(
                            color: SolhColors.primary_green),
                      ),
                    ),
                  )
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
      childAspectRatio: 2 / 2.2,
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
                            border: Border.all(
                                color: SolhColors.Grey_1, width: 1.5)),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 8, top: 8),
                  child: InkWell(
                    onTap: () => orgController.removeAndUpdateOrg(
                        subList[index].organisation!.sId ?? ''),
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
                      label: subList[index].orgusercategories!.label!,
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
                      child: Text(
                        subList[index].orgusercategories!.label!,
                        style: SolhTextStyles.QS_cap_2_semi.copyWith(
                            color: SolhColors.primary_green),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      );
    },
  );
}

class TeamsModelSheetContent extends StatefulWidget {
  TeamsModelSheetContent(
      {super.key, required this.userOrganisations, required this.label});

  final UserOrganisations userOrganisations;
  final String label;

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
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.label,
              style: SolhTextStyles.QS_big_body_med_20,
            ),
          ),
          widget.userOrganisations.orgusercategories == null
              ? Text('No Category to select')
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
                            log("changed");
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
          Obx(() {
            return orgController.isUpdatingOrgTeam.value
                ? SolhGreenButton(
                    child: ButtonLoadingAnimation(
                    ballColor: SolhColors.white,
                  ))
                : SolhGreenButton(
                    onPressed: () async {
                      await orgController.updateOrgTeamController(
                          userOrgId: widget.userOrganisations.sId!,
                          selectedOptionId: groupValue);

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Save',
                      style:
                          SolhTextStyles.CTA.copyWith(color: SolhColors.white),
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
