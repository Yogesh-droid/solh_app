import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/services/firebase/auth.dart';
import 'package:solh/services/shared-prefrences/session-cookie.dart';
import 'package:solh/services/user/session-cookie.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

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
                          ? AutoRouter.of(context).push(MasterScreenRouter())
                          : AutoRouter.of(context)
                              .push(CreateProfileScreenRouter());
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())));
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '''Didn’t recieve a code?  ''',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    InkWell(onTap: () {}, child: Text("Resend Code"))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
