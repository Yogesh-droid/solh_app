import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/firebase/auth.dart';
import 'package:solh/ui/screens/phone-authV2/phone-auth-controller/phone_auth_controller.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/privacy_web.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

import '../../../../../controllers/getHelp/search_market_controller.dart';

// ignore: must_be_immutable
class PhoneAuthCommonWidget extends StatelessWidget {
  PhoneAuthCommonWidget({Key? key, required this.isLogin}) : super(key: key);

  final PhoneAuthController phoneAuthController =
      Get.put(PhoneAuthController());

  final FirebaseNetwork firebaseNetwork = FirebaseNetwork();
  String? _countryCode = '+91';
  // String? country = 'IN';

  final isLogin;

  signInWithPhoneNumber(context, String country) async {
    await phoneAuthController.login(
        phoneAuthController.countryCode, phoneAuthController.phoneNumber.text);

    if (phoneAuthController.map['success']) {
      log(phoneAuthController.map['message']);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('userCountry', country);
      Get.find<SearchMarketController>().country = country;
      Navigator.pushNamed(context, AppRoutes.otpVerification, arguments: {
        "phoneNumber": phoneAuthController.phoneNumber.text,
        "dialCode": phoneAuthController.countryCode
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(phoneAuthController.map['message'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text('Country'.tr),
                const SizedBox(
                  height: 5,
                ),
                SolhCountryCodePicker(onCountryChange: ((countryCode) {
                  print(countryCode.dialCode);
                  _countryCode = countryCode.dialCode;
                  phoneAuthController.country = countryCode.code ?? 'IN';
                  phoneAuthController.countryCode = countryCode.dialCode!;
                }))
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mobile No.'.tr),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: phoneAuthController.phoneNumber,
                    decoration: TextFieldStyles.greenF_greyUF_4R.copyWith(
                        hintText: 'Your mobile no.',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 10)),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 80.w,
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              // Obx(() {
              //   return
              // phoneAuthController.isRequestingAuth.value
              //     ? SolhGreenBorderButton(
              //         child: ButtonLoadingAnimation(
              //           ballColor: SolhColors.primary_green,
              //           ballSizeLowerBound: 3,
              //           ballSizeUpperBound: 8,
              //         ),
              //       )
              //     :
              Obx(() {
                return phoneAuthController.isCheckingForMpin.value
                    ? SolhGreenBorderButton(
                        child: const ButtonLoadingAnimation(
                          ballColor: SolhColors.primary_green,
                          ballSizeLowerBound: 3,
                          ballSizeUpperBound: 8,
                        ),
                      )
                    : SolhGreenButton(
                        width: double.maxFinite,
                        onPressed: (() async {
                          if (phoneAuthController.phoneNumber.text
                              .trim()
                              .isEmpty) {
                            SolhSnackbar.error(
                                'Opps !!', 'Enter a valid number');
                          } else {
                            bool doesMpinExist = await phoneAuthController
                                .isMpinSet(phoneAuthController.countryCode +
                                    phoneAuthController.phoneNumber.text
                                        .trim());

                            if (doesMpinExist) {
                              if (context.mounted) {
                                Navigator.pushNamed(
                                    context, AppRoutes.enterMpinScreen,
                                    arguments: {
                                      'phoneNumber': phoneAuthController
                                              .countryCode +
                                          phoneAuthController.phoneNumber.text
                                              .trim()
                                    });
                              }
                            } else {
                              if (context.mounted) {
                                signInWithPhoneNumber(context,
                                    phoneAuthController.country ?? 'IN');
                              }
                            }
                          }
                        }),
                        child: Text(
                          'Continue'.tr,
                        ),
                      );
              }),
              // }),
              SizedBox(
                height: 1.h,
              ),
              RichText(
                text: TextSpan(
                    text:
                        'By Clicking Signing ${isLogin ? 'in' : 'up'} you agree to our',
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Terms of services ',
                          style: Theme.of(context).textTheme.bodyLarge,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PrivacyWeb(
                                          title: 'Terms of services',
                                          url:
                                              "https://solhapp.com/termsandcondition.html",
                                        )))),
                      TextSpan(
                          text: '& Privacy Policies ',
                          style: Theme.of(context).textTheme.bodyLarge,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PrivacyWeb(
                                          title: 'Privacy policy',
                                          url:
                                              "https://solhapp.com/privacypolicy.html",
                                        ))))
                    ]),
              ),
              SizedBox(
                height: 10.h,
              ),
              // SocialLoginRow()
            ],
          ),
        )
      ],
    );
  }
}

class SolhCountryCodePicker extends StatelessWidget {
  const SolhCountryCodePicker({
    Key? key,
    required Function(CountryCode) onCountryChange,
  })  : _onCountryChange = onCountryChange,
        super(key: key);

  final Function(CountryCode) _onCountryChange;

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      showFlag: true,
      builder: (CountryCode? countryCode) {
        return Container(
          height: MediaQuery.of(context).size.height / 15,
          decoration: BoxDecoration(
              color: SolhColors.white,
              border: Border.all(color: SolhColors.black666),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height / 100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${countryCode!.dialCode}',
                style: const TextStyle(color: SolhColors.primary_green),
              ),
              const Icon(
                CupertinoIcons.chevron_down,
                size: 15,
                color: SolhColors.primary_green,
              )
            ],
          ),
        );
      },
      showDropDownButton: true,
      showFlagDialog: true,
      showFlagMain: false,

      onChanged: _onCountryChange,
      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
      initialSelection: 'IN',
      // optional. Shows only country name and flag when popup is closed.
      showOnlyCountryWhenClosed: false,
      showCountryOnly: false,
      // optional. aligns the flag and the Text left
      alignLeft: true,
    );
  }
}

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
                child: Divider(
              thickness: 1.5,
            )),
            SizedBox(
              width: 1.w,
            ),
            const Text('Or'),
            SizedBox(
              width: 1.w,
            ),
            const Expanded(
                child: Divider(
              thickness: 1.5,
            ))
          ],
        ),
        SizedBox(
          height: 3.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SocialLoginContainer(
              socialLogInValue: SocialLogInValue.Google,
              signInCallBack: () {},
              assetPath: 'assets/images/google.png',
            ),
            SocialLoginContainer(
              socialLogInValue: SocialLogInValue.Google,
              signInCallBack: () {},
              assetPath: 'assets/images/facebook.png',
            ),
            SocialLoginContainer(
              socialLogInValue: SocialLogInValue.Google,
              signInCallBack: () {},
              assetPath: 'assets/images/apple.png',
            )
          ],
        ),
      ],
    );
  }
}

class SocialLoginContainer extends StatelessWidget {
  const SocialLoginContainer({
    Key? key,
    required this.socialLogInValue,
    required Callback this.signInCallBack,
    required String this.assetPath,
  }) : super(key: key);

  final SocialLogInValue socialLogInValue;
  final Callback signInCallBack;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SolhColors.white,
        border: Border.all(color: SolhColors.primary_green, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 3),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Image(image: AssetImage(assetPath)),
        ),
      ),
    );
  }
}

enum SocialLogInValue {
  Google,
  FaceBook,
  Apple,
}
