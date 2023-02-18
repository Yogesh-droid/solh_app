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

enum RoleType { Seeker, Volunteer, Provider, Explorer, Undefined }

class RoleSection extends StatelessWidget {
  RoleSection({Key? key}) : super(key: key);
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
          onPressed: () async {
            if (coditionChecker(profileSetupController) == '') {
              if (profileSetupController.selectedRoleType.value !=
                  RoleType.Undefined) {
                bool response = await profileSetupController.updateUserProfile({
                  "email": profileSetupController.providerEmailController.text
                      .trim(),
                  "userType":
                      getUserType(profileSetupController.selectedRoleType.value)
                });

                if (response) {
                  FirebaseAnalytics.instance.logEvent(
                      name: 'OnBoardingUserTypeDone',
                      parameters: {'Page': 'OnBoarding'});
                  if (profileSetupController.selectedRoleType.value ==
                      RoleType.Provider) {
                    Navigator.pushNamed(context, AppRoutes.partOfAnOrgnisation);
                  } else {
                    Navigator.pushNamed(context, AppRoutes.needSupportOn);
                  }
                }
              } else {
                SolhSnackbar.error('Error', 'Choose a valid option');
              }
            } else {
              SolhSnackbar.error('Error', 'Enter/select all options');
            }
          },
        );
      }),
      appBar: SolhAppBarTanasparentOnlyBackButton(
        backButtonColor: SolhColors.white,
        onBackButton: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            SizedBox(
              height: 3.h,
            ),
            StepsProgressbar(stepNumber: 4),
            SizedBox(
              height: 3.h,
            ),
            RoleSectionText(),
            SizedBox(
              height: 3.h,
            ),
            RoleOptions(),
            BottomNote()
          ],
        ),
      ),
    );
  }
}

class RoleSectionText extends StatelessWidget {
  const RoleSectionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select your role',
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "Don't worry, you can change this anytime in the future as and when your situation changes. For now, choose the best one suited to you. ",
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class RoleOptions extends StatelessWidget {
  RoleOptions({Key? key}) : super(key: key);

  final ProfileSetupController profileSetupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getRoleOption('assets/images/seeker.png', 'Here to seek help',
            RoleType.Seeker, profileSetupController),
        SizedBox(
          height: 2.h,
        ),
        getRoleOption(
            'assets/images/volunteer.png',
            'Here to volunteer & seek help ',
            RoleType.Volunteer,
            profileSetupController),
        SizedBox(
          height: 2.h,
        ),
        getRoleOption(
            'assets/images/provider.png',
            'Mental health professional ',
            RoleType.Provider,
            profileSetupController),
        SizedBox(
          height: 2.h,
        ),
        getRoleOption('assets/images/explorer.png', 'Here to explore Solh app',
            RoleType.Explorer, profileSetupController)
      ],
    );
  }
}

Widget getRoleOption(String iconPath, String roleText, RoleType roleType,
    ProfileSetupController profileSetupController) {
  return Obx(() {
    return InkWell(
      onTap: () => profileSetupController.selectedRoleType.value = roleType,
      child: Container(
        height: 6.h,
        decoration: BoxDecoration(
          color: SolhColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Image.asset(iconPath),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  roleText,
                  style: SolhTextStyles.QS_body_2_bold,
                ),
              ],
            ),
            profileSetupController.selectedRoleType.value == roleType
                ? Image.asset('assets/images/circularCheck.png')
                : Container()
          ]),
        ),
      ),
    );
  });
}

class BottomNote extends StatelessWidget {
  BottomNote({Key? key}) : super(key: key);
  final ProfileSetupController profileSetupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 1.h,
      ),
      Obx(() {
        return getBottomRole(profileSetupController.selectedRoleType.value);
      }),
      SizedBox(
        height: 2.5.h,
      ),
      Obx(() {
        return profileSetupController.selectedRoleType == RoleType.Provider
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: SolhTextStyles.SmallTextWhiteS12W7,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  TextField(
                    controller: profileSetupController.providerEmailController,
                    decoration: TextFieldStyles.greenF_greenBroadUF_4R(
                        hintText: 'john@email.com'),
                  ),
                ],
              )
            : Container();
      }),
    ]);
  }
}

String getUserType(RoleType roleType) {
  if (roleType == RoleType.Seeker) {
    return "Seeker";
  }
  if (roleType == RoleType.Volunteer) {
    return "SolhVolunteer";
  }
  if (roleType == RoleType.Provider) {
    return "SolhProvider";
  }
  if (roleType == RoleType.Explorer) {
    return "Seeker";
  } else {
    return "Undefined";
  }
}

Widget getBottomRole(RoleType roleType) {
  if (roleType == RoleType.Volunteer) {
    return Text(
      'Note: This role comes up with many important reponsibilities, our coaching manual & screening processes will guide you further.',
      style: SolhTextStyles.QS_body_2.copyWith(color: SolhColors.white),
    );
  }

  if (roleType == RoleType.Provider) {
    return Text(
      'To complete further processes, provide email-id below. E-mail from solh will guide you further',
      style: SolhTextStyles.QS_body_2.copyWith(color: SolhColors.white),
    );
  } else {
    return Container();
  }
}

String coditionChecker(ProfileSetupController profileSetupController) {
  if (!emailVarification(
      profileSetupController.providerEmailController.text.trim())) {
    if (profileSetupController.selectedRoleType == RoleType.Provider) {
      debugPrint('Please enter a valid email');
      return 'Please enter a valid email';
    } else {
      return '';
    }
  } else {
    return '';
  }
}

bool emailVarification(email) {
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return false;
  } else {
    return true;
  }
}
