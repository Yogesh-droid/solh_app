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
import 'package:solh/widgets_constants/solh_snackbar.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

import '../../../../../widgets_constants/solh_snackbar.dart';

class Bio extends StatelessWidget {
  Bio({Key? key, required Map<String, dynamic> args})
      : indexOfpage = args['indexOfpage'],
        super(key: key);

  final ProfileCompletionController profileCompletionController = Get.find();
  final ProfileController profileController = Get.find();
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
                onPressed: () async {
                  profileCompletionController.isUpdatingField.value = true;
                  if (profileCompletionController.bioTextEditingController.text
                          .trim() !=
                      '') {
                    var response = await profileCompletionController
                        .updateUserProfile({
                      "bio": profileCompletionController
                          .bioTextEditingController.text
                    });
                    if (response) {
                      SolhSnackbar.success("Success", "Bio updated");

                      if (profileCompletionController.uncompleteFields.last !=
                          profileCompletionController
                              .uncompleteFields[indexOfpage]) {
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
                    } else {
                      SolhSnackbar.error('Error', 'Opps, Something went wrong');
                    }
                  } else {
                    SolhSnackbar.error(
                        'Error', 'Please enter valid text or skip from above');
                  }
                });
      }),
      appBar: SolhAppBarTanasparentOnlyBackButton(
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
        backButtonColor: SolhColors.white,
        onBackButton: (() {
          Navigator.of(context).pop();
        }),
        skipButtonStyle: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 3.h,
          ),
          StepsProgressbar(stepNumber: 2),
          SizedBox(
            height: 3.h,
          ),
          BioText(),
          SizedBox(
            height: 3.h,
          ),
          BioTextField()
        ]),
      ),
    );
  }
}

class BioText extends StatelessWidget {
  const BioText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Something about you...',
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "Tell something about you ",
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class BioTextField extends StatelessWidget {
  BioTextField({Key? key}) : super(key: key);

  final ProfileCompletionController profileCompletionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bio',
          style: SolhTextStyles.SmallTextWhiteS12W7,
        ),
        SizedBox(
          height: 1.h,
        ),
        TextField(
          controller: profileCompletionController.bioTextEditingController,
          maxLines: null,
          decoration:
              TextFieldStyles.greenF_greenBroadUF_4R(hintText: 'write here'),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}
