import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/profileSetupFloatingActionButton.dart';
import 'package:solh/widgets_constants/constants/stepsProgressbar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

class NameField extends StatelessWidget {
  const NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
      floatingActionButton:
          ProfileSetupFloatingActionButton.profileSetupFloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.dobField),
      ),
      appBar: SolhAppBarTanasparentOnlyBackButton(
          backButtonColor: SolhColors.white,
          onBackButton: () => Navigator.of(context).pop()),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(children: [
          StepsProgressbar(
            stepNumber: 1,
          ),
          SizedBox(
            height: 3.h,
          ),
          WhatShouldWeCallYou(),
          SizedBox(
            height: 3.h,
          ),
          NameTextField()
        ]),
      ),
    );
  }
}

class WhatShouldWeCallYou extends StatelessWidget {
  const WhatShouldWeCallYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What should we call you?',
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "It helps us to know your real name, don't worry we won't share it with anyone without your permission. ",
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class NameTextField extends StatelessWidget {
  const NameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'First Name',
          style: SolhTextStyles.SmallTextWhiteS12W7,
        ),
        SizedBox(
          height: 1.h,
        ),
        TextField(
          decoration: TextFieldStyles.greenF_greenBroadUF_4R(hintText: null),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          'Last Name',
          style: SolhTextStyles.SmallTextWhiteS12W7,
        ),
        SizedBox(
          height: 1.h,
        ),
        TextField(
          decoration: TextFieldStyles.greenF_greenBroadUF_4R(hintText: null),
        ),
      ],
    );
  }
}
