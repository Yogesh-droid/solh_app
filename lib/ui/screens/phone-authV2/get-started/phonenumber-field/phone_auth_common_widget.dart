import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/services/firebase/auth.dart';
import 'package:solh/ui/screens/phone-authV2/phone-auth-controller/phone_auth_controller.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

class PhoneAuthCommonWidget extends StatelessWidget {
  PhoneAuthCommonWidget({Key? key, required this.isLogin}) : super(key: key);

  final PhoneAuthController phoneAuthController =
      Get.put(PhoneAuthController());

  FirebaseNetwork firebaseNetwork = FirebaseNetwork();

  final isLogin;

  signInWithPhoneNumber(
    context,
  ) {
    phoneAuthController.isRequestingAuth.value = true;
    firebaseNetwork.signInWithPhoneNumber(
      context,
      phoneAuthController.countryCode + phoneAuthController.phoneNumber.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text('Country'),
                SizedBox(
                  height: 5,
                ),
                SolhCountryCodePicker(onCountryChange: ((countryCode) {
                  print(countryCode.dialCode);
                  phoneAuthController.countryCode = countryCode.dialCode!;
                }))
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mobile No.'),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: phoneAuthController.phoneNumber,
                    decoration: TextFieldStyles.greenF_greyUF_4R(
                        hintText: 'Your mobile no.'),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 80.w,
          child: Column(
            children: [
              Obx(() {
                return phoneAuthController.isRequestingAuth.value
                    ? SolhGreenBorderButton(
                        child: ButtonLoadingAnimation(
                          ballColor: SolhColors.primary_green,
                          ballSizeLowerBound: 3,
                          ballSizeUpperBound: 8,
                        ),
                      )
                    : SolhGreenButton(
                        child: Text(
                          'Continue',
                        ),
                        onPressed: (() => signInWithPhoneNumber(context)),
                      );
              }),
              SizedBox(
                height: 1.h,
              ),
              RichText(
                text: TextSpan(
                    text:
                        'By Signing ${isLogin ? 'in' : 'up'} you agree to our',
                    style: Theme.of(context).textTheme.bodyText2,
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Terms of service & Privicy Policies ',
                        style: Theme.of(context).textTheme.bodyText1,
                      )
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
              border: Border.all(color: SolhColors.black666),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height / 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${countryCode!.dialCode}',
                style: TextStyle(color: SolhColors.primary_green),
              ),
              Icon(
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
            Expanded(
                child: Divider(
              thickness: 1.5,
            )),
            SizedBox(
              width: 1.w,
            ),
            Text('Or'),
            SizedBox(
              width: 1.w,
            ),
            Expanded(
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
