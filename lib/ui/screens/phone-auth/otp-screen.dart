import 'dart:async';
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
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import '../../../bloc/user-bloc.dart';
import '../../../services/firebase/auth.dart';
import '../../../services/user/session-cookie.dart';
import '../../../widgets_constants/constants/colors.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({Key? key, required Map<dynamic, dynamic> args})
      : _phoneNo = args['phoneNo'],
        _verificationId = args['verificationId'],
        super(key: key);
  final String _phoneNo;
  final String _verificationId;

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  // OtpVerificationController otpVerificationController = Get.find();
  static final facebookAppEvents = FacebookAppEvents();

  final scaffoldKey = GlobalKey();
  String? utm_medium;
  String? utm_source;
  String? utm_name;
  @override
  void initState() {
    super.initState();
    // otpVerificationController.otpController = TextEditingController();
  }

  bool isLoading = false;

  @override
  void dispose() {
    print("unregisterListener");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(
          primaryTitle: "Verify your number",
          secondaryTitle: "Please enter the 6 digit code sent to"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget._phoneNo),
          Container(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PinCodeTextField(
                  // controller: otpVerificationController.otpController,
                  appContext: context,

                  onChanged: (String value) {},
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                      inactiveColor: SolhColors.black,
                      activeColor: SolhColors.primary_green,
                      selectedColor: SolhColors.primary_green),
                  length: 6,
                  onCompleted: (String value) async {
                    isLoading = true;
                    setState(() {});
                    print(widget._verificationId);
                    print("smscode: ${_otpController.text}");
                    PhoneAuthCredential _phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: widget._verificationId, smsCode: ''
                            // otpVerificationController.otpController.text
                            );

                    await FirebaseNetwork.signInWithPhoneCredential(
                            _phoneAuthCredential)
                        .then((value) async {
                      String idToken = await value.user!.getIdToken();
                      print("user idToken: $idToken");
                      String? fcmToken =
                          await FirebaseMessaging.instance.getToken();
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

                      bool isSessionCookieCreated =
                          await SessionCookie.createSessionCookie(
                              idToken, fcmToken, oneSignalId, deviceType,
                              utm_medium: utm_medium,
                              utm_compaign: utm_name,
                              utm_source: utm_source);

                      print(isSessionCookieCreated);
                      print("checking is profile created");
                      bool isProfileCreated =
                          await userBlocNetwork.isProfileCreated() &&
                              !isSessionCookieCreated;
                      print("profile checking complete");
                      print("^" * 30 +
                          "Is Profile Created:" +
                          isProfileCreated.toString() +
                          "^" * 30);
                      if (isProfileCreated) {
                        ProfileController profileController =
                            Get.put(ProfileController());
                        await profileController.getMyProfile();
                        Navigator.pushNamed(context, AppRoutes.master);
                      } else {
                        facebookAppEvents.logEvent(
                          name: 'signup',
                          parameters: {
                            'method': 'Phone Auth',
                          },
                        );
                        //// .  Firebase Signup event //////
                        FirebaseAnalytics.instance
                            .logSignUp(signUpMethod: 'PhoneAuth');
                        Navigator.pushNamed(context, AppRoutes.createProfile);

                        ////////////////////
                      }
                    }).onError((error, stackTrace) {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())));
                    });
                  },
                ),
                /* TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: controller,
                ), */

                // PinFieldAutoFill(
                //   currentCode: codeValue,
                //   codeLength: 6,
                //   onCodeChanged: (code) {
                //     print("onCodeChanged $code");
                //     setState(() {
                //       codeValue = code.toString();
                //     });
                //   },
                //   onCodeSubmitted: (val) async {
                //     print("onCodeSubmitted $val");
                //     PhoneAuthCredential _phoneAuthCredential =
                //         PhoneAuthProvider.credential(
                //             verificationId: widget._verificationId,
                //             smsCode:
                //                 _otpController.text);

                //     await FirebaseNetwork.signInWithPhoneCredential(
                //             _phoneAuthCredential)
                //         .then((value) async {
                //       String idToken = await value.user!.getIdToken();
                //       print("user idToken: $idToken");
                //       bool isSessionCookieCreated =
                //           await SessionCookie.createSessionCookie(idToken);
                //       print(isSessionCookieCreated);
                //       print("checking is profile created");
                //       bool isProfileCreated =
                //           await userBlocNetwork.isProfileCreated();
                //       print("profile checking complete");
                //       print("^" * 30 +
                //           "Is Profile Created:" +
                //           isProfileCreated.toString() +
                //           "^" * 30);
                //       isProfileCreated
                //           ? AutoRouter.of(context).pushAndPopUntil(
                //               MasterScreenRouter(),
                //               predicate: (value) => false)
                //           : AutoRouter.of(context).pushAndPopUntil(
                //               CreateProfileScreenRouter(),
                //               predicate: (value) => false);
                //     }).onError((error, stackTrace) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(content: Text(error.toString())));
                //     });
                //   },
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '''Didn’t receive a code?  ''',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    InkWell(
                        onTap: () {},
                        child: TimerWidget(
                          phoneNo: widget._phoneNo,
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                isLoading ? CircularProgressIndicator() : Container()
              ],
            ),
          ),
        ],
      ),
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
      setState(() {});

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
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            time == 0 ? 'Resend code' : time.toString(),
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
