import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/firebase/auth.dart';
import 'package:solh/services/user/session-cookie.dart';
import 'package:solh/ui/screens/phone-authV2/phone-auth-controller/phone_auth_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({Key? key, required Map<dynamic, dynamic> args})
      : _phoneNumber = args['phoneNumber'],
        _verificationId = args['verificationId'],
        super(key: key);

  final String _phoneNumber;
  final String? _verificationId;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundArt(
      appBar: SolhAppBarTanasparentOnlyBackButton(
        onBackButton: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            VerifyPhoneNo(phoneNumber: _phoneNumber),
            SizedBox(
              height: 6.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 1.w,
                ),
                Expanded(child: OtpField(verificationId: _verificationId)),
                SizedBox(
                  width: 1.w,
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            ResendButton(),
            SizedBox(
              height: 5.h,
            ),
            SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class VerifyPhoneNo extends StatelessWidget {
  const VerifyPhoneNo({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify Phone No.',
          style: SolhTextStyles.Large2BlackTextS24W7,
        ),
        RichText(
          text: TextSpan(
            text: 'Please enter the 6 digit OTP sent to ',
            style: Theme.of(context).textTheme.bodyMedium,
            children: <TextSpan>[
              TextSpan(
                text: phoneNumber,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OtpField extends StatefulWidget {
  OtpField({Key? key, required this.verificationId}) : super(key: key);
  final verificationId;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  final PhoneAuthController phoneAuthController = Get.find();
  static final facebookAppEvents = FacebookAppEvents();

  String otp = '';

  String? utm_medium;

  String? utm_source;

  String? utm_name;

  @override
  void dispose() {
    // TODO: implement dispose
    // phoneAuthController.otpCode.clear();
    phoneAuthController.isRequestingAuth.value = false;

    phoneAuthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      keyboardType: TextInputType.number,
      length: 6,
      controller: phoneAuthController.otpCode,
      onChanged: (value) {},
      pinTheme: PinTheme(
          inactiveColor: SolhColors.grey_2,
          borderWidth: 1,
          activeColor: SolhColors.primary_green,
          shape: PinCodeFieldShape.box,
          selectedColor: SolhColors.primary_green),
      onCompleted: (String value) async {
        phoneAuthController.isRequestingAuth.value = true;

        PhoneAuthCredential _phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: widget.verificationId,
            smsCode: phoneAuthController.otpCode.text
            // otpVerificationController.otpController.text
            );

        await FirebaseNetwork.signInWithPhoneCredential(_phoneAuthCredential)
            .then((value) async {
          String? idToken = await value.user!.getIdToken();
          print("user idToken: $idToken");
          String? fcmToken = await FirebaseMessaging.instance.getToken();
          String oneSignalId = '';
          String deviceType = '';
          await OneSignal.shared.getDeviceState().then((value) {
            print(value!.userId);
            oneSignalId = value.userId ?? '';

            FirebaseAnalytics.instance.logLogin(
                loginMethod: 'PhoneAuth',
                callOptions: AnalyticsCallOptions(global: true));
          });
          if (Platform.isAndroid) {
            deviceType = 'Android';
          } else {
            deviceType = 'IOS';
          }

          await initDynamic();

          bool? isSessionCookieCreated =
              await SessionCookie.createSessionCookie(
                  idToken!, fcmToken, oneSignalId, deviceType,
                  utm_medium: utm_medium,
                  utm_compaign: utm_name,
                  utm_source: utm_source);
          log(isSessionCookieCreated.toString(),
              name: "isSessionCookieCreated");
          ProfileController profileController = Get.put(ProfileController());
          await profileController.getMyProfile();
          print(isSessionCookieCreated);
          print("checking is profile created");
          log("${await userBlocNetwork.isProfileCreated()}",
              name: "isProfileCreated");
          bool isProfileCreated = isSessionCookieCreated != null
              ? await userBlocNetwork.isProfileCreated() &&
                  !isSessionCookieCreated
              : false;

          print("profile checking complete");
          print("^" * 30 +
              "Is Profile Created:" +
              isProfileCreated.toString() +
              "^" * 30);
          if (isProfileCreated) {
            Navigator.pushNamed(context, AppRoutes.master);
          } else {
            facebookAppEvents.logEvent(
              name: 'signup',
              parameters: {
                'method': 'Phone Auth',
              },
            );
            //// .  Firebase Signup event //////
            FirebaseAnalytics.instance.logSignUp(signUpMethod: 'PhoneAuth');
            Navigator.pushNamed(context, AppRoutes.nameField);

            ////////////////////
          }
        }).onError((error, stackTrace) {
          phoneAuthController.isRequestingAuth.value = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      },
    );
  }

  Future<void> initDynamic() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      print(data.toString() + '   This is data');
      print(data.link.data.toString() + '   This is data');
      print(data.link.query.toString() + '   This is data');
      print(data.link.queryParameters.toString() + '   This is data');
      print(data.utmParameters.toString() + '   This is data');
      print('${data.utmParameters}' + '   This is UTM');
      utm_name = data.utmParameters['utm_campaign'];
      utm_source = data.utmParameters['utm_source'];
      utm_medium = data.utmParameters['utm_medium'];

      final Uri? deepLink = data.link;

      if (deepLink != null) {
        print(deepLink.path);
        print(deepLink);
        print(deepLink.data);
        // Utility.showToast(data!.link.query);
        // Navigator.pushNamed(context, deepLink.path);
      }

      FirebaseDynamicLinks.instance.onLink.listen((event) {
        // Utility.showToast(data!.link.query);
        if (deepLink != null) {
          print(deepLink.toString() + ' This is link');
          print(deepLink.path + ' This is link');
          print(deepLink.data.toString() + ' This is link');
          print(event.utmParameters.toString() + ' This is link');
        }

        // Navigator.pushNamed(context, event.link.path);
      }).onError((error) {
        print(error.message);
      });
    }
  }
}

class ResendButton extends StatelessWidget {
  const ResendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          "Did not receive an OTP?  ",
          style: SolhTextStyles.SmallTextGrey1S12W5,
        ),
        TimerWidget(),
      ],
    );
  }
}

class SubmitButton extends StatelessWidget {
  SubmitButton({Key? key}) : super(key: key);
  final PhoneAuthController phoneAuthController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return phoneAuthController.isRequestingAuth.value
          ? MyLoader()
          : Container();
    });
  }
}

class TimerWidget extends StatefulWidget {
  TimerWidget({Key? key, this.phoneNo}) : super(key: key);
  final String? phoneNo;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int time = 60;

  int timeManager() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      time--;
      if (time == 0) {
        timer.cancel();
      }
      if (mounted) setState(() {});
    });
    return time;
  }

  @override
  void initState() {
    timeManager();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FirebaseNetwork().resendOtp(
          widget.phoneNo ?? '',
        );
      },
      child: Text(
        time == 0 ? 'Resend code' : time.toString(),
        style: SolhTextStyles.SmallTextGreen1S12W5,
      ),
    );
  }
}
