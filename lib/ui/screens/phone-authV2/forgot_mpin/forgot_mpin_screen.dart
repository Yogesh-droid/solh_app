import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/init-app.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/shared_prefrences/shared_prefrences_singleton.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/phone-authV2/phone-auth-controller/phone_auth_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ForgotMpinScreen extends StatefulWidget {
  const ForgotMpinScreen({super.key});

  @override
  State<ForgotMpinScreen> createState() => _ForgotMpinScreenState();
}

class _ForgotMpinScreenState extends State<ForgotMpinScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController otpController = TextEditingController();

  final TextEditingController newPinController = TextEditingController();

  final TextEditingController confirmPinController = TextEditingController();

  final PhoneAuthController phoneAuthController = Get.find();

  @override
  void dispose() {
    phoneAuthController.isOtpVerified.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundArt(
      appBar: SolhAppBarTanasparentOnlyBackButton(
        onBackButton: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reset mPIN',
                  style: SolhTextStyles.Large2BlackTextS24W7,
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  'Enter OTP',
                  style: SolhTextStyles.QS_body_2_semi,
                ),
                const SizedBox(
                  height: 10,
                ),
                PinCodeTextField(
                  controller: otpController,
                  mainAxisAlignment: MainAxisAlignment.start,
                  validator: (value) {
                    if (otpController.text.trim() == '') {
                      return 'OTP can\'t be empty';
                    }
                    return null;
                  },
                  obscureText: true,
                  appContext: context,
                  length: 6,
                  keyboardType: TextInputType.number,
                  separatorBuilder: (a, b) {
                    return const SizedBox(
                      width: 20,
                    );
                  },
                  pinTheme: PinTheme(
                      disabledColor: SolhColors.grey_3,
                      inactiveColor: SolhColors.Grey_1,
                      borderWidth: 1,
                      activeColor: SolhColors.primary_green,
                      borderRadius: BorderRadius.circular(8),
                      shape: PinCodeFieldShape.box,
                      selectedColor: SolhColors.primary_green),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return phoneAuthController.isVerifyingOtp.value
                          ? const ButtonLoadingAnimation()
                          : SolhGreenButton(
                              onPressed: () async {
                                if (otpController.text.trim() != '') {
                                  Map<String, dynamic> response =
                                      await phoneAuthController.verifyCode(
                                          phoneAuthController.countryCode,
                                          phoneAuthController.countryCode +
                                              phoneAuthController
                                                  .phoneNumber.text,
                                          otpController.text);

                                  phoneAuthController.isOtpVerified.value =
                                      response['success'];
                                  Utility.showToast(
                                      response['message'].toString());
                                } else {
                                  Utility.showToast(
                                      'OTP field can\'t be empty');
                                }
                              },
                              width: 70.w,
                              child: Text('Verify OTP',
                                  style: SolhTextStyles.CTA
                                      .copyWith(color: SolhColors.white)));
                    }),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  'Enter new mPIN',
                  style: SolhTextStyles.QS_body_2_semi,
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  return PinCodeTextField(
                    enabled: phoneAuthController.isOtpVerified.value,
                    controller: newPinController,
                    mainAxisAlignment: MainAxisAlignment.start,
                    separatorBuilder: (a, b) {
                      return const SizedBox(
                        width: 20,
                      );
                    },
                    validator: (value) {
                      if (newPinController.text.trim() == '') {
                        return "Field can't be empty";
                      }
                      return null;
                    },
                    appContext: context,
                    length: 4,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                        disabledColor: SolhColors.grey_3,
                        inactiveColor: SolhColors.Grey_1,
                        borderWidth: 1,
                        activeColor: SolhColors.primary_green,
                        borderRadius: BorderRadius.circular(8),
                        shape: PinCodeFieldShape.box,
                        selectedColor: SolhColors.primary_green),
                  );
                }),
                const Text(
                  'Confirm mPIN',
                  style: SolhTextStyles.QS_body_2_semi,
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  return PinCodeTextField(
                    enabled: phoneAuthController.isOtpVerified.value,
                    controller: confirmPinController,
                    mainAxisAlignment: MainAxisAlignment.start,
                    obscureText: true,
                    validator: (value) {
                      if (newPinController.text.trim() !=
                          confirmPinController.text.trim()) {
                        return 'Pin not matched';
                      }
                      return null;
                    },
                    appContext: context,
                    length: 4,
                    keyboardType: TextInputType.number,
                    separatorBuilder: (a, b) {
                      return const SizedBox(
                        width: 20,
                      );
                    },
                    pinTheme: PinTheme(
                        disabledColor: SolhColors.grey_3,
                        inactiveColor: SolhColors.Grey_1,
                        borderWidth: 1,
                        activeColor: SolhColors.primary_green,
                        borderRadius: BorderRadius.circular(8),
                        shape: PinCodeFieldShape.box,
                        selectedColor: SolhColors.primary_green),
                  );
                }),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      return phoneAuthController.isOtpVerified.value == false
                          ? Container()
                          : (phoneAuthController.isCreatingPin.value
                              ? const ButtonLoadingAnimation()
                              : SolhGreenButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      bool response =
                                          await phoneAuthController.createMpin(
                                              phoneAuthController.countryCode +
                                                  phoneAuthController
                                                      .phoneNumber.text,
                                              newPinController.text.trim());

                                      if (response) {
                                        Utility.showToast(
                                            'New pin created successfully');
                                        await Prefs.setString(
                                          "phone",
                                          phoneAuthController.countryCode +
                                              phoneAuthController
                                                  .phoneNumber.text,
                                        );
                                        await isNewUser();

                                        if (context.mounted) {
                                          Navigator.of(context)
                                              .pushNamed(AppRoutes.master);
                                        }
                                      }
                                    }
                                  },
                                  width: 70.w,
                                  child: Text('Create mPIN',
                                      style: SolhTextStyles.CTA
                                          .copyWith(color: SolhColors.white))));
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
