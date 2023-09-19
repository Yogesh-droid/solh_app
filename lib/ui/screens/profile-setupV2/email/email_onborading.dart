import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
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

import 'package:solh/widgets_constants/text_field_styles.dart';

import '../../../../../widgets_constants/solh_snackbar.dart';

class AddEmailOnboarding extends StatelessWidget {
  AddEmailOnboarding({
    Key? key,
  }) : super(key: key);
  final ProfileSetupController profileSetupController = Get.find();
  final ProfileController profileController = Get.find();

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
                  if (profileSetupController.emailTextEditingController.text
                              .trim() !=
                          '' &&
                      emailVarification(profileSetupController
                          .emailTextEditingController.text
                          .trim())) {
                    var response =
                        await profileSetupController.updateUserProfile({
                      "email": profileSetupController
                          .emailTextEditingController.text
                          .trim(),
                    });
                    if (response) {
                      SolhSnackbar.success("Success", " Email updated");
                      Navigator.pushNamed(context, AppRoutes.dobField);
                    } else {
                      SolhSnackbar.error('Error', 'Opps, Something went wrong');
                    }
                  } else {
                    SolhSnackbar.error('Error', 'Please enter a correct email');
                  }
                });
      }),
      appBar: SolhAppBarTanasparentOnlyBackButton(
        backButtonColor: SolhColors.white,
        onBackButton: (() {
          Navigator.of(context).pop();
        }),
        skipButtonStyle: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(children: [
          StepsProgressbar(stepNumber: 4),
          SizedBox(
            height: 3.h,
          ),
          AddEmailText(),
          SizedBox(
            height: 3.h,
          ),
          EmailTextField()
        ]),
      ),
    );
  }
}

class AddEmailText extends StatelessWidget {
  const AddEmailText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email-id'.tr,
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "We need your email for safekeeping your account. We promise to not spam you."
              .tr,
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class EmailTextField extends StatelessWidget {
  EmailTextField({Key? key}) : super(key: key);
  final ProfileSetupController profileSetupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email'.tr,
          style: SolhTextStyles.SmallTextWhiteS12W7,
        ),
        SizedBox(
          height: 1.h,
        ),
        TextField(
          controller: profileSetupController.emailTextEditingController,
          decoration: TextFieldStyles.greenF_greenBroadUF_4R(
              hintText: 'your email-id'.tr),
        ),
      ],
    );
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
