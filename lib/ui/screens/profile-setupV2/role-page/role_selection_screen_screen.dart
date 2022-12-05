import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
import 'package:solh/widgets_constants/solh_snackBar.dart';

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
            if (profileSetupController.selectedRoleType.value !=
                RoleType.Undefined) {
              bool response = await profileSetupController.updateUserProfile({
                "userType":
                    getUserType(profileSetupController.selectedRoleType.value)
              });

              if (response) {
                Navigator.pushNamed(context, AppRoutes.needSupportOn);
              }
            } else {
              SolhSnackbar.error('Error', 'Choose a valid option');
            }
            // Navigator.pushNamed(context, AppRoutes.dobField);
          },
        );
      }),
      appBar: SolhAppBarTanasparentOnlyBackButton(
        backButtonColor: SolhColors.white,
        onBackButton: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            StepsProgressbar(stepNumber: 4),
            SizedBox(
              height: 3.h,
            ),
            RoleSectionText(),
            SizedBox(
              height: 3.h,
            ),
            RoleOptions()
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
                Text(roleText),
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
