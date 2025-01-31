import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/organization/controller/org_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class AddOrg extends StatelessWidget {
  AddOrg({super.key});
  final OrgController orgController = Get.put(OrgController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text(
          'Add Organization'.tr,
          style: SolhTextStyles.CTA,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        spreadRadius: 2, blurRadius: 2, color: Colors.black12)
                  ]),
                  child: TextField(
                    onChanged: (value) {
                      orgController.showSuggestion.value = true;
                      orgController.createSuggestion();
                    },
                    controller:
                        orgController.orgSuggestionTextEditingController.value,
                    cursorColor: SolhColors.primary_green,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: SolhColors.primary_green,
                      ),
                      filled: true,
                      fillColor: SolhColors.white,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Search Organization'.tr,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: SolhColors.primary_green),
                      ),
                    ),
                  ),
                ),
                Expanded(child: AddOrgSuggestion())
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return orgController.addingOrgs.value
                      ? SolhGreenButton(
                          width: 70.w,
                          child: ButtonLoadingAnimation(
                            ballColor: SolhColors.white,
                          ),
                        )
                      : SolhGreenButton(
                          onPressed: () async {
                            // if (!_isAlreadyAdded()) {
                            await orgController.addOrgs();
                            Navigator.pop(context);
                            // } else {
                            //   Utility.showToast(
                            //       "This organisation is already added");
                            // }
                          },
                          width: 70.w,
                          child: Text(
                            'Save Organization'.tr,
                            style: SolhTextStyles.CTA.copyWith(
                              color: SolhColors.white,
                            ),
                          ),
                        );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isAlreadyAdded() {
    ProfileController profileController = Get.find();
    return profileController.myProfileModel.value.body!.userOrganisations!
        .every((element) =>
            element.organisation!.sId == orgController.selectedorgs[0]);
  }
}

class AddOrgSuggestion extends StatefulWidget {
  AddOrgSuggestion({super.key});

  @override
  State<AddOrgSuggestion> createState() => _AddOrgSuggestionState();
}

class _AddOrgSuggestionState extends State<AddOrgSuggestion> {
  final OrgController orgController = Get.find();

  String groupValue = '';

  @override
  void dispose() {
    orgController.selectedorgs.value = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => orgController.SuggestedOrgs.value.data == null ||
              orgController.orgSuggestionTextEditingController.value.text
                      .trim() ==
                  ''
          ? Container()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: orgController.SuggestedOrgs.value.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() {
                        return Radio(
                          groupValue: groupValue,
                          activeColor: SolhColors.primary_green,
                          value: orgController
                              .SuggestedOrgs.value.data![index].sId!,
                          onChanged: (value) {
                            orgController.selectedorgs.value = [];
                            groupValue = value.toString();
                            orgController.selectedorgs.value
                                .add(value.toString());
                            log(orgController.selectedorgs.toString());
                            setState(() {});
                          },
                        );
                      }),
                      Expanded(
                          child: Text(orgController
                              .SuggestedOrgs.value.data![index].name!))
                    ],
                  ),
                );
              },
            ),
    );
  }
}
