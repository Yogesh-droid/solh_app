import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/part-of-org/controller/part_of_org_controller.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/profile_completion_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/default_org.dart';
import 'package:solh/widgets_constants/constants/profileSetupFloatingActionButton.dart';
import 'package:solh/widgets_constants/constants/stepsProgressbar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../../../../widgets_constants/solh_snackbar.dart';

class PartOfOrg extends StatelessWidget {
  PartOfOrg({Key? key, required Map<String, dynamic> args})
      : indexOfpage = args['indexOfpage'],
        super(key: key);
  final ProfileCompletionController profileCompletionController = Get.find();
  final ProfileController profileController = Get.find();
  final PartOfAnOrgController _controller = Get.put(PartOfAnOrgController());
  final int indexOfpage;
  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
      floatingActionButton: Obx(() {
        return ProfileSetupFloatingActionButton
            .profileSetupFloatingActionButton(
          child: profileCompletionController.isUpdatingField.value
              ? SolhSmallButtonLoader()
              : const Icon(
                  Icons.chevron_right_rounded,
                  size: 40,
                ),
          onPressed: (() async {
            if (_controller.selectedOrgList.isNotEmpty) {
              bool response =
                  await profileCompletionController.updateUserProfile({
                "organisation": jsonEncode(_controller.selectedOrgList
                    .map(
                      (element) => element['sId'],
                    )
                    .toList())
              });
              DefaultOrg.setDefaultOrg(
                  _controller.selectedOrgList.first['sId']);
              if (response) {
                if (profileCompletionController.uncompleteFields.last !=
                    profileCompletionController.uncompleteFields[indexOfpage]) {
                  Navigator.pushNamed(
                      context,
                      profileCompletionController.getAppRoute(
                          profileCompletionController
                              .uncompleteFields[indexOfpage + 1]),
                      arguments: {"indexOfpage": indexOfpage + 1});
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.master,
                    (route) => false,
                  );
                }
              }
            } else {
              SolhSnackbar.error(
                  'Error', 'Please select a Organistion or Skip for above');
            }
          }),
        );
      }),
      appBar: SolhAppBarTanasparentOnlyBackButton(
          backButtonColor: SolhColors.white,
          skipButtonStyle: SolhTextStyles.NormalTextWhiteS14W6,
          onSkip: (() {
            if (profileCompletionController.uncompleteFields.last !=
                profileCompletionController.uncompleteFields[indexOfpage]) {
              Navigator.pushNamed(
                  context,
                  profileCompletionController.getAppRoute(
                      profileCompletionController
                          .uncompleteFields[indexOfpage + 1]),
                  arguments: {"indexOfpage": indexOfpage + 1});
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.master,
                (route) => false,
              );
            }
          }),
          onBackButton: () => Navigator.of(context).pop()),
      body: Stack(
        children: [
          Column(children: [
            StepsProgressbar(
              stepNumber: profileController
                  .myProfileModel.value.body!.userMoveEmptyScreenEmpty!
                  .indexOf(5)
                  .toDouble(),
              maxStep: profileController
                  .myProfileModel.value.body!.userMoveEmptyScreenEmpty!.length,
            ),
            SizedBox(
              height: 3.h,
            ),
            PartOfAnOrganisationtext(),
            SizedBox(
              height: 3.h,
            ),
            PartOfAnOrganisationField()
          ]),
          Obx(() {
            return _controller.showSuggestion.value
                ? Positioned(top: 26.h, child: OrgainsationSuggestionList())
                : Container();
          })
        ],
      ),
    );
  }
}

class PartOfAnOrganisationtext extends StatelessWidget {
  const PartOfAnOrganisationtext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Part of an organisation ?',
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "Please provide details below if you are boarding as part of an organization.",
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class PartOfAnOrganisationField extends StatelessWidget {
  PartOfAnOrganisationField({Key? key}) : super(key: key);

  final PartOfAnOrgController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _controller.isOrganisationsLoading.value
          ? MyLoader()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Organisation Name',
                  style: SolhTextStyles.SmallTextWhiteS12W7,
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextField(
                  controller: _controller.orgTextEditingCotroller.value,
                  onChanged: (value) {
                    _controller.showSuggestion.value = true;
                    _controller.createSuggestion();
                  },
                  cursorColor: SolhColors.primary_green,
                  decoration: InputDecoration(
                      suffix: Icon(
                        Icons.search,
                        color: SolhColors.Grey_1,
                      ),
                      fillColor: SolhColors.white,
                      filled: true,
                      hintText: "Search Organisation".tr,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: SolhColors.white,
                        ),
                      ),
                      focusColor: SolhColors.white),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Obx(() {
                  return _controller.selectedOrgList.isEmpty
                      ? Container()
                      : AddedOrgs();
                }),
                SizedBox(
                  height: 1.h,
                ),
              ],
            );
    });
  }
}

class OrgainsationSuggestionList extends StatelessWidget {
  OrgainsationSuggestionList({Key? key}) : super(key: key);

  final PartOfAnOrgController partOfAnOrganisationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return partOfAnOrganisationController.SuggestedOrgs.value.data == null ||
              partOfAnOrganisationController.orgTextEditingCotroller.value.text
                      .trim() ==
                  ''
          ? Container()
          : Container(
              width: 100.w,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.black26)
              ]),
              child: partOfAnOrganisationController.SuggestedOrgs.value.data ==
                      null
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: partOfAnOrganisationController
                          .SuggestedOrgs.value.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (partOfAnOrganisationController
                                    .checkIfOrgAlreadyExists(
                                        partOfAnOrganisationController
                                            .SuggestedOrgs
                                            .value
                                            .data![index]
                                            .name!) ==
                                false) {
                              partOfAnOrganisationController.selectedOrgList
                                  .add({
                                "name": partOfAnOrganisationController
                                    .SuggestedOrgs.value.data![index].name,
                                "sId": partOfAnOrganisationController
                                    .SuggestedOrgs.value.data![index].sId
                              });
                            }
                            partOfAnOrganisationController
                                .showSuggestion(false);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: SolhColors.white,
                            ),
                            child: Text(partOfAnOrganisationController
                                .SuggestedOrgs.value.data![index].name!),
                          ),
                        );
                      },
                    ),
            );
    });
  }
}

class AddedOrgs extends StatelessWidget {
  AddedOrgs({super.key});
  final PartOfAnOrgController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: SolhColors.white),
      child: Obx(() {
        return Wrap(
            spacing: 5,
            children: _controller.selectedOrgList
                .map((element) => Chip(
                      deleteIcon: Icon(
                        CupertinoIcons.clear,
                        color: SolhColors.white,
                        size: 15,
                      ),
                      onDeleted: () {
                        _controller.selectedOrgList.removeWhere((e) {
                          log(element.values.first);
                          return element.values.first == e.values.first;
                        });
                      },
                      backgroundColor: SolhColors.primary_green,
                      label: Row(mainAxisSize: MainAxisSize.min, children: [
                        Flexible(
                          child: Text(
                            element.values.first,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: SolhColors.white),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ]),
                    ))
                .toList());
      }),
    );
  }
}
