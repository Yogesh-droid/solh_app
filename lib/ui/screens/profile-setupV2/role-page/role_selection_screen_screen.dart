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

enum RoleType {
  Seeker,
  Volunteer,
  Provider,
  Explorer,
}

class RoleSection extends StatelessWidget {
  const RoleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
      floatingActionButton:
          ProfileSetupFloatingActionButton.profileSetupFloatingActionButton(
              onPressed: () {
        Navigator.pushNamed(context, AppRoutes.needSupportOn);
      }),
      appBar: SolhAppBarTanasparentOnlyBackButton(
        backButtonColor: SolhColors.white,
        onBackButton: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            StepsProgressbar(stepNumber: 4),
            SizedBox(
              height: 3.h,
            ),
            RoleSectionText(),
            SizedBox(
              height: 3.h,
            ),
            RoleOptions()
          ],
        ),
      ),
    );
  }
}

class RoleSectionText extends StatelessWidget {
  const RoleSectionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select your role',
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "Don't worry, you can change this anytime in the future as and when your situation changes. For now, choose the best one suited to you. ",
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class RoleOptions extends StatelessWidget {
  const RoleOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getRoleOption('assets/images/seeker.png', 'Here to seek help', true),
        SizedBox(
          height: 2.h,
        ),
        getRoleOption('assets/images/volunteer.png',
            'Here to volunteer & seek help ', false),
        SizedBox(
          height: 2.h,
        ),
        getRoleOption('assets/images/provider.png',
            'Here to volunteer & seek help ', false),
        SizedBox(
          height: 2.h,
        ),
        getRoleOption(
            'assets/images/explorer.png', 'Here to explore Solh app', false)
      ],
    );
  }
}

Container getRoleOption(String iconPath, String roleText, bool isSelected) {
  return Container(
    height: 6.h,
    decoration: BoxDecoration(
      color: SolhColors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Image.asset(iconPath),
            SizedBox(
              width: 2.w,
            ),
            Text(roleText),
          ],
        ),
        isSelected
            ? Image.asset('assets/images/circularCheck.png')
            : Container()
      ]),
    ),
  );
}
