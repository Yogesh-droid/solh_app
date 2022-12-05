import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/profileSetupFloatingActionButton.dart';
import 'package:solh/widgets_constants/constants/stepsProgressbar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

import '../../../../widgets_constants/solh_snackbar.dart';
import '../profile-setup-controller/profile_setup_controller.dart';

class PartOfAnOrganisationPage extends StatelessWidget {
  PartOfAnOrganisationPage({Key? key}) : super(key: key);
  final ProfileSetupController profileSetupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
      floatingActionButton: Obx(() {
        return ProfileSetupFloatingActionButton
            .profileSetupFloatingActionButton(
          child: profileSetupController.isUpdatingField.value
              ? SolhSmallButtonLoader()
              : const Icon(
                  Icons.chevron_right_rounded,
                  size: 40,
                ),
          onPressed: (() async {
            if (profileSetupController.organisation.value != '') {
              bool response = await profileSetupController.updateUserProfile({
                "orgType": profileSetupController.organisation.value.toString(),
                "orgName":
                    profileSetupController.organisationNameController.text,
              });

              if (response) {
                Navigator.pushNamed(context, AppRoutes.master);
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
          onSkip: () => Navigator.pushNamed(context, AppRoutes.master),
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

  final ProfileSetupController profileSetupController = Get.find();

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
              border: Border.all(color: SolhColors.green, width: 3),
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return profileSetupController.organisation.value == ''
                      ? Text(
                          'Select',
                          style: SolhTextStyles.NormalTextGreyS14W5,
                        )
                      : Text(
                          profileSetupController.organisation.value,
                          style: SolhTextStyles.NormalTextBlack2S14W6,
                        );
                }),
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
          controller: profileSetupController.organisationNameController,
          decoration: TextFieldStyles.greenF_greenBroadUF_4R(hintText: null),
        ),
      ],
    );
  }
}

class OrganisationDropDownItem extends StatelessWidget {
  OrganisationDropDownItem({Key? key}) : super(key: key);
  final ProfileSetupController profileSetupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        underline: Container(),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: SolhColors.green,
        ),
        items: [
          DropdownMenuItem(
            child: Text(
              'Educational Institutions',
              style: SolhTextStyles.NormalTextGreenS14W5,
            ),
            value: 'Educational Institutions',
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
          profileSetupController.organisation.value = value ?? '';
        });
  }
}
