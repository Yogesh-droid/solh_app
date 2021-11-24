import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ProfileCreated extends StatelessWidget {
  const ProfileCreated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Your profile has been created",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            Text(
              "You can also create an anonymous profile to hide your identity",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFA6A6A6), fontSize: 16),
            ),
            SizedBox(height: 40.h),
            SolhGreenButton(
              child: Text("Lets Go"),
              height: 6.h,
            ),
            SizedBox(
              height: 1.h,
            ),
            SolhGreenBorderButton(
              child: Text(
                "Create Anonymous",
                style: SolhTextStyles.GreenBorderButtonText,
              ),
              height: 6.h,
            ),
            SizedBox(
              height: 8.h,
            ),
          ],
        ),
      ),
    );
  }
}
