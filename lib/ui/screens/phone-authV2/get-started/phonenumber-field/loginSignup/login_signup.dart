import 'package:flutter/cupertino.dart';

import 'package:solh/ui/screens/phone-authV2/get-started/phonenumber-field/phone_auth_common_widget.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class LoginSignup extends StatelessWidget {
  LoginSignup({Key? key, required Map<dynamic, dynamic> args})
      : _isLogin = args['isLogin'],
        super(key: key);

  final bool _isLogin;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldWithBackgroundArt(
        appBar: SolhAppBarTanasparentOnlyBackButton(
          onBackButton: (() => Navigator.of(context).pop()),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isLogin ? 'Login' : 'Signup',
                style: SolhTextStyles.Large2BlackTextS24W7,
              ),
              const SizedBox(
                height: 32,
              ),
              PhoneAuthCommonWidget(
                isLogin: _isLogin,
              )
            ],
          ),
        ),
      ),
    );
  }
}
