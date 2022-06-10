import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';

import '../../../bloc/journals/user-journal-bloc.dart';
import '../../../routes/routes.gr.dart';
import '../../../services/controllers/otp_verification_controller.dart';
import '../../../services/firebase/auth.dart';
import '../../../services/user/session-cookie.dart';
import '../../../widgets_constants/constants/colors.dart';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen(
      {Key? key, required String phoneNo, required String verificationId})
      : _phoneNo = phoneNo,
        _verificationId = verificationId,
        super(key: key);
  final String _phoneNo;
  final String _verificationId;

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  OtpVerificationController otpVerificationController = Get.find();
  final scaffoldKey = GlobalKey();
  //late OTPTextEditController controller;
  //late OTPInteractor _otpInteractor;
  String codeValue = "";

  @override
  void initState() {
    getSms();
    super.initState();
    // _otpInteractor = OTPInteractor();
    // _otpInteractor
    //     .getAppSignature()
    //     //ignore: avoid_print
    //     .then((value) => print('signature - $value'));

    // controller = OTPTextEditController(
    //   codeLength: 6,
    //   //ignore: avoid_print
    //   onCodeReceive: (code) => print('Your Application receive code - $code'),
    //   otpInteractor: _otpInteractor,
    // )..startListenUserConsent(
    //     (code) {
    //       final exp = RegExp(r'(\d{6})');
    //       return exp.stringMatch(code ?? '') ?? '';
    //     },
    //     strategies: [
    //       //SampleStrategy(),
    //     ],
    //   );
    //listenOtp();
  }

  Future<void> getSms() async {
    try {
      String? commingSms = await AltSmsAutofill().listenForSms;
      if (commingSms != null) {
        print(commingSms);
        _otpController.text = commingSms.substring(0, 6);
      }
    } catch (e) {
      String commingSms = 'Failed to get Sms.';
    }
  }

  bool isLoading = false;

  @override
  void dispose() {
    //SmsAutoFill().unregisterListener();
    AltSmsAutofill().unregisterListener();
    print("unregisterListener");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(
          primaryTitle: "Verify Phone No.",
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
                  controller: _otpController,
                  appContext: context,
                  onChanged: (String value) {},
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                      inactiveColor: SolhColors.black,
                      activeColor: SolhColors.green,
                      selectedColor: SolhColors.green),
                  length: 6,
                  onCompleted: (String value) async {
                    isLoading = true;
                    setState(() {});
                    print(widget._verificationId);
                    print("smscode: ${_otpController.text}");
                    PhoneAuthCredential _phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: widget._verificationId,
                            smsCode: _otpController.text);

                    await FirebaseNetwork.signInWithPhoneCredential(
                            _phoneAuthCredential)
                        .then((value) async {
                      String idToken = await value.user!.getIdToken();
                      print("user idToken: $idToken");
                      bool isSessionCookieCreated =
                          await SessionCookie.createSessionCookie(idToken);
                      print(isSessionCookieCreated);
                      print("checking is profile created");
                      bool isProfileCreated =
                          await userBlocNetwork.isProfileCreated();
                      print("profile checking complete");
                      print("^" * 30 +
                          "Is Profile Created:" +
                          isProfileCreated.toString() +
                          "^" * 30);
                      isProfileCreated
                          ? AutoRouter.of(context).pushAndPopUntil(
                              MasterScreenRouter(),
                              predicate: (value) => false)
                          : AutoRouter.of(context).pushAndPopUntil(
                              CreateProfileScreenRouter(),
                              predicate: (value) => false);
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
                    InkWell(onTap: () {}, child: TimerWidget())
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
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

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
      setState(() {});
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
    print('build');
    return Text(
      time == 0 ? 'Resend code' : time.toString(),
      style: TextStyle(fontSize: 14),
    );
  }
}
