import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/home/chat-anonymously/chat-anon-controller/chat_anon_controller.dart';
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

class AnonymousProfile extends StatelessWidget {
  AnonymousProfile({Key? key, required Map<String, dynamic> args})
      : indexOfpage = args['indexOfpage'],
        formAnonChat = args['formAnonChat'],
        super(key: key);
  final ProfileCompletionController profileCompletionController = Get.find();
  final ProfileController profileController = Get.find();
  final ChatAnonController chatAnonController = Get.find();
  final int indexOfpage;
  final bool? formAnonChat;
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
                  if (profileCompletionController
                          .anonNameTextEditingController.text
                          .trim() !=
                      '') {
                    print(profileCompletionController.anonImageUrl.value +
                        '---------');
                    String url =
                        profileCompletionController.anonImageUrl.value.trim() ==
                                ''
                            ? ''
                            : await profileCompletionController.uploadImage(
                                profileCompletionController.anonImageUrl.value,
                                "file",
                                "anonymous");

                    bool response = await profileCompletionController
                        .updateUserAnonProfile({
                      "profilePicture": url,
                      "userName": profileCompletionController
                          .anonNameTextEditingController.text,
                    });
                    if (response) {
                      SolhSnackbar.success(
                        "Success",
                        "Anonymous profile updated",
                      );

                      if (formAnonChat == true) {
                        Navigator.pushNamed(context, AppRoutes.chatUser,
                            arguments: {
                              "imageUrl": chatAnonController.chatAnonModel.value
                                  .sosChatSupport!.first.profilePicture,
                              "name": chatAnonController.chatAnonModel.value
                                  .sosChatSupport!.first.name,
                              "sId": chatAnonController.chatAnonModel.value
                                  .sosChatSupport!.first.sId,
                              "isAnonChat": true
                            });
                      } else {
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
                      }
                    } else {
                      SolhSnackbar.error('Error', 'Opps, Something went wrong');
                    }
                  } else {
                    SolhSnackbar.error(
                        'Error', 'Please update anonymous or skip from above');
                  }
                });
      }),
      appBar: SolhAppBarTanasparentOnlyBackButton(
        onSkip: (() {
          if (formAnonChat == true) {
          } else {
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
          }
        }),
        backButtonColor: SolhColors.white,
        onBackButton: (() {
          Navigator.of(context).pop();
        }),
        skipButtonStyle: SolhTextStyles.CTA.copyWith(
            color: formAnonChat == null
                ? SolhColors.white
                : SolhColors.primary_green),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            formAnonChat == null
                ? StepsProgressbar(stepNumber: 3)
                : Container(),
            SizedBox(
              height: 3.h,
            ),
            AnonymousProfileText(),
            SizedBox(
              height: 3.h,
            ),
            AddAnonymousProfileImage(),
            AnonymousNameTextField()
          ],
        ),
      ),
    );
  }
}

class AnonymousProfileText extends StatelessWidget {
  const AnonymousProfileText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anonymous Profile',
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "Post or leave a comment, join group, book appointment, etc anonymously. ",
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class AddAnonymousProfileImage extends StatelessWidget {
  AddAnonymousProfileImage({Key? key}) : super(key: key);
  final ProfileCompletionController profileCompletionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        XFile? image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        image != null
            ? profileCompletionController.anonImageUrl.value = image.path
            : profileCompletionController.anonImageUrl.value = '';
        print('dfsdf' +
            profileCompletionController.anonImageUrl.value +
            '/////////////');
      },
      child: Stack(
        children: [
          Obx(() {
            return Container(
              width: 25.w,
              height: 25.w,
              decoration: BoxDecoration(
                color: SolhColors.white,
                shape: BoxShape.circle,
              ),
              child: profileCompletionController.anonImageUrl.value == ''
                  ? Center(child: SvgPicture.asset("assets/images/anon.svg"))
                  : CircleAvatar(
                      radius: 20.w,
                      backgroundImage: FileImage(
                          File(profileCompletionController.anonImageUrl.value)),
                    ),
            );
          }),
          Positioned(
            bottom: 0.w,
            right: 0,
            child: Container(
              height: 8.w,
              width: 8.w,
              decoration: BoxDecoration(
                color: SolhColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: SolhColors.primary_green,
                ),
              ),
              child: Icon(
                Icons.add_sharp,
                size: 15,
                color: SolhColors.primary_green,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AnonymousNameTextField extends StatelessWidget {
  AnonymousNameTextField({Key? key}) : super(key: key);
  final ProfileCompletionController profileCompletionController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anonymous Name',
          style: SolhTextStyles.SmallTextWhiteS12W7,
        ),
        SizedBox(
          height: 1.h,
        ),
        TextField(
          controller: profileCompletionController.anonNameTextEditingController,
          decoration:
              TextFieldStyles.greenF_greenBroadUF_4R(hintText: 'Anonymous'),
        ),
      ],
    );
  }
}
