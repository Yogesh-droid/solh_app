import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/profile_completion_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/profileSetupFloatingActionButton.dart';
import 'package:solh/widgets_constants/constants/stepsProgressbar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

import '../../../../../widgets_constants/solh_snackbar.dart';

class EmergencyContacts extends StatelessWidget {
  EmergencyContacts({Key? key, required Map<String, dynamic> args})
      : indexOfpage = args['indexOfpage'],
        super(key: key);
  final ProfileCompletionController profileCompletionController = Get.find();
  ProfileController profileController = Get.find();
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
                onPressed: (() async {
                  if (profileCompletionController
                          .selectedConnection.isNotEmpty &&
                      profileCompletionController
                          .sosMessageTextEditingController.text
                          .trim()
                          .isNotEmpty) {
                    bool response =
                        await profileCompletionController.addSosContacts({
                      "emergencyContacts":
                          profileCompletionController.selectedConnection.value,
                      "message": profileCompletionController
                          .sosMessageTextEditingController.text
                          .trim(),
                    });
                    if (response) {
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
                    SolhSnackbar.error('Error',
                        'Connection selection and message ,both required');
                  }
                }));
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
          StepsProgressbar(stepNumber: 5),
          SizedBox(
            height: 3.h,
          ),
          EmergencyContactsText(),
          SizedBox(
            height: 3.h,
          ),
          AddEmergencyContacts(),
          SizedBox(
            height: 3.h,
          ),
          SosMessage()
        ]),
      ),
    );
  }
}

class EmergencyContactsText extends StatelessWidget {
  const EmergencyContactsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Emergency Contact'.tr,
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "It is always good to have someone on speed dial isn't it?".tr,
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class AddEmergencyContacts extends StatelessWidget {
  AddEmergencyContacts({Key? key}) : super(key: key);

  final ProfileCompletionController profileCompletionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Connection'.tr,
          style: SolhTextStyles.SmallTextWhiteS12W7,
        ),
        SizedBox(
          height: 1.h,
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ModelBottomsheetContent();
                });
          },
          child: Container(
            height: 6.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: SolhColors.white,
                border: Border.all(color: SolhColors.primary_green, width: 3),
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select'.tr,
                    style: SolhTextStyles.QS_body_2.copyWith(
                        color: SolhColors.Grey_1),
                  ),
                  Row(
                    children: [
                      Obx(() {
                        return Text(
                          '${profileCompletionController.selectedConnection.length} selected',
                          style: SolhTextStyles.QS_cap_semi,
                        );
                      }),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: SolhColors.primary_green,
                        size: 20,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SosMessage extends StatelessWidget {
  SosMessage({Key? key}) : super(key: key);

  final ProfileCompletionController profileCompletionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SOS Message'.tr,
          style: SolhTextStyles.SmallTextWhiteS12W7,
        ),
        SizedBox(
          height: 1.h,
        ),
        TextField(
          controller:
              profileCompletionController.sosMessageTextEditingController,
          maxLines: 5,
          minLines: 4,
          decoration:
              TextFieldStyles.greenF_greenBroadUF_4R(hintText: 'Message'.tr),
        ),
      ],
    );
  }
}

class ModelBottomsheetContent extends StatelessWidget {
  ModelBottomsheetContent({Key? key}) : super(key: key);
  final ConnectionController _connectionController = Get.find();
  final ProfileCompletionController _profileCompletionController =
      Get.put(ProfileCompletionController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select People'.tr,
                      style: SolhTextStyles.QS_body_1_bold,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              )
            ],
          ),
        ),
        SizedBox(
          height: 6,
        ),
        _connectionController.myConnectionModel.value.myConnections!.length == 0
            ? Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.grey.shade300,
                      size: 100,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Oops! No connection found.',
                        style: SolhTextStyles.QS_body_2)
                  ],
                ),
              )
            : Expanded(
                child: ListView.builder(
                    itemCount: _connectionController
                        .myConnectionModel.value.myConnections!.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        return InkWell(
                          onTap: () {
                            if (_profileCompletionController.selectedConnection
                                .contains(_connectionController
                                    .myConnectionModel
                                    .value
                                    .myConnections![index]
                                    .sId)) {
                              _profileCompletionController.selectedConnection
                                  .remove(_connectionController
                                      .myConnectionModel
                                      .value
                                      .myConnections![index]
                                      .sId);
                            } else {
                              _profileCompletionController.selectedConnection
                                  .add(_connectionController.myConnectionModel
                                      .value.myConnections![index].sId);
                            }
                            print(_profileCompletionController
                                .selectedConnection);
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Row(
                                children: [
                                  SimpleImageContainer(
                                    imageUrl: _connectionController
                                        .myConnectionModel
                                        .value
                                        .myConnections![index]
                                        .profilePicture!,
                                    radius: 50,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 0, 30, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _connectionController
                                                .myConnectionModel
                                                .value
                                                .myConnections![index]
                                                .name!,
                                            style:
                                                SolhTextStyles.QS_body_2_bold,
                                          ),
                                          Text(
                                            _connectionController
                                                .myConnectionModel
                                                .value
                                                .myConnections![index]
                                                .bio!,
                                            style: SolhTextStyles.QS_caption,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    side: MaterialStateBorderSide.resolveWith(
                                      (states) => BorderSide(
                                          width: 1.0, color: Colors.white),
                                    ),
                                    activeColor: SolhColors.primary_green,
                                    value: _profileCompletionController
                                        .selectedConnection
                                        .contains(_connectionController
                                            .myConnectionModel
                                            .value
                                            .myConnections![index]
                                            .sId),
                                    shape: CircleBorder(),
                                    onChanged: (bool? value) {
                                      // if (_tagsController.selectedTags[index]) {
                                      //   print('ran if 2');
                                      //   _tagsController.selectedTags[index] = true;
                                      // }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    }),
              )
      ],
    );
  }
}
