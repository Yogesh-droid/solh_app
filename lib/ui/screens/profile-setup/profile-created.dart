import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/ui/screens/profile-setup/anonymous/pick_user_name_screen.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';

import '../../../widgets_constants/constants/textstyles.dart';

class ProfileCreated extends StatelessWidget {
  const ProfileCreated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
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
              SizedBox(height: 35.h),
              SolhGreenButton(
                child: Text("Lets Go"),
                height: 6.h,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.master),
              ),
              SizedBox(
                height: 1.h,
              ),
              SolhGreenBorderButton(
                child: Text(
                  "Create Anonymous",
                  style: SolhTextStyles.GreenBorderButtonText,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PickUsernameScreen()));
                },
                height: 6.h,
              ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
