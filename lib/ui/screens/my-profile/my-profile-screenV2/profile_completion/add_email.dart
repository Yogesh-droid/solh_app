import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
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

class AddEmail extends StatelessWidget {
  AddEmail({Key? key}) : super(key: key);
  final ProfileCompletionController profileCompletionController = Get.find();
  final ProfileController profileController = Get.find();
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
                onPressed: () async {
                  if (profileCompletionController
                          .emailTextEditingController.text
                          .trim() !=
                      '') {
                    var response =
                        await profileCompletionController.updateUserProfile({
                      "email": profileCompletionController
                          .emailTextEditingController.text
                          .trim(),
                    });
                    if (response) {
                      SolhSnackbar.success("Success", " Email updated");
                      if (profileController.myProfileModel.value.body!
                          .userMoveEmptyScreenEmpty!.isNotEmpty) {
                        Navigator.pushNamed(
                            context,
                            profileCompletionController.getAppRoute(
                                profileController.myProfileModel.value.body!
                                    .userMoveEmptyScreenEmpty!.first));
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.master,
                          (route) => false,
                        );
                      }
                    } else {
                      SolhSnackbar.error('Error', 'Opps, Something went wrong');
                    }
                  } else {
                    SolhSnackbar.error(
                        'Error', 'Please update email or skip from above');
                  }
                });
      }),
      appBar: SolhAppBarTanasparentOnlyBackButton(
        onSkip: (() {
          int currentPageIndex =
              profileCompletionController.getPageFromIndex('addEmail');
          if (profileController
                  .myProfileModel.value.body!.userMoveEmptyScreenEmpty!.last !=
              currentPageIndex) {
            debugPrint(currentPageIndex.toString());
            Navigator.pushNamed(
                context,
                profileCompletionController.getNextPageOnSkip(
                    currentpageIndex: currentPageIndex));
            debugPrint(profileCompletionController.getNextPageOnSkip(
                currentpageIndex: currentPageIndex));
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.master,
              (route) => false,
            );
          }
        }),
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
          'Email-id',
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "We need your email for safekeeping your account. We promise to not spam you.  ",
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class EmailTextField extends StatelessWidget {
  EmailTextField({Key? key}) : super(key: key);
  final ProfileCompletionController profileCompletionController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
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
          controller: profileCompletionController.emailTextEditingController,
          decoration:
              TextFieldStyles.greenF_greenBroadUF_4R(hintText: 'your email-id'),
        ),
      ],
    );
  }
}
