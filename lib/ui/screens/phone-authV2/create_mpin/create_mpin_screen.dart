import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class CreateMpinScren extends StatelessWidget {
  const CreateMpinScren({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundArt(
      appBar: SolhAppBarTanasparentOnlyBackButton(
        onBackButton: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set Up mPIN',
              style: SolhTextStyles.Large2BlackTextS24W7,
            ),
            Text(
              'Please enter your 4 digit pin',
              style: SolhTextStyles.QS_body_2.copyWith(color: SolhColors.grey),
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              'Enter mPIN',
              style: SolhTextStyles.QS_body_2_semi,
            ),
            const SizedBox(
              height: 10,
            ),
            PinCodeTextField(
              appContext: context,
              length: 4,
              pinTheme: PinTheme(
                  inactiveColor: SolhColors.grey_2,
                  borderWidth: 1,
                  activeColor: SolhColors.primary_green,
                  shape: PinCodeFieldShape.box,
                  selectedColor: SolhColors.primary_green),
            ),
            const Text(
              'Confirm mPIN',
              style: SolhTextStyles.QS_body_2_semi,
            ),
            const SizedBox(
              height: 10,
            ),
            PinCodeTextField(
              appContext: context,
              length: 4,
              pinTheme: PinTheme(
                  inactiveColor: SolhColors.grey_2,
                  borderWidth: 1,
                  activeColor: SolhColors.primary_green,
                  shape: PinCodeFieldShape.box,
                  selectedColor: SolhColors.primary_green),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SolhGreenButton(
                    width: 70.w,
                    child: Text('Create mPIN',
                        style: SolhTextStyles.CTA
                            .copyWith(color: SolhColors.white))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
