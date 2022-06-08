import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/profile-setup/anonymous/pick_user_name_screen.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import '../../../../controllers/profile/anon_controller.dart';
import '../../../../widgets_constants/constants/textstyles.dart';

class AnonLandingPage extends StatelessWidget {
  AnonLandingPage({Key? key}) : super(key: key);
  AnonController anomymousController = Get.find();

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
                "Your profile is ready!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
              Text(
                "If you want to maintain your privacy, select the 'Anonymous' option.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFA6A6A6), fontSize: 16),
              ),
              SizedBox(height: 35.h),
              SolhGreenButton(
                  child: Text("Lets Go"),
                  height: 6.h,
                  onPressed: () {
                    anomymousController.createAnonProfile();
                    AutoRouter.of(context).pushAndPopUntil(MasterScreenRouter(),
                        predicate: (value) => false);
                  }),
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
