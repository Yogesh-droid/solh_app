import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:solh/widgets_constants/solh_snackbar.dart';

class DobField extends StatelessWidget {
  DobField({Key? key}) : super(key: key);

  ProfileSetupController profileSetupController = Get.find();

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
          onPressed: (() async {
            if (DateTime(
                    profileSetupController.dobDate.value.day,
                    profileSetupController.dobDate.value.month,
                    profileSetupController.dobDate.value.year) !=
                DateTime(DateTime.now().day, DateTime.now().month,
                    DateTime.now().year)) {
              bool response = await profileSetupController.updateUserProfile({
                "dob": profileSetupController.dobDate.value.toString(),
              });

              if (response) {
                Navigator.pushNamed(context, AppRoutes.master);
                FirebaseAnalytics.instance.logEvent(
                    name: 'OnBoardingDobDone',
                    parameters: {'Page': 'OnBoarding'});
              }
            } else {
              SolhSnackbar.error('Error', 'Enter a valid date');
            }
          }),
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
            StepsProgressbar(stepNumber: 2),
            SizedBox(
              height: 3.h,
            ),
            WhenIsBirthday(),
            SizedBox(
              height: 2.h,
            ),
            DOBTextField()
          ],
        ),
      ),
    );
  }
}

class WhenIsBirthday extends StatelessWidget {
  const WhenIsBirthday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'When is your birthday ?',
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "We want to know how many years of experience you have dealing with life :) ",
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class DOBTextField extends StatefulWidget {
  const DOBTextField({Key? key}) : super(key: key);

  @override
  State<DOBTextField> createState() => _DOBTextFieldState();
}

class _DOBTextFieldState extends State<DOBTextField> {
  ProfileSetupController profileSetupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DOB',
          style: SolhTextStyles.NormalTextWhiteS14W6,
        ),
        SizedBox(
          height: 1.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetDobContainer(
              label: 'DD',
            ),
            GetDobContainer(
              label: 'MM',
            ),
            GetDobContainer(
              label: 'YYYY',
            ),
          ],
        )
      ],
    );
  }
}

class GetDobContainer extends StatelessWidget {
  GetDobContainer({Key? key, required this.label}) : super(key: key);

  final String label;
  ProfileSetupController profileSetupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDialog(
        Stack(
          children: [
            CupertinoDatePicker(
              dateOrder: DatePickerDateOrder.dmy,
              maximumDate: DateTime.now().add(Duration(days: 1)),
              initialDateTime: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
              // This is called when the user changes the date.
              onDateTimeChanged: (DateTime newDate) {
                profileSetupController.dobDate.value = newDate;
              },
            ),
            Positioned(
              right: 10,
              child: Material(
                child: InkWell(
                  onTap: (() {
                    print('sdfsdfsdf');
                    Navigator.of(context).pop();
                  }),
                  child: Icon(
                    Icons.cancel,
                    size: 30,
                    color: SolhColors.primary_green,
                  ),
                ),
              ),
            ),
          ],
        ),
        context,
      ),
      child: Container(
        height: 6.h,
        width: 25.w,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: SolhColors.primary_green,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Obx(() {
                return DateTime(
                            profileSetupController.dobDate.value.day,
                            profileSetupController.dobDate.value.month,
                            profileSetupController.dobDate.value.year) ==
                        DateTime(DateTime.now().day, DateTime.now().month,
                            DateTime.now().year)
                    ? Text(label, style: SolhTextStyles.NormalTextGreyS14W5)
                    : Text(
                        getDate(profileSetupController.dobDate.value, label),
                        style: SolhTextStyles.NormalTextBlack2S14W6,
                      );
              })),
        ),
      ),
    );
  }
}

String getDate(DateTime date, String label) {
  if (label == 'DD') {
    return date.day.toString();
  }
  if (label == 'MM') {
    return date.month.toString();
  }
  if (label == 'YYYY') {
    return date.year.toString();
  } else {
    return '';
  }
}

_showDialog(Widget child, context) {
  return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            // The Bottom margin is provided to align the popup above the system navigation bar.
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            // Provide a background color for the popup.
            color: CupertinoColors.systemBackground.resolveFrom(context),
            // Use a SafeArea widget to avoid system overlaps.
            child: SafeArea(
              top: false,
              child: child,
            ),
          ));
}
