import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/profileSetupFloatingActionButton.dart';
import 'package:solh/widgets_constants/constants/stepsProgressbar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class DobField extends StatelessWidget {
  const DobField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
      floatingActionButton:
          ProfileSetupFloatingActionButton.profileSetupFloatingActionButton(
              onPressed: (() {
        Navigator.pushNamed(context, AppRoutes.genderField);
      })),
      appBar: SolhAppBarTanasparentOnlyBackButton(
        backButtonColor: SolhColors.white,
        onBackButton: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
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

class DOBTextField extends StatelessWidget {
  const DOBTextField({Key? key}) : super(key: key);

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
            getDobContainer('DD'),
            getDobContainer('MM'),
            getDobContainer('YYYY')
          ],
        )
      ],
    );
  }
}

Container getDobContainer(String label) {
  return Container(
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
          child: Text(label, style: SolhTextStyles.NormalTextGreyS14W5)),
    ),
  );
}
