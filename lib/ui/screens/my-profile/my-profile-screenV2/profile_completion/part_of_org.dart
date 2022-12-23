import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/profile_completion_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/profileSetupFloatingActionButton.dart';
import 'package:solh/widgets_constants/constants/stepsProgressbar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

import '../../../../../widgets_constants/solh_snackbar.dart';

class PartOfOrg extends StatelessWidget {
  PartOfOrg({Key? key}) : super(key: key);
  final ProfileCompletionController profileCompletionController = Get.find();
  ProfileController profileController = Get.find();
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
            if (profileCompletionController.orgType.value != '') {
              bool response =
                  await profileCompletionController.updateUserProfile({
                "orgType": profileCompletionController.orgType.value.toString(),
                "orgName": profileCompletionController
                    .orgNameTextEditingController.text
                    .trim(),
              });

              if (response) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.master,
                  (route) => false,
                );
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
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.master,
              (route) => false,
            );
          }),
          onBackButton: () => Navigator.of(context).pop()),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(children: [
          StepsProgressbar(
            stepNumber: 6,
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

  final ProfileCompletionController profileCompletionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Organisation Type',
          style: SolhTextStyles.SmallTextWhiteS12W7,
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          height: 6.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: SolhColors.white,
              border: Border.all(color: SolhColors.primary_green, width: 3),
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(() {
                    print(profileCompletionController.orgType.value);
                    return profileCompletionController.orgType.value == ''
                        ? Text(
                            'Select',
                            style: SolhTextStyles.NormalTextGreyS14W5,
                          )
                        : Text(
                            profileCompletionController.orgType.value,
                            style: SolhTextStyles.NormalTextBlack2S14W6,
                            overflow: TextOverflow.ellipsis,
                          );
                  }),
                ),
                OrganisationDropDownItem()
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          'Organisation Name',
          style: SolhTextStyles.SmallTextWhiteS12W7,
        ),
        SizedBox(
          height: 1.h,
        ),
        TextField(
          controller: profileCompletionController.orgNameTextEditingController,
          decoration: TextFieldStyles.greenF_greenBroadUF_4R(hintText: null),
        ),
      ],
    );
  }
}

class OrganisationDropDownItem extends StatelessWidget {
  OrganisationDropDownItem({Key? key}) : super(key: key);
  final ProfileCompletionController profileCompletionController = Get.find();
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        underline: Container(),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: SolhColors.primary_green,
        ),
        items: [
          DropdownMenuItem(
            child: Text(
              'Educational Institutions',
              style: SolhTextStyles.NormalTextGreenS14W5,
            ),
            value: 'Educational Institution',
          ),
          DropdownMenuItem(
            child: Text(
              'Corporate',
              style: SolhTextStyles.NormalTextGreenS14W5,
            ),
            value: 'Corporate',
          ),
          DropdownMenuItem(
            child: Text(
              'Others',
              style: SolhTextStyles.NormalTextGreenS14W5,
            ),
            value: 'Others',
          )
        ],
        onChanged: (value) {
          profileCompletionController.orgType.value = value!;
        });
  }
}


/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/profile_completion_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/profileSetupFloatingActionButton.dart';
import 'package:solh/widgets_constants/constants/stepsProgressbar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:solh/widgets_constants/solh_snackBar.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

class PartOfOrg extends StatelessWidget {
  PartOfOrg({Key? key, required Map<String, dynamic> args})
      : indexOfpage = args['indexOfpage'],
        super(key: key);
  final ProfileCompletionController profileCompletionController = Get.find();
  ProfileController profileController = Get.find();
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
            if (profileCompletionController.orgType.value != '') {
              bool response =
                  await profileCompletionController.updateUserProfile({
                "orgType": profileCompletionController.orgType.value.toString(),
                "orgName": profileCompletionController
                    .orgNameTextEditingController.text
                    .trim(),
              });

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
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.master,
                  (route) => false,
                );
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(children: [
          StepsProgressbar(
            stepNumber: 6,
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

  final ProfileCompletionController profileCompletionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Organisation Type',
          style: SolhTextStyles.SmallTextWhiteS12W7,
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          height: 6.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: SolhColors.white,
              border: Border.all(color: SolhColors.primary_green, width: 3),
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(() {
                    print(profileCompletionController.orgType.value);
                    return profileCompletionController.orgType.value == ''
                        ? Text(
                            'Select',
                            style: SolhTextStyles.NormalTextGreyS14W5,
                          )
                        : Text(
                            profileCompletionController.orgType.value,
                            style: SolhTextStyles.NormalTextBlack2S14W6,
                            overflow: TextOverflow.ellipsis,
                          );
                  }),
                ),
                OrganisationDropDownItem()
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          'Organisation Name',
          style: SolhTextStyles.SmallTextWhiteS12W7,
        ),
        SizedBox(
          height: 1.h,
        ),
        TextField(
          controller: profileCompletionController.orgNameTextEditingController,
          decoration: TextFieldStyles.greenF_greenBroadUF_4R(hintText: null),
        ),
      ],
    );
  }
}

class OrganisationDropDownItem extends StatelessWidget {
  OrganisationDropDownItem({Key? key}) : super(key: key);
  final ProfileCompletionController profileCompletionController = Get.find();
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        underline: Container(),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: SolhColors.primary_green,
        ),
        items: [
          DropdownMenuItem(
            child: Text(
              'Educational Institutions',
              style: SolhTextStyles.NormalTextGreenS14W5,
            ),
            value: 'Educational Institution',
          ),
          DropdownMenuItem(
            child: Text(
              'Corporate',
              style: SolhTextStyles.NormalTextGreenS14W5,
            ),
            value: 'Corporate',
          ),
          DropdownMenuItem(
            child: Text(
              'Others',
              style: SolhTextStyles.NormalTextGreenS14W5,
            ),
            value: 'Others',
          )
        ],
        onChanged: (value) {
          profileCompletionController.orgType.value = value!;
        });
  }
}
 */