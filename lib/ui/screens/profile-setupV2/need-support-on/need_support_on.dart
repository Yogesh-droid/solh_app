import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/profile-setupV2/profile-setup-controller/profile_setup_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/profileSetupFloatingActionButton.dart';
import 'package:solh/widgets_constants/constants/stepsProgressbar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

class NeedSupportOn extends StatelessWidget {
  NeedSupportOn({Key? key}) : super(key: key);

  final ProfileSetupController profileSetupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundArt(
      floatingActionButton:
          ProfileSetupFloatingActionButton.profileSetupFloatingActionButton(
        child: profileSetupController.isUpdatingField.value
            ? SolhSmallButtonLoader()
            : const Icon(
                Icons.chevron_right_rounded,
                size: 40,
              ),
        onPressed: (() async {
          bool response = await profileSetupController.updateUserProfile({
            "issueList": profileSetupController.selectedIsses.value.toString(),
            "issueOther":
                profileSetupController.selectedOtherIssues.value.toString(),
          });

          if (response) {
            Navigator.pushNamed(context, AppRoutes.partOfAnOrgnisation);
          }
        }),
      ),
      appBar: SolhAppBarTanasparentOnlyBackButton(
        backButtonColor: SolhColors.black666,
        onBackButton: () => Navigator.of(context).pop(),
        onSkip: (() =>
            Navigator.pushNamed(context, AppRoutes.partOfAnOrgnisation)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            StepsProgressbar(
              stepNumber: 5,
              bottomBarcolor: SolhColors.grey239,
              upperBarcolor: SolhColors.primary_green,
            ),
            SizedBox(
              height: 3.h,
            ),
            NeedSupportOnText(),
            SizedBox(
              height: 3.h,
            ),
            Expanded(
              child: ListView(
                children: [
                  IssueChips(),
                  OtherIssueList(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: FilterChip(
                      label: Text('Other'),
                      onSelected: (value) {
                        if (value) {
                          profileSetupController.showOtherissueField.value =
                              true;
                        }
                      },
                      backgroundColor: SolhColors.grey239,
                      side: BorderSide(color: SolhColors.primary_green),
                    ),
                  ),
                  Obx(() {
                    return profileSetupController.showOtherissueField.value
                        ? Column(
                            children: [
                              TextField(
                                controller:
                                    profileSetupController.otherIssueTextField,
                                decoration: TextFieldStyles.greenF_greyUF_4R
                                    .copyWith(hintText: " Enter Custom issue"),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              SolhGreenMiniButton(
                                onPressed: (() {
                                  profileSetupController.selectedOtherIssues
                                      .add(profileSetupController
                                          .otherIssueTextField.text);
                                  profileSetupController
                                      .otherIssueTextField.text = '';
                                  profileSetupController
                                      .showOtherissueField.value = false;
                                }),
                                child: Text(
                                  'Add',
                                  style: SolhTextStyles.NormalTextWhiteS14W6,
                                ),
                              )
                            ],
                          )
                        : Container();
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NeedSupportOnText extends StatelessWidget {
  const NeedSupportOnText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Need support on',
          style: SolhTextStyles.Large2BlackTextS24W7,
        ),
        Text(
          "Give us a rough idea of the issues that you deal with on a daily basis. You may select more than one.  ",
          style: SolhTextStyles.NormalTextGreyS14W5,
        ),
      ],
    );
  }
}

class IssueChips extends StatefulWidget {
  const IssueChips({Key? key}) : super(key: key);

  @override
  State<IssueChips> createState() => _IssueChipsState();
}

class _IssueChipsState extends State<IssueChips> {
  ProfileSetupController profileSetupController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    profileSetupController.getNeedSupportOnIssues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return profileSetupController.isLoadingIssues.value
          ? Center(
              child: MyLoader(),
            )
          : Wrap(
              spacing: 5,
              children: profileSetupController
                  .needSupportOnModel.value.specialization!
                  .map((e) => FilterChip(
                      onSelected: (value) {
                        print(profileSetupController.selectedIsses.toString());
                        value
                            ? profileSetupController.selectedIsses.value
                                .add(e.sId)
                            : profileSetupController.selectedIsses.value
                                .remove(e.sId);
                        setState(() {});
                      },
                      selected:
                          profileSetupController.selectedIsses.contains(e.sId),
                      selectedColor: SolhColors.primary_green,
                      backgroundColor: SolhColors.grey239,
                      checkmarkColor:
                          profileSetupController.selectedIsses.contains(e.sId)
                              ? SolhColors.white
                              : SolhColors.black,
                      label:
                          profileSetupController.selectedIsses.contains(e.sId)
                              ? Text(
                                  e.slug!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(color: SolhColors.white),
                                )
                              : Text(
                                  e.slug!,
                                  style: Theme.of(context).textTheme.headline1,
                                )))
                  .toList());
    });
  }
}

class OtherIssueList extends StatelessWidget {
  OtherIssueList({Key? key}) : super(key: key);
  final ProfileSetupController profileSetupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Wrap(
        spacing: 5,
        children:
            profileSetupController.selectedOtherIssues.value.map((element) {
          return FilterChip(
            showCheckmark: false,
            selectedColor: SolhColors.primary_green,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.cancel_outlined,
                  size: 19,
                  color: SolhColors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  element,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: SolhColors.white),
                ),
              ],
            ),
            onSelected: (Value) {
              profileSetupController.selectedOtherIssues.remove(element);
            },
            selected: true,
          );
        }).toList(),
      );
    });
  }
}
