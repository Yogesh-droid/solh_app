import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/profile-setupV2/profile-setup-controller/profile_setup_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/profileSetupFloatingActionButton.dart';
import 'package:solh/widgets_constants/constants/stepsProgressbar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

import '../../../../widgets_constants/solh_snackbar.dart';

class NameField extends StatelessWidget {
  NameField({Key? key}) : super(key: key);

  final ProfileSetupController profileSetupController =
      Get.put(ProfileSetupController());

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
          onPressed: () async {
            if (profileSetupController.firstNameController.text.trim() != '') {
              bool response = await profileSetupController.updateUserProfile({
                "first_name":
                    profileSetupController.firstNameController.text.trim(),
                "last_name":
                    profileSetupController.firstNameController.text.trim() != ''
                        ? profileSetupController.lastNameController.text.trim()
                        : ''
              });

              if (response) {
                Navigator.pushNamed(context, AppRoutes.dobField);
                FirebaseAnalytics.instance.logEvent(
                    name: 'OnBoardingNameDone',
                    parameters: {'Page': 'OnBoarding'});
              }
            } else {
              SolhSnackbar.error('Error', 'Enter a valid name');
            }
            // Navigator.pushNamed(context, AppRoutes.dobField);
          },
        );
      }),
      appBar: SolhAppBarTanasparentOnlyBackButton(
          backButtonColor: SolhColors.white,
          onBackButton: () => Navigator.of(context).pop()),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(children: [
          SizedBox(
            height: 3.h,
          ),
          StepsProgressbar(
            stepNumber: 1,
            maxStep: 2,
          ),
          SizedBox(
            height: 3.h,
          ),
          WhatShouldWeCallYou(),
          SizedBox(
            height: 3.h,
          ),
          NameTextField()
        ]),
      ),
    );
  }
}

class WhatShouldWeCallYou extends StatelessWidget {
  const WhatShouldWeCallYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What should we call you?'.tr,
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "It helps us to know your real name, don't worry we won't share it with anyone without your permission. "
              .tr,
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class NameTextField extends StatelessWidget {
  NameTextField({Key? key}) : super(key: key);

  final ProfileSetupController profileSetupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'First Name'.tr,
          style: SolhTextStyles.SmallTextWhiteS12W7,
        ),
        SizedBox(
          height: 1.h,
        ),
        TextField(
          controller: profileSetupController.firstNameController,
          decoration: TextFieldStyles.greenF_greenBroadUF_4R(hintText: null),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          'Last Name'.tr,
          style: SolhTextStyles.SmallTextWhiteS12W7,
        ),
        SizedBox(
          height: 1.h,
        ),
        TextField(
          controller: profileSetupController.lastNameController,
          decoration: TextFieldStyles.greenF_greenBroadUF_4R(hintText: null),
        ),
      ],
    );
  }
}
