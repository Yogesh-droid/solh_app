import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/init-app.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/shared_prefrences/shared_prefrences_singleton.dart';
import 'package:solh/ui/screens/phone-authV2/phone-auth-controller/phone_auth_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

class EnterMpinScreen extends StatelessWidget {
  EnterMpinScreen({super.key, required Map<dynamic, dynamic> args})
      : _phoneNumber = args['phoneNumber'];

  final String _phoneNumber;
  final PhoneAuthController phoneAuthController = Get.find();

  final TextEditingController pinController = TextEditingController();

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
              'Login With mPIN',
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
              controller: pinController,
              appContext: context,
              length: 4,
              pinTheme: PinTheme(
                  inactiveColor: SolhColors.grey_2,
                  borderWidth: 1,
                  activeColor: SolhColors.primary_green,
                  shape: PinCodeFieldShape.box,
                  selectedColor: SolhColors.primary_green),
            ),
            InkWell(
              onTap: () async {
                await phoneAuthController.signInWithPhoneNumber(
                    context, phoneAuthController.country);
              },
              child: Text(
                'Forgot mPIN? Login with OTP.',
                style: SolhTextStyles.CTA
                    .copyWith(color: SolhColors.primary_green),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return phoneAuthController.isVerifyingPin.value
                      ? const ButtonLoadingAnimation()
                      : SolhGreenButton(
                          onPressed: () async {
                            if (pinController.text.trim() != '') {
                              (String, bool) response =
                                  await phoneAuthController.verifyPin(
                                      _phoneNumber, pinController.text.trim());
                              print(response);
                              if (response.$2) {
                                await Prefs.setString("phone", _phoneNumber);
                                await isNewUser();

                                if (context.mounted) {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.master);
                                }
                              } else {
                                SolhSnackbar.error('Error', response.$1);
                              }
                            }
                          },
                          width: 70.w,
                          child: Text('Continue',
                              style: SolhTextStyles.CTA
                                  .copyWith(color: SolhColors.white)));
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
