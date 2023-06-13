import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class GetStartedScreen extends StatelessWidget {
  GetStartedScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldWithBackgroundArt(
        body: SizedBox(
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Solh Wellness',
                    style: SolhTextStyles.QS_head_4_1.copyWith(
                        color: SolhColors.primary_green),
                  ),
                  SizedBox(
                    width: 60.w,
                    child: Text(
                      'Clear your Mind. Find Happiness in Chaos. Seek Solh Within.'
                          .tr,
                      style: SolhTextStyles.QS_body_2_semi.copyWith(
                          color: SolhColors.dark_grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Image(
                  image:
                      AssetImage('assets/images/Get_the_help_you_deserve.png')),
              Column(
                children: [
                  SolhGreenButton(
                    width: 80.w,
                    child: Text('Get Started'.tr),
                    onPressed: () => Navigator.pushNamed(
                        context, AppRoutes.loginSignup,
                        arguments: {
                          'isLogin': false,
                        }),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Already have an account? '.tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                        TextSpan(
                            text: 'Login',
                            style: SolhTextStyles.NormalTextGreenS14W5,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pushNamed(
                                      context, AppRoutes.loginSignup,
                                      arguments: {
                                        'isLogin': true,
                                      }))
                      ])),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
