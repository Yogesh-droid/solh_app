import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/profile_completion_controller.dart';
import 'package:solh/ui/screens/profile-setupV2/profile-setup-controller/profile_setup_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/profileSetupFloatingActionButton.dart';
import 'package:solh/widgets_constants/constants/stepsProgressbar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../../../../widgets_constants/solh_snackbar.dart';

class GenderField extends StatelessWidget {
  GenderField({Key? key, required Map<String, dynamic> args})
      : indexOfpage = args['indexOfpage'],
        super(key: key);
  ProfileSetupController profileSetupController = Get.find();
  final ProfileCompletionController profileCompletionController = Get.find();
  final int indexOfpage;
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
            if (profileSetupController.gender.value != '') {
              bool response = await profileSetupController.updateUserProfile({
                "gender": profileSetupController.gender.value.toString(),
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
                FirebaseAnalytics.instance.logEvent(
                    name: 'OnBoardingGenderDone',
                    parameters: {'Page': 'OnBoarding'});
              }
            } else {
              SolhSnackbar.error('Error', 'Please select a gender');
            }
          }),
        );
      }),
      appBar: SolhAppBarTanasparentOnlyBackButton(
        onSkip: () {
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
        },
        skipButtonStyle: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
        backButtonColor: SolhColors.white,
        onBackButton: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            StepsProgressbar(stepNumber: 8),
            SizedBox(
              height: 3.h,
            ),
            GenderText(),
            SizedBox(
              height: 3.h,
            ),
            Stack(
              children: [
                GenderSelection(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GenderText extends StatelessWidget {
  const GenderText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Whats your gender ?'.tr,
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "If you don't confirm to any of the options below, don't worry. We've got space for everybody"
              .tr,
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class GenderSelection extends StatelessWidget {
  GenderSelection({Key? key}) : super(key: key);

  final ProfileSetupController profileSetupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender'.tr,
          style: SolhTextStyles.NormalTextWhiteS14W6,
        ),
        SizedBox(
          height: 1.h,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: 6.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: SolhColors.white,
                border: Border.all(color: SolhColors.primary_green, width: 3),
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: SolhColors.primary_green,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return profileSetupController.gender.value == ''
                            ? Text(
                                'Select'.tr,
                                style: SolhTextStyles.NormalTextGreyS14W5,
                              )
                            : Text(
                                profileSetupController.gender.value.tr,
                                style: SolhTextStyles.NormalTextBlack2S14W6,
                              );
                      }),
                      Container(
                        child: Expanded(
                          child: DropDownItem(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DropDownItem extends StatelessWidget {
  DropDownItem({Key? key}) : super(key: key);
  final ProfileSetupController profileSetupController = Get.find();
  @override
  Widget build(BuildContext context) {
    print('sfs');
    return DropdownButton<String>(
        underline: Container(),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: SolhColors.white,
        ),
        items: [
          DropdownMenuItem(
            child: Text(
              'Male'.tr,
              style: SolhTextStyles.NormalTextGreenS14W5,
            ),
            value: 'Male',
          ),
          DropdownMenuItem(
            child: Text(
              'Female'.tr,
              style: SolhTextStyles.NormalTextGreenS14W5,
            ),
            value: 'Female',
          ),
          DropdownMenuItem(
            child: Text(
              'Others'.tr,
              style: SolhTextStyles.NormalTextGreenS14W5,
            ),
            value: 'Others',
          )
        ],
        onChanged: (value) {
          profileSetupController.gender.value = value ?? '';
        });
  }
}
