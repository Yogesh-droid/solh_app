import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/user_type_controller.dart';
import 'package:solh/ui/screens/profile-setupV2/role-page/role_selection_screen_screen.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

class UserType extends StatelessWidget {
  UserType({Key? key}) : super(key: key);

  final UserTypeController userTypeController = Get.put(UserTypeController());

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundArt(
      appBar: SolhAppBar(
        title: Text(
          'User Type',
          style: SolhTextStyles.QS_body_2_bold,
        ),
        isLandingScreen: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            getRoleOption('assets/images/seeker.png', 'Here to seek help',
                RoleType.Seeker, userTypeController),
            SizedBox(
              height: 2.h,
            ),
            getRoleOption(
                'assets/images/volunteer.png',
                'Here to volunteer & seek help ',
                RoleType.Volunteer,
                userTypeController),
            SizedBox(
              height: 2.h,
            ),
            getRoleOption(
                'assets/images/provider.png',
                'Mental health professional',
                RoleType.Provider,
                userTypeController),
            SizedBox(
              height: 2.h,
            ),
            getRoleOption(
                'assets/images/explorer.png',
                'Here to explore Solh app',
                RoleType.Explorer,
                userTypeController),
            Expanded(child: SizedBox()),
            SaveChangesButton(),
            SizedBox(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}

Widget getRoleOption(String iconPath, String roleText, RoleType roleType,
    UserTypeController userTypeController) {
  return Obx(() {
    return InkWell(
      onTap: () => userTypeController.selectedUserType.value = roleType,
      child: Container(
        height: 6.h,
        decoration: BoxDecoration(
            color: SolhColors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: <BoxShadow>[
              BoxShadow(blurRadius: 2, color: Colors.black26)
            ]),
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
            userTypeController.selectedUserType.value == roleType
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

class SaveChangesButton extends StatelessWidget {
  SaveChangesButton({Key? key}) : super(key: key);

  final UserTypeController userTypeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return userTypeController.isUpdatingField.value
          ? SolhGreenBorderButton(
              child: ButtonLoadingAnimation(
              ballColor: SolhColors.primary_green,
              ballSizeLowerBound: 3,
              ballSizeUpperBound: 8,
            ))
          : (userTypeController.selectedUserType == RoleType.Undefined
              ? SolhGreenButton(
                  child: Text(
                    'Save chanages',
                    style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
                  ),
                  backgroundColor: SolhColors.Grey_1,
                )
              : SolhGreenButton(
                  onPressed: () async {
                    bool response = await userTypeController.updateUserProfile({
                      "userType":
                          getUserType(userTypeController.selectedUserType.value)
                    });
                    if (response) {
                      SolhSnackbar.success(
                          'Sucess', 'User type updated sucessfully');
                      FirebaseAnalytics.instance.logEvent(
                          name: 'OnBoardingUserTypeDone',
                          parameters: {'Page': 'OnBoarding'});
                    }
                  },
                  child: Text('Save chanages',
                      style:
                          SolhTextStyles.CTA.copyWith(color: SolhColors.white)),
                ));
    });
  }
}
