import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

class AddAvatar extends StatelessWidget {
  AddAvatar({Key? key}) : super(key: key);
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
                  profileCompletionController.isUpdatingField.value = true;
                  if (profileCompletionController.imageUrl.value != '') {
                    String url = await profileCompletionController.uploadImage(
                        profileCompletionController.imageUrl.value,
                        "profile",
                        "user-profile-picture");

                    var response = await profileCompletionController
                        .updateUserProfile({"profilePicture": url});
                    if (response) {
                      SolhSnackbar.success("Success", "Avatar uploaded");
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
                        'Error', 'Please set an avatar or skip from above');
                  }
                });
      }),
      appBar: SolhAppBarTanasparentOnlyBackButton(
        onSkip: (() {
          int currentPageIndex =
              profileCompletionController.getPageFromIndex('avatar');
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
        child: Column(
          children: [
            StepsProgressbar(stepNumber: 1),
            SizedBox(
              height: 3.h,
            ),
            AddAvatarText(),
            SizedBox(
              height: 3.h,
            ),
            AddImageContainer(),
          ],
        ),
      ),
    );
  }
}

class AddAvatarText extends StatelessWidget {
  const AddAvatarText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add an avatar',
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "Upload a pciture or choose one from our library of images that describes you best. ",
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class AddImageContainer extends StatelessWidget {
  AddImageContainer({Key? key}) : super(key: key);
  final ProfileCompletionController profileCompletionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        XFile? image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        image != null
            ? profileCompletionController.imageUrl.value = image.path
            : profileCompletionController.imageUrl.value = '';
      },
      child: Obx(() {
        return Stack(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: SolhColors.white,
                shape: BoxShape.circle,
              ),
              child: profileCompletionController.imageUrl.value == ''
                  ? Center(
                      child: Icon(
                      Icons.person_rounded,
                      size: 15.w,
                      color: SolhColors.primary_green,
                    ))
                  : CircleAvatar(
                      radius: 20.w,
                      backgroundImage: FileImage(
                          File(profileCompletionController.imageUrl.value)),
                    ),
            ),
            Positioned(
              bottom: 4.w,
              right: 0,
              child: Container(
                height: 10.w,
                width: 10.w,
                decoration: BoxDecoration(
                  color: SolhColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: SolhColors.primary_green,
                  ),
                ),
                child: Icon(
                  Icons.add_sharp,
                  color: SolhColors.primary_green,
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
