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

class PartOfAnOrganisationPage extends StatelessWidget {
  const PartOfAnOrganisationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
      floatingActionButton:
          ProfileSetupFloatingActionButton.profileSetupFloatingActionButton(
        onPressed: () => null,
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
            stepNumber: 6,
          ),
          SizedBox(
            height: 3.h,
          ),
          PartOfAnOrganisationtext(),
          SizedBox(
            height: 3.h,
          ),
          PartOfAnOrganisationField()
        ]),
      ),
    );
  }
}

class PartOfAnOrganisationtext extends StatelessWidget {
  const PartOfAnOrganisationtext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Part of an organisation ?',
          style: SolhTextStyles.Large2TextWhiteS24W7,
        ),
        Text(
          "Please provide details below if you are boarding as part of an organization.",
          style: SolhTextStyles.NormalTextWhiteS14W5,
        ),
      ],
    );
  }
}

class PartOfAnOrganisationField extends StatelessWidget {
  const PartOfAnOrganisationField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Organisation Type',
          style: SolhTextStyles.SmallTextWhiteS12W7,
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
        SizedBox(
          height: 2.h,
        ),
        Text(
          'Organisation Name',
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
