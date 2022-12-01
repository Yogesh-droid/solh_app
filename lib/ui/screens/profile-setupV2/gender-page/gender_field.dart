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

class GenderField extends StatelessWidget {
  const GenderField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
      floatingActionButton:
          ProfileSetupFloatingActionButton.profileSetupFloatingActionButton(
              onPressed: () {
        Navigator.pushNamed(context, AppRoutes.roleField);
      }),
      appBar: SolhAppBarTanasparentOnlyBackButton(
        backButtonColor: SolhColors.white,
        onBackButton: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            StepsProgressbar(stepNumber: 3),
            SizedBox(
              height: 3.h,
            ),
            GenderText(),
            SizedBox(
              height: 3.h,
            ),
            GenderSelection()
          ],
        ),
      ),
    );
  }
}

class GenderText extends StatelessWidget {
  const GenderText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Whats your gender ?',
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "If you don't conform to any of the options below, don't worry. We've got space for everybody",
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class GenderSelection extends StatelessWidget {
  const GenderSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: SolhTextStyles.NormalTextWhiteS14W6,
        ),
        SizedBox(
          height: 1.h,
        ),
        Container(
          height: 6.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: SolhColors.white,
              border: Border.all(color: SolhColors.green, width: 3),
              borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select',
                  style: SolhTextStyles.NormalTextGreyS14W5,
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: SolhColors.green,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
